package me.wuwenbin.items.oauth2.support.pojo.bo;


import me.wuwenbin.items.oauth2.support.annotation.query.QueryColumn;
import me.wuwenbin.items.oauth2.support.annotation.query.QueryTable;
import me.wuwenbin.items.oauth2.support.enumerate.Operator;
import me.wuwenbin.items.oauth2.support.pojo.BootstrapTableQuery;

/**
 * 角色管理查询BO对象
 * Created by tuchen on 2017/7/8.
 * Modify by Wuwenbin on 2017/8/5
 */
@QueryTable("tor")
public class RoleBo extends BootstrapTableQuery {

    @QueryColumn(value = "parent_id", operation = Operator.EQ)
    private String parentId;

    private String name;

    @QueryColumn(value = "enabled", operation = Operator.EQ)
    private Boolean selectEnabled;

    @QueryColumn(value = "cn_name")
    private String cnName;

    @QueryColumn(value = "system_code")
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
