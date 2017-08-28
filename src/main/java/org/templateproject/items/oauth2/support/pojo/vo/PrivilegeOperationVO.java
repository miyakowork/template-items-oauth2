package org.templateproject.items.oauth2.support.pojo.vo;

import org.templateproject.items.oauth2.entity.IPrivilegeOperation;

/**
 * created by Wuwenbin on 2017/8/22 at 15:52
 */
public class PrivilegeOperationVO extends IPrivilegeOperation {

    private String privilegePageName;
    private String operationTypeName;
    private String resourceName;
    private String url;

    public String getPrivilegePageName() {
        return privilegePageName;
    }

    public void setPrivilegePageName(String privilegePageName) {
        this.privilegePageName = privilegePageName;
    }

    public String getOperationTypeName() {
        return operationTypeName;
    }

    public void setOperationTypeName(String operationTypeName) {
        this.operationTypeName = operationTypeName;
    }

    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
