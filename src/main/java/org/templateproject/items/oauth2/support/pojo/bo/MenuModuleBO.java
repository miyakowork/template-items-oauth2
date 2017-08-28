package org.templateproject.items.oauth2.support.pojo.bo;


import org.templateproject.items.oauth2.support.annotation.query.QueryColumn;
import org.templateproject.items.oauth2.support.annotation.query.QueryTable;
import org.templateproject.items.oauth2.support.enumerate.Operator;
import org.templateproject.items.oauth2.support.pojo.BootstrapTableQuery;

/**
 * Created by yuanqi on 2017/7/12/012.
 */
@QueryTable("tomm")
public class MenuModuleBO extends BootstrapTableQuery {

    private String name;

    @QueryColumn(value = "system_code", operation = Operator.EQ)
    private String systemCodeName;

    @QueryColumn(operation = Operator.EQ)
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
