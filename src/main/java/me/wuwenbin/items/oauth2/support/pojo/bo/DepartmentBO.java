package me.wuwenbin.items.oauth2.support.pojo.bo;

import me.wuwenbin.modules.pagination.query.model.bootstrap.BootstrapTableQuery;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryColumn;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryTable;
import me.wuwenbin.modules.pagination.query.support.operator.Operator;

/**
 * 部门管理页搜素面查询对象
 * Created by wuwenbin on 2017/08/04.
 */
@QueryTable(aliasName = "tod")
public class DepartmentBO extends BootstrapTableQuery {

    private String name;  //部门名称

    @QueryColumn(column = "parent_id", operator = Operator.EQ)
    private Integer parentId;  //父节点id

    @QueryColumn(operator = Operator.EQ)
    private Boolean enabled;   //是否可用


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }
}
