package org.templateproject.oauth2.support.pojo.vo;

import org.templateproject.oauth2.entity.OauthUserLoginLog;

/**
 * Created by Wuwenbin on 2017/7/31.
 */
public class LoginLogVO extends OauthUserLoginLog {

    private String  username;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
