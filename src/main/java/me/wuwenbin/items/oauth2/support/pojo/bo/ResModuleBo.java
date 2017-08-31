package me.wuwenbin.items.oauth2.support.pojo.bo;


import me.wuwenbin.modules.pagination.query.model.bootstrap.BootstrapTableQuery;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryColumn;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryTable;
import me.wuwenbin.modules.pagination.query.support.operator.Operator;

/**
 * 资源模块管理查询BO对象
 * Created by wuwenbin on 2017/8/8.
 */
@QueryTable(aliasName = "torm")
public class ResModuleBo extends BootstrapTableQuery {
    private String name;

    @QueryColumn(column = "enabled", operator = Operator.EQ)
    private String selectEnabled;

    @QueryColumn(column = "system_code")
    private String systemCode;

    public String getSystemCode() {
        return systemCode;
    }

    public void setSystemCode(String systemCode) {
        this.systemCode = systemCode;
    }

    public String getSelectEnabled() {
        return selectEnabled;
    }

    public void setSelectEnabled(String selectEnabled) {
        this.selectEnabled = selectEnabled;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
