package org.templateproject.oauth2.support.pojo.vo;

import org.templateproject.oauth2.entity.OauthPrivilegePage;

/**
 * Created by zhangteng on 2017/7/19.
 * 页面资源表VO
 */
public class PrivilegePageVO extends OauthPrivilegePage {

    private String name;  //资源模块名称

    private String resourceName;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }
}
