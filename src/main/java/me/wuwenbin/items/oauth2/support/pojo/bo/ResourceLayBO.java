package me.wuwenbin.items.oauth2.support.pojo.bo;

import me.wuwenbin.modules.pagination.query.model.layui.LayTableQuery;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryColumn;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryTable;
import me.wuwenbin.modules.pagination.query.support.operator.Operator;

/**
 * created by Wuwenbin on 2017/8/21 at 16:36
 */
@QueryTable(aliasName = "tor")
public class ResourceLayBO extends LayTableQuery {

    private String name;//搜索的资源名称

    @QueryColumn(column = "system_code", operator = Operator.EQ)
    private String systemModuleCode;//资源所属系统

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSystemModuleCode() {
        return systemModuleCode;
    }

    public void setSystemModuleCode(String systemModuleCode) {
        this.systemModuleCode = systemModuleCode;
    }
}
