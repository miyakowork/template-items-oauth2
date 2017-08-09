package org.templateproject.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.oauth2.entity.OauthResourceModule;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.oauth2.support.pojo.bo.ResModuleBo;
import org.templateproject.oauth2.support.pojo.bo.ZTreeBO;
import org.templateproject.oauth2.support.pojo.vo.ResourceModuleVO;
import org.templateproject.pojo.page.Page;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

/**
 * 继承AbstractBaseCrudService
 * Created by Wuwenbin on 2017/8/08.
 */
@Service
@Transactional
@SqlMapper("res_module")
public class ResModuleService extends SimpleBaseCrudService<OauthResourceModule, Integer> {


    /**
     * 查询Page
     *
     * @param page        page
     * @param resModuleBo 搜索对象
     * @return page
     */
    public Page<ResourceModuleVO> findResModulePage(Page<ResourceModuleVO> page, ResModuleBo resModuleBo) {
        return findPagination(page, ResourceModuleVO.class, sql(), resModuleBo);
    }


    /**
     * 查询ResModuleTree
     *
     * @return list
     */
    public List<OauthResourceModule> findEnabledResModules() {
        return h2Dao.findListBeanByArray(sql(), OauthResourceModule.class);
    }


    /**
     * 將resModule列表转为zTree树对象
     *
     * @param oauthResourceModules 需要转换的resModule
     * @return zTree
     */
    public List<ZTreeBO> resModuleToZtree(Collection<OauthResourceModule> oauthResourceModules) {
        List<ZTreeBO> zTreeList = new LinkedList<>();
        for (OauthResourceModule resModule : oauthResourceModules) {
            ZTreeBO ztree = new ZTreeBO();
            ztree.setId(resModule.getId().toString());
            ztree.setpId("0");
            ztree.setisParent(true);
            ztree.setName(resModule.getName());
            ztree.setOpen(true);
            zTreeList.add(ztree);
        }
        return zTreeList;
    }


}
