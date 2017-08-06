package org.templateproject.oauth2.entity;

/**
 * 用户角色中间表
 * Created by tuchen on 2017/7/12.
 */
public class OauthUserRole {


    private Integer userId; //用户id


    private Integer roleId; //角色id

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }
}
