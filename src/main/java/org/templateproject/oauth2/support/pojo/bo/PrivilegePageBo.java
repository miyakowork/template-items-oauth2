package org.templateproject.oauth2.support.pojo.bo;

import org.templateproject.oauth2.support.pojo.PageQueryBO;

/**
 * Created by zhangteng on 2017/7/19.
 * 页面资源表BO
 */
public class PrivilegePageBo extends PageQueryBO {

    private String name;  //资源模块名称

    private Boolean enabled;  //是否可用

    private String moduleId;  //资源模块ID

    private String resourceName;  //资源名称

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
