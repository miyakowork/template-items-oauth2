package org.templateproject.items.oauth2.support.pojo.bo;

import org.templateproject.items.oauth2.support.annotation.query.QueryColumn;
import org.templateproject.items.oauth2.support.annotation.query.QueryTable;
import org.templateproject.items.oauth2.support.enumerate.Operator;
import org.templateproject.items.oauth2.support.pojo.BootstrapTableQuery;

/**
 * Created by Liurongqi on 2017/7/13.
 */
@QueryTable("tor")
public class ResourceBO extends BootstrapTableQuery {
    private String url; //资源路径
    @QueryColumn("permission_mark")
    private String permissionMark;   //资源标识
    @QueryColumn(value = "system_code", operation = Operator.EQ)
    private String systemCode;  //系统代码
    private String name;  //名称
    private String enabled;   //是否可用


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

    public String getSystemCode() {
        return systemCode;
    }

    public void setSystemCode(String systemCode) {
        this.systemCode = systemCode;
    }

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
}
