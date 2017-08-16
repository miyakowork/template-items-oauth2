package org.templateproject.items.oauth2.support.pojo.vo;

import org.templateproject.items.oauth2.entity.ISystemParam;

/**
 * 系统参数页面的对象VO
 * Created by tuchen on 2017/7/16.
 */
public class SystemParamVO extends ISystemParam {

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
