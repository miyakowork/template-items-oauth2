package org.templateproject.oauth2.support.pojo.bo;

import org.templateproject.oauth2.support.pojo.PageQueryBO;

/**
 * Created by Liurongqi on 2017/7/13.
 */
public class ResourceBO extends PageQueryBO {
    private String url; //资源路径
    private String permissionMark;   //资源标识
    private String systemCode;  //系统代码
    private String name;  //名称
    private Boolean enabled;   //是否可用


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

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }
}
