package me.wuwenbin.items.oauth2.support.pojo.bo;

import me.wuwenbin.items.oauth2.support.annotation.query.QueryColumn;
import me.wuwenbin.items.oauth2.support.enumerate.Operator;
import me.wuwenbin.items.oauth2.support.pojo.LayTableQuery;

/**
 * created by Wuwenbin on 2017/8/21 at 16:36
 */
public class ResourceLayBO extends LayTableQuery {

    private String name;//搜索的资源名称

    @QueryColumn(value = "system_code", operation = Operator.EQ)
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
