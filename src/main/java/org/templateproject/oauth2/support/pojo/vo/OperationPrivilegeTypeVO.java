package org.templateproject.oauth2.support.pojo.vo;

import org.templateproject.oauth2.entity.OauthOperationPrivilegeType;

/**
 * Created by zhangteng on 2017/7/18.
 * <p>
 * 操作级权限类型VO
 */
public class OperationPrivilegeTypeVO extends OauthOperationPrivilegeType {


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
