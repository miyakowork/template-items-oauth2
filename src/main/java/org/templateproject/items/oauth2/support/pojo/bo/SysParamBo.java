package org.templateproject.items.oauth2.support.pojo.bo;


import org.templateproject.items.oauth2.support.annotation.query.QueryColumn;
import org.templateproject.items.oauth2.support.enumerate.Operator;
import org.templateproject.items.oauth2.support.pojo.BootstrapTableQuery;

/**
 * 系统参数查询BO对象
 * Created by tuchen on 2017/7/8.
 */
public class SysParamBo extends BootstrapTableQuery {

    private String name;

    @QueryColumn(value = "enabled", operation = Operator.EQ, table = "tosp")
    private Boolean selectEnabled;

    private String value;

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
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
}
