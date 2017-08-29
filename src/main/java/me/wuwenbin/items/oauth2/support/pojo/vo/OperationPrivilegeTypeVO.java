package me.wuwenbin.items.oauth2.support.pojo.vo;

import me.wuwenbin.items.oauth2.entity.IOperationPrivilegeType;

/**
 * Created by zhangteng on 2017/7/18.
 * <p>
 * 操作级权限类型VO
 */
public class OperationPrivilegeTypeVO extends IOperationPrivilegeType {


    private String createUserName;

    private String updateUserName;

    public String getCreateUserName() {
        return createUserName;
    }

    public void setCreateUserName(String createUserName) {
        this.createUserName = createUserName;
    }

    public String getUpdateUserName() {
        return updateUserName;
    }

    public void setUpdateUserName(String updateUserName) {
        this.updateUserName = updateUserName;
    }
}
