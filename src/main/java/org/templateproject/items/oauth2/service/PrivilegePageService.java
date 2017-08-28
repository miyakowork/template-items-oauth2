package org.templateproject.items.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.items.oauth2.entity.IPrivilegePage;
import org.templateproject.items.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.items.oauth2.support.pojo.bo.PrivilegePageBo;
import org.templateproject.items.oauth2.support.pojo.vo.PrivilegePageVO;
import org.templateproject.pojo.page.Page;

/**
 * Created by wuwenbin on 2017/8/19.
 * 页面资源表 service
 */
@Service
@Transactional
public class PrivilegePageService extends SimpleBaseCrudService<IPrivilegePage, Integer> {


    /**
     * 根据菜单模块查询此模块下对应的所有页面级权限
     *
     * @param page
     * @param privilegePageBo
     * @return
     * @throws Exception
     */
    public Page<PrivilegePageVO> findPrivilegePagePage(Page<PrivilegePageVO> page, PrivilegePageBo privilegePageBo) throws Exception {
        String sql = "SELECT topp.*, torm.name AS resourceModuleName, tor.name AS resourceName" +
                " FROM T_OAUTH_PRIVILEGE_PAGE topp LEFT JOIN T_OAUTH_RESOURCE_MODULE torm ON topp.resource_module_id = torm.id" +
                " LEFT JOIN T_OAUTH_RESOURCE tor ON topp.RESOURCE_ID = tor.id";
        return findPagination(page, PrivilegePageVO.class, sql, privilegePageBo);
    }


}
