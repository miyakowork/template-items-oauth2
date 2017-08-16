package org.templateproject.items.oauth2.entity.shiro;

import org.templateproject.items.oauth2.entity.base.DataEntity;
import org.templateproject.tools.sqlgen.annotation.SQLColumn;
import org.templateproject.tools.sqlgen.annotation.SQLTable;

import java.util.Date;

/**
 * session持久化对象
 * Created by Wuwenbin on 2017/7/19.
 */
@SQLTable("t_oauth_session")
public class ShiroSession extends DataEntity {

    @SQLColumn
    private String username;

    @SQLColumn
    private String sessionId;

    @SQLColumn
    private String sessionBase64;

    @SQLColumn
    private String ip;

    @SQLColumn
    private Long sessionTimeout;

    @SQLColumn
    private String createUrl;

    @SQLColumn
    private String updateUrl;

    @SQLColumn
    private String userAgent;

    @SQLColumn
    private Date firstVisitDate;

    @SQLColumn
    private Date lastVisitDate;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getFirstVisitDate() {
        return firstVisitDate;
    }

    public void setFirstVisitDate(Date firstVisitDate) {
        this.firstVisitDate = firstVisitDate;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public String getSessionBase64() {
        return sessionBase64;
    }

    public void setSessionBase64(String sessionBase64) {
        this.sessionBase64 = sessionBase64;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public Long getSessionTimeout() {
        return sessionTimeout;
    }

    public void setSessionTimeout(Long sessionTimeout) {
        this.sessionTimeout = sessionTimeout;
    }

    public String getCreateUrl() {
        return createUrl;
    }

    public void setCreateUrl(String createUrl) {
        this.createUrl = createUrl;
    }

    public String getUpdateUrl() {
        return updateUrl;
    }

    public void setUpdateUrl(String updateUrl) {
        this.updateUrl = updateUrl;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }

    public Date getLastVisitDate() {
        return lastVisitDate;
    }

    public void setLastVisitDate(Date lastVisitDate) {
        this.lastVisitDate = lastVisitDate;
    }
}
