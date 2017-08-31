package me.wuwenbin.items.oauth2.support.pojo.bo;

import me.wuwenbin.modules.pagination.query.model.layui.LayTableQuery;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryColumn;
import me.wuwenbin.modules.pagination.query.support.operator.Operator;

/**
 * created by Wuwenbin on 2017/8/22 at 15:58
 */
public class PrivilegeOperationBO extends LayTableQuery {

    @QueryColumn(column = "operation_name")
    private String privilegeOperationName;

    @QueryColumn(column = "page_privilege_id", operator = Operator.EQ)
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
