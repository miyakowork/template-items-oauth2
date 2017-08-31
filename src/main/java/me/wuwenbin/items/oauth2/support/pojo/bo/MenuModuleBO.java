package me.wuwenbin.items.oauth2.support.pojo.bo;


import me.wuwenbin.modules.pagination.query.model.bootstrap.BootstrapTableQuery;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryColumn;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryTable;
import me.wuwenbin.modules.pagination.query.support.operator.Operator;

/**
 * Created by yuanqi on 2017/7/12/012.
 */
@QueryTable(aliasName = "tomm")
public class MenuModuleBO extends BootstrapTableQuery {

    private String name;

    @QueryColumn(column = "system_code", operator = Operator.EQ)
    private String systemCodeName;

    @QueryColumn(operator = Operator.EQ)
    public String enabled;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSystemCodeName() {
        return systemCodeName;
    }

    public void setSystemCodeName(String systemCodeName) {
        this.systemCodeName = systemCodeName;
    }

    public String getEnabled() {
        return enabled;
    }

    public void setEnabled(String enabled) {
        this.enabled = enabled;
    }
}
