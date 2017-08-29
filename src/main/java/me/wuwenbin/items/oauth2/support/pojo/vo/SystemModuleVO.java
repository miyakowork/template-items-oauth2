package me.wuwenbin.items.oauth2.support.pojo.vo;

import me.wuwenbin.items.oauth2.entity.ISystemModule;

/**
 * Created by zhangteng on 2017/7/17.
 * 系统模块 VO
 */
public class SystemModuleVO extends ISystemModule {

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
