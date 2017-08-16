package org.templateproject.items.oauth2.support.pojo.bo;


import org.templateproject.items.oauth2.support.annotation.query.QueryColumn;
import org.templateproject.items.oauth2.support.annotation.query.QueryTable;
import org.templateproject.items.oauth2.support.enumerate.Operator;
import org.templateproject.items.oauth2.support.pojo.PageQueryBO;

/**
 * 资源模块管理查询BO对象
 * Created by wuwenbin on 2017/8/8.
 */
@QueryTable("torm")
public class ResModuleBo extends PageQueryBO {
    private String name;

    @QueryColumn(value = "enabled", operation = Operator.EQ)
    private String selectEnabled;

    @QueryColumn("system_code")
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
