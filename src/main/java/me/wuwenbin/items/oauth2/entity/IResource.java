package me.wuwenbin.items.oauth2.entity;

import me.wuwenbin.items.oauth2.entity.base.DataEntity;
import org.templateproject.tools.sqlgen.annotation.SQLColumn;
import org.templateproject.tools.sqlgen.annotation.SQLTable;

/**
 * Created by yuanqi on 2017/7/12/012.
 * 资源表
 */
@SQLTable("t_oauth_resource")
public class IResource extends DataEntity {


    @SQLColumn
    private String url;//资源路径

    @SQLColumn
    private String permissionMark;//权限标识

    @SQLColumn
    private String name; //资源名称

    @SQLColumn
    private String systemCode;//系统码

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getPermissionMark() {
        return permissionMark;
    }

    public void setPermissionMark(String permissionMark) {
        this.permissionMark = permissionMark;
    }

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


}
