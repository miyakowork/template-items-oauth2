package org.templateproject.oauth2.support.pojo.vo;

import org.templateproject.oauth2.entity.OauthMenuModule;

/**
 * Created by yuanqi on 2017/7/17/017.
 */
public class MenuModuleVO extends OauthMenuModule{

    private String createUsername;

    private String updateUsername;

    public String getCreateUsername() {
        return createUsername;
    }

    public void setCreateUsername(String createUsername) {
        this.createUsername=createUsername;
    }

    public String getUpdateUsername() {
        return updateUsername;
    }

    public void setUpdateUsername(String updateUsername) {
        this.updateUsername = updateUsername;
    }
}
