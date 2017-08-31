package me.wuwenbin.items.oauth2.service;

import me.wuwenbin.items.oauth2.entity.IPrivilegeOperation;
import me.wuwenbin.items.oauth2.service.base.SimpleBaseCrudService;
import me.wuwenbin.items.oauth2.support.pojo.bo.PrivilegeOperationBO;
import me.wuwenbin.items.oauth2.support.pojo.vo.PrivilegeOperationVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.pojo.page.Page;

/**
 * created by Wuwenbin on 2017/8/22 at 15:49
 */
@Service
@Transactional
public class PrivilegeOperationService extends SimpleBaseCrudService<IPrivilegeOperation, Integer> {

    public Page<PrivilegeOperationVO> findPrivilegeOperationPage(Page<PrivilegeOperationVO> page, PrivilegeOperationBO privilegeOperationBO) {
        String sql = "SELECT topo.*,tor.url,tor.name AS resourceName,topp.name AS privilegePageName,toopt.name AS operationTypeName" +
                " FROM t_oauth_privilege_operation topo" +
                " LEFT JOIN t_oauth_resource tor ON tor.id=topo.resource_id " +
                " LEFT JOIN t_oauth_privilege_page topp ON topp.id=topo.page_privilege_id" +
                " LEFT JOIN t_oauth_operation_privilege_type toopt ON toopt.id=topo.operation_type_id";
        return findPagination(page, PrivilegeOperationVO.class, sql, privilegeOperationBO);
    }

    public boolean editPrivilegeOperationName(String id, String operationName) throws Exception {
        String sql = "UPDATE t_oauth_privilege_operation SET operation_name = ? WHERE id = ?";
        return mysql.executeArray(sql, operationName, id) == 1;
    }
}
