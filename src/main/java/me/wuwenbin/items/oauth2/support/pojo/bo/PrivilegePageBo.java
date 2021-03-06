package me.wuwenbin.items.oauth2.support.pojo.bo;

import me.wuwenbin.modules.pagination.query.model.bootstrap.BootstrapTableQuery;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryColumn;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryTable;
import me.wuwenbin.modules.pagination.query.support.operator.Operator;

/**
 * Created by zhangteng on 2017/7/19.
 * 页面资源表BO
 */
@QueryTable(aliasName = "topp")
public class PrivilegePageBo extends BootstrapTableQuery {

    private String name;  //资源模块名称

    private String enabled;  //是否可用

    @QueryColumn(column = "resource_module_id", operator = Operator.EQ)
    private String moduleId;  //资源模块ID

    @QueryColumn(column = "name", tableName = "tor")
    private String resourceName;  //资源名称

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEnabled() {
        return enabled;
    }

    public void setEnabled(String enabled) {
        this.enabled = enabled;
    }

    public String getModuleId() {
        return moduleId;
    }

    public void setModuleId(String moduleId) {
        this.moduleId = moduleId;
    }

    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }
}
