package org.templateproject.items.oauth2.entity;

import org.templateproject.items.oauth2.entity.base.DataEntity;
import org.templateproject.tools.sqlgen.annotation.SQLColumn;
import org.templateproject.tools.sqlgen.annotation.SQLTable;


/**
 * 用户表
 * Created by tuchen on 2017/7/12.
 */
@SQLTable("t_oauth_user")
public class IUser extends DataEntity {

    @SQLColumn
    private String username;//用户名

    @SQLColumn
    private String password;//密码

    @SQLColumn
    private String cname;//姓名

    @SQLColumn
    private Integer deptId;//部门Id

    @SQLColumn
    private String salt;//盐

    @SQLColumn
    private String email;//邮箱

    @SQLColumn
    private int defaultRoleId;//默认父角色id

    @SQLColumn
    private String qq;//qq

    @SQLColumn
    private String wechat;//微信

    @SQLColumn
    private String mobile;//手机号码

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getDefaultRoleId() {
        return defaultRoleId;
    }

    public void setDefaultRoleId(int defaultRoleId) {
        this.defaultRoleId = defaultRoleId;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getWechat() {
        return wechat;
    }

    public void setWechat(String wechat) {
        this.wechat = wechat;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getCredentialsSalt() {
        return username + salt;
    }
}
