package me.wuwenbin.items.oauth2.support.pojo.bo;


import me.wuwenbin.modules.pagination.query.model.bootstrap.BootstrapTableQuery;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryColumn;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryTable;
import me.wuwenbin.modules.pagination.query.support.operator.Operator;

/**
 * 角色管理查询BO对象
 * Created by tuchen on 2017/7/8.
 * Modify by Wuwenbin on 2017/8/5
 */
@QueryTable(aliasName = "tor")
public class RoleBo extends BootstrapTableQuery {

    @QueryColumn(column = "parent_id", operator = Operator.EQ)
    private String parentId;

    private String name;

    @QueryColumn(column = "enabled", operator = Operator.EQ)
    private Boolean selectEnabled;

    @QueryColumn(column = "cn_name")
    private String cnName;

    @QueryColumn(column = "system_code")
    private String systemCode;

    public String getCnName() {
        return cnName;
    }

    public void setCnName(String cnName) {
        this.cnName = cnName;
    }

    public String getSystemCode() {
        return systemCode;
    }

    public void setSystemCode(String systemCode) {
        this.systemCode = systemCode;
    }

    public Boolean getSelectEnabled() {
        return selectEnabled;
    }

    public void setSelectEnabled(Boolean selectEnabled) {
        this.selectEnabled = selectEnabled;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }
}
