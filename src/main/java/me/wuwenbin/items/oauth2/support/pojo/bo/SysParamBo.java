package me.wuwenbin.items.oauth2.support.pojo.bo;


import me.wuwenbin.modules.pagination.query.model.bootstrap.BootstrapTableQuery;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryColumn;
import me.wuwenbin.modules.pagination.query.support.operator.Operator;

/**
 * 系统参数查询BO对象
 * Created by tuchen on 2017/7/8.
 */
public class SysParamBo extends BootstrapTableQuery {

    private String name;

    @QueryColumn(column = "enabled", operator = Operator.EQ, tableAlias = "tosp")
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
