package org.templateproject.oauth2.support.pojo.vo;

import org.templateproject.oauth2.entity.OauthUser;

/**
 * Created by yuanqi on 2017/7/19/019.
 * 设置通过连接查询查找到部门名字和角色名字
 */
public class UserVO extends OauthUser {

     private String departmentName;//部门名字

     private  Integer defaultRoleId;//角色id

    private String roleName;

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public Integer defaultRoleId(){
        return  defaultRoleId;
    }

    public void  setDefaultRoleId(Integer defaultRoleId){

        this.defaultRoleId = defaultRoleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
