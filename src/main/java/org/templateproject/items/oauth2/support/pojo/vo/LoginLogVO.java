package org.templateproject.items.oauth2.support.pojo.vo;

import org.templateproject.items.oauth2.entity.IUserLoginLog;

/**
 * Created by Wuwenbin on 2017/7/31.
 */
public class LoginLogVO extends IUserLoginLog {

    private String username;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
