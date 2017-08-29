package me.wuwenbin.items.oauth2.service;

import me.wuwenbin.items.oauth2.entity.ISystemModule;
import me.wuwenbin.items.oauth2.service.base.SimpleBaseCrudService;
import me.wuwenbin.items.oauth2.support.pojo.bo.SystemModuleBo;
import me.wuwenbin.items.oauth2.support.pojo.bo.ZTreeBO;
import me.wuwenbin.items.oauth2.support.pojo.vo.SystemModuleVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.pojo.page.Page;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhangteng on 2017/7/14.
 * 系统模块表 service
 */
@Service
@Transactional
public class SystemModuleService extends SimpleBaseCrudService<ISystemModule, Integer> {

    /**
     * 查询systemModule当前页面数据
     *
     * @param page           page
     * @param systemModuleBo 查询控件参数对象
     * @return page
     */
    public Page<SystemModuleVO> findSystemModulePage(Page<SystemModuleVO> page, SystemModuleBo systemModuleBo) {
        String sql = "SELECT tosm.*, tou1.username AS createUserName, tou2.username AS updateUserName" +
                " FROM t_oauth_system_module tosm, t_oauth_user tou1, t_oauth_user tou2" +
                " WHERE tosm.create_user = tou1.id AND tosm.update_user = tou2.id";
        return findPagination(page, SystemModuleVO.class, sql, systemModuleBo);
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
        String sql = "SELECT count(0) FROM t_oauth_system_module WHERE system_code = ?";
        long cnt = mysql.queryNumberByArray(sql, Long.class, systemCode);
        return cnt > 0;
    }

}
