package org.templateproject.items.oauth2.support.pojo.bo;

import org.templateproject.items.oauth2.support.annotation.query.QueryColumn;
import org.templateproject.items.oauth2.support.enumerate.Operator;
import org.templateproject.items.oauth2.support.pojo.BootstrapTableQuery;

/**
 * created by Wuwenbin on 2017/8/22 at 15:58
 */
public class PrivilegeOperationBO extends BootstrapTableQuery {

    @QueryColumn(value = "operation_name")
    private String privilegeOperationName;

    @QueryColumn(value = "page_privilege_id", operation = Operator.EQ)
    private String pagePrivilegeId;

    public String getPrivilegeOperationName() {
        return privilegeOperationName;
    }

    public void setPrivilegeOperationName(String privilegeOperationName) {
        this.privilegeOperationName = privilegeOperationName;
    }

    public String getPagePrivilegeId() {
        return pagePrivilegeId;
    }

    public void setPagePrivilegeId(String pagePrivilegeId) {
        this.pagePrivilegeId = pagePrivilegeId;
    }
}
