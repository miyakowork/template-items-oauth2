package org.templateproject.oauth2.support.pojo.vo;

import org.templateproject.oauth2.entity.OauthDepartment;
import org.templateproject.oauth2.entity.OauthResourceModule;

/**
 * 资源模块页面的对象VO
 * Created by tuchen on 2017/7/16.
 */
public class ResourceModuleVO extends OauthResourceModule {

    private String createUserName;

    private String updateUserName;

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
}
