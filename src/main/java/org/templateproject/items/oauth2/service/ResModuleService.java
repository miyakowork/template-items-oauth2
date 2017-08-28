package org.templateproject.items.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.items.oauth2.entity.IResourceModule;
import org.templateproject.items.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.items.oauth2.support.pojo.bo.ResModuleBo;
import org.templateproject.items.oauth2.support.pojo.bo.ZTreeBO;
import org.templateproject.items.oauth2.support.pojo.vo.ResourceModuleVO;
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
public class ResModuleService extends SimpleBaseCrudService<IResourceModule, Integer> {


    /**
     * 查询Page
     *
     * @param page        page
     * @param resModuleBo 搜索对象
     * @return page
     */
    public Page<ResourceModuleVO> findResModulePage(Page<ResourceModuleVO> page, ResModuleBo resModuleBo) {
        String sql = "SELECT torm.*, tosm.name AS systemModuleName, tou1.username AS create_user_name, tou2.username AS update_user_name" +
                " FROM t_oauth_resource_module torm, t_oauth_user tou1, t_oauth_user tou2, t_oauth_system_module tosm" +
                " WHERE torm.CREATE_USER = tou1.id AND torm.update_user = tou2.id AND tosm.system_code = torm.system_code";
        return findPagination(page, ResourceModuleVO.class, sql, resModuleBo);
    }


    /**
     * 根据系统模块查询所有可用的资源模块
     *
     * @param systemModuleCode
     * @return
     */
    public List<IResourceModule> findEnabledResModulesBySystemModuleCode(String systemModuleCode) {
        String sql = "SELECT * FROM t_oauth_resource_module" +
                " WHERE enabled = 1 AND system_code = ?";
        return mysql.findListBeanByArray(sql, IResourceModule.class, systemModuleCode);
    }

    /**
     * 將resModule列表转为zTree树对象
     *
     * @param iResourceModules 需要转换的resModule
     * @return zTree
     */
    public List<ZTreeBO> resModuleToZTree(Collection<IResourceModule> iResourceModules) {
        List<ZTreeBO> zTreeList = new LinkedList<>();
        for (IResourceModule resModule : iResourceModules) {
            ZTreeBO zTreeBO = new ZTreeBO();
            zTreeBO.setId(resModule.getId().toString());
            zTreeBO.setpId("0");
            zTreeBO.setName(resModule.getName());
            //noinspection unchecked
            zTreeBO.setOther(resModule.getSystemCode());
            zTreeList.add(zTreeBO);
        }
        return zTreeList;
    }


}
