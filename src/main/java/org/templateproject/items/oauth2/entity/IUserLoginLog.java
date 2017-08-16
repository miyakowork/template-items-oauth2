package org.templateproject.items.oauth2.entity;

import org.templateproject.items.oauth2.entity.base.DataEntity;
import org.templateproject.tools.sqlgen.annotation.SQLTable;

import java.time.LocalDateTime;

/**
 * Created by yuanqi on 2017/7/12/012.
 * 用户登陆日志
 */
@SQLTable("t_oauth_user_login_log")
public class IUserLoginLog extends DataEntity {


    private Integer userId;//用户id

    private LocalDateTime lastLoginDate;//登录时间

    private String lastLoginIp;//登陆ip

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public LocalDateTime getLastLoginDate() {
        return lastLoginDate;
    }

    public void setLastLoginDate(LocalDateTime lastLoginDate) {
        this.lastLoginDate = lastLoginDate;
    }

    public String getLastLoginIp() {
        return lastLoginIp;
    }

    public void setLastLoginIp(String lastLoginIp) {
        this.lastLoginIp = lastLoginIp;
    }


}
