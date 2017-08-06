package org.templateproject.oauth2.support.pojo.bo;

import org.templateproject.oauth2.support.pojo.PageQueryBO;

/**
 * Created by Administrator on 2017/7/19/019.
 */
public class UserBO extends PageQueryBO {

    private String username;//用户名

    private String cname;

    private Boolean enabled;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }
}
