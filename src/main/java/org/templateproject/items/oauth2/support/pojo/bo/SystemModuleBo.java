package org.templateproject.items.oauth2.support.pojo.bo;

import org.templateproject.items.oauth2.support.annotation.query.QueryColumn;
import org.templateproject.items.oauth2.support.annotation.query.QueryTable;
import org.templateproject.items.oauth2.support.enumerate.Operator;
import org.templateproject.items.oauth2.support.pojo.PageQueryBO;

/**
 * Created by wuwenbin on 2017/7/14.
 * 系统模块表BO
 */
@QueryTable("tosm")
public class SystemModuleBo extends PageQueryBO {

    private String name;

    @QueryColumn(value = "system_code")
    private String systemCode;

    @QueryColumn(operation = Operator.EQ)
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
