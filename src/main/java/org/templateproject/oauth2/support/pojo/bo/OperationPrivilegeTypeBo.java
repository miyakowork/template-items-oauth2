package org.templateproject.oauth2.support.pojo.bo;

import org.templateproject.oauth2.support.pojo.PageQueryBO;

/**
 * Created by zhangteng on 2017/7/12.
 *
 * 操作级权限类型查询BO对象
 */
public class OperationPrivilegeTypeBo extends PageQueryBO {

    private String name;


    private Boolean enabled;



    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }
}
