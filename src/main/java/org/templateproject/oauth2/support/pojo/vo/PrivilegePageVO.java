package org.templateproject.oauth2.support.pojo.vo;

import org.templateproject.oauth2.entity.OauthPrivilegePage;

/**
 * Created by zhangteng on 2017/7/19.
 * 页面资源表VO
 */
public class PrivilegePageVO extends OauthPrivilegePage {

    private String resourceModuleName;  //资源模块名称

    private String resourceName;

    public String getResourceModuleName() {
        return resourceModuleName;
    }

    public void setResourceModuleName(String resourceModuleName) {
        this.resourceModuleName = resourceModuleName;
    }

    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }
}
