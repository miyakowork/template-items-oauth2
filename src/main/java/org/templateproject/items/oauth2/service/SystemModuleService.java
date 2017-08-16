package org.templateproject.items.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.items.oauth2.entity.ISystemModule;
import org.templateproject.items.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.items.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.items.oauth2.support.pojo.bo.SystemModuleBo;
import org.templateproject.items.oauth2.support.pojo.bo.ZTreeBO;
import org.templateproject.items.oauth2.support.pojo.vo.SystemModuleVO;
import org.templateproject.pojo.page.Page;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhangteng on 2017/7/14.
 * 系统模块表 service
 */
@Service
@Transactional
@SqlMapper("system_module")
public class SystemModuleService extends SimpleBaseCrudService<ISystemModule, Integer> {

    /**
     * 查询systemModule当前页面数据
     *
     * @param page           page
     * @param systemModuleBo 查询控件参数对象
     * @return page
     */
    public Page<SystemModuleVO> findSystemModulePage(Page<SystemModuleVO> page, SystemModuleBo systemModuleBo) {
        return findPagination(page, SystemModuleVO.class, sql(), systemModuleBo);
    }

    /**
     * 表面上是删除其实是更新一个enabled字段为0
     *
     * @param ids ids
     * @throws Exception e
     */
    public void deleteModules(String[] ids) throws Exception {
        executeBatch(sql(), "id", ids);
    }

    /**
     * @return 查找所有可用的系统模块
     */
    public List<ISystemModule> findAllEnabledSystemModules() {
        return mysql.findListBeanByArray(sql(), ISystemModule.class);
    }


    /**
     * module转zTree
     *
     * @param systemModules systemModules
     * @return List<ZTreeBO>
     */
    public List<ZTreeBO<String>> module2ZTree(List<ISystemModule> systemModules) {
        List<ZTreeBO<String>> zTreeBOList = new ArrayList<>(systemModules.size());
        for (ISystemModule iSystemModule : systemModules) {
            ZTreeBO<String> zTreeBO = new ZTreeBO<>();
            zTreeBO.setId(iSystemModule.getId().toString());
            zTreeBO.setpId("0");
            zTreeBO.setName(iSystemModule.getName());
            zTreeBO.setOther(iSystemModule.getSystemCode());
            zTreeBOList.add(zTreeBO);
        }
        return zTreeBOList;
    }

    /**
     * 查询是否已经有存在的system code
     *
     * @param systemCode 系统代码
     * @return 是否存在
     */
    public boolean isExistSystemCode(String systemCode) {
        long cnt = mysql.queryNumberByArray(sql(), Long.class, systemCode);
        return cnt > 0;
    }

}
