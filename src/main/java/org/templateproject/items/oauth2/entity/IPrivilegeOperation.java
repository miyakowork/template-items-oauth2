package org.templateproject.items.oauth2.entity;

import org.templateproject.items.oauth2.entity.base.DataEntity;
import org.templateproject.tools.sqlgen.annotation.SQLTable;

/**
 * Created by zhangteng on 2017/7/12.
 * 操作级权限表
 */
@SQLTable("t_oauth_privilege_operation")
public class IPrivilegeOperation extends DataEntity {


    private String operationName; //操作名称

    private Integer resourceId;   //资源id

    private Integer pagePrivilegeId;  //页面级权限id

    private Integer operationTypeId;  //操作类型id


    public String getOperationName() {
        return operationName;
    }

    public void setOperationName(String operationName) {
        this.operationName = operationName;
    }

    public Integer getResourceId() {
        return resourceId;
    }

    public void setResourceId(Integer resourceId) {
        this.resourceId = resourceId;
    }

    public Integer getPagePrivilegeId() {
        return pagePrivilegeId;
    }

    public void setPagePrivilegeId(Integer pagePrivilegeId) {
        this.pagePrivilegeId = pagePrivilegeId;
    }

    public Integer getOperationTypeId() {
        return operationTypeId;
    }

    public void setOperationTypeId(Integer operationTypeId) {
        this.operationTypeId = operationTypeId;
    }

}
