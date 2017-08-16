package org.templateproject.items.oauth2.support.pojo.vo;

import org.templateproject.items.oauth2.entity.IResourceModule;

/**
 * 资源模块页面的对象VO
 * Created by tuchen on 2017/7/16.
 */
public class ResourceModuleVO extends IResourceModule {

    private String createUserName;

    private String updateUserName;

    private String systemModuleName;

    public String getCreateUserName() {
        return createUserName;
    }

    public void setCreateUserName(String createUserName) {
        this.createUserName = createUserName;
    }

    public String getUpdateUserName() {
        return updateUserName;
    }

    public void setUpdateUserName(String updateUserName) {
        this.updateUserName = updateUserName;
    }

    public String getSystemModuleName() {
        return systemModuleName;
    }

    public void setSystemModuleName(String systemModuleName) {
        this.systemModuleName = systemModuleName;
    }
}
