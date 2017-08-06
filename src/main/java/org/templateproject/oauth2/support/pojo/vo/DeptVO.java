package org.templateproject.oauth2.support.pojo.vo;

import org.templateproject.oauth2.entity.OauthDepartment;

/**
 * 部门管理页面的对象VO
 * Created by wuwenbin on 2017/7/16.
 */
public class DeptVO extends OauthDepartment {

    private String parentName;

    private String createName;

    private String updateName;

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getCreateName() {
        return createName;
    }

    public void setCreateName(String createName) {
        this.createName = createName;
    }

    public String getUpdateName() {
        return updateName;
    }

    public void setUpdateName(String updateName) {
        this.updateName = updateName;
    }
}
