package me.wuwenbin.items.oauth2.support.pojo.bo;

import me.wuwenbin.modules.pagination.query.model.bootstrap.BootstrapTableQuery;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryColumn;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryTable;
import me.wuwenbin.modules.pagination.query.support.operator.Operator;

/**
 * Created by wuwenbin on 2017/7/14.
 * 系统模块表BO
 */
@QueryTable(aliasName = "tosm")
public class SystemModuleBo extends BootstrapTableQuery {

    private String name;

    @QueryColumn(column = "system_code")
    private String systemCode;

    @QueryColumn(operator = Operator.EQ)
    private Boolean enabled;


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSystemCode() {
        return systemCode;
    }

    public void setSystemCode(String systemCode) {
        this.systemCode = systemCode;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }
}
