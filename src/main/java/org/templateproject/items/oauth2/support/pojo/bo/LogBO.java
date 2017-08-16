package org.templateproject.items.oauth2.support.pojo.bo;

import org.templateproject.items.oauth2.support.annotation.query.QueryColumn;
import org.templateproject.items.oauth2.support.enumerate.Operator;
import org.templateproject.items.oauth2.support.pojo.PageQueryBO;

/**
 * Created by Administrator on 2017/7/13/013.
 */
public class LogBO extends PageQueryBO {

    private String username;

    @QueryColumn(value = "last_login_date", operation = Operator.BETWEEN)
    private String lastLoginDate;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getLastLoginDate() {
        return lastLoginDate;
    }

    public void setLastLoginDate(String lastLoginDate) {
        this.lastLoginDate = lastLoginDate;
    }
}
