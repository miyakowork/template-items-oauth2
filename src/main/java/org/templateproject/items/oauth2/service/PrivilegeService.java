package org.templateproject.items.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.items.oauth2.entity.IPrivilegeOperation;
import org.templateproject.items.oauth2.entity.IPrivilegePage;
import org.templateproject.items.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.items.oauth2.support.pojo.bo.ZTreeBO;

import java.util.*;

/**
 * Created by wuwenbin on 2017/8/21.
 */
@Service
@Transactional
public class PrivilegeService extends SimpleBaseCrudService {

    /**
     * 异步获取的权限资源树
     *
     * @param resourceModuleId
     * @param roleId
     * @return
     */
    public List<ZTreeBO<String>> getPrivilegeData(String resourceModuleId, String roleId) {
        // 通过resourceModuleId找到对应的页面权限资源
        String privilegePageSql = "SELECT * FROM t_oauth_privilege_page WHERE resource_module_id = ?";
        List<IPrivilegePage> privilegePageList = mysql.findListBeanByArray(privilegePageSql, IPrivilegePage.class, resourceModuleId);

        // 获取role_id对应的所有的resource_id
        String roleResourceSql = "SELECT resource_id FROM t_oauth_role_resource WHERE role_id = ? AND enabled = 1";
        List<Map<String, Object>> roleResourceList = mysql.findListMapByArray(roleResourceSql, roleId);

        List<ZTreeBO<String>> pagePrivilegeTree = new LinkedList<>();
        // page_privilege层次
        for (IPrivilegePage privilegePage : privilegePageList) {
            ZTreeBO<String> pageTree = new ZTreeBO<>();
            pageTree.setId(privilegePage.getId().toString());
            pageTree.setName(privilegePage.getName());
            pageTree.setOpen(true);
            pageTree.setpId(privilegePage.getResourceModuleId());
            pageTree.setResourceId(privilegePage.getResourceId().toString());
            pageTree.setisParent(false);
            pageTree.setOther("page_privilege");
            for (Map<String, Object> roleResource : roleResourceList) {
                String hasResourceId = roleResource.get("resource_id").toString();
                if (hasResourceId.equals(privilegePage.getResourceId().toString())) {
                    pageTree.setChecked(true);
                }
            }
            pagePrivilegeTree.add(pageTree);

            // 查找页面内的操作级权限
            String privilegeOperationSql = "SELECT * FROM t_oauth_privilege_operation WHERE page_privilege_id = ?";
            List<IPrivilegeOperation> privilegeOperationList = mysql.findListBeanByArray(privilegeOperationSql, IPrivilegeOperation.class, privilegePage.getId());
            for (IPrivilegeOperation privilegeOperation : privilegeOperationList) {
                ZTreeBO<String> operationTree = new ZTreeBO<>();
                operationTree.setId(privilegeOperation.getId().toString());
                operationTree.setName(privilegeOperation.getOperationName());
                operationTree.setOpen(true);
                operationTree.setpId(privilegeOperation.getPagePrivilegeId().toString());
                operationTree.setResourceId(privilegeOperation.getResourceId().toString());
                operationTree.setisParent(false);
                operationTree.setOther("operation_privilege");
                for (Map<String, Object> roleResource : roleResourceList) {
                    String hasResourceId = roleResource.get("resource_id").toString();
                    if (hasResourceId.equals(privilegeOperation.getResourceId().toString())) {
                        operationTree.setChecked(true);
                    }
                }
                pagePrivilegeTree.add(operationTree);
            }
        }
        return pagePrivilegeTree;
    }

    /**
     * 分配权限操作
     *
     * @param resourceIds
     * @param roleId
     * @param checked
     * @throws Exception
     */
    public void setPrivilege(String[] resourceIds, String roleId, boolean checked) throws Exception {
        String sql;
        if (checked) {
            sql = "INSERT INTO t_oauth_role_resource(role_id, resource_id) VALUES (:roleId,:resourceId)";
        } else {
            sql = "DELETE FROM t_oauth_role_resource WHERE role_id = :roleId AND resource_id = :resourceId";
        }
        Collection<Map<String, Object>> maps = new ArrayList<>(resourceIds.length);
        for (String resourceId : resourceIds) {
            Map<String, Object> map = new HashMap<>();
            map.put("resourceId", resourceId);
            map.put("roleId", roleId);
            maps.add(map);
        }
        mysql.executeBatchByCollectionMaps(sql, maps);
    }

}
