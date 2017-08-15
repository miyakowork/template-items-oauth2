package org.templateproject.oauth2.entity;


import org.templateproject.oauth2.entity.base.DataEntity;
import org.templateproject.sql.annotation.SQLColumn;
import org.templateproject.sql.annotation.SQLTable;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Created by zhangteng on 2017/7/12.
 * 页面级权限表
 */
@SQLTable("t_oauth_privilege_page")
public class OauthPrivilegePage extends DataEntity {

    @SQLColumn
    private String name;//权限名称

    @SQLColumn
    private Integer resourceId;  //资源id

    @SQLColumn
    private String resourceModuleId;  //资源模块id

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getResourceId() {
        return resourceId;
    }

    public void setResourceId(Integer resourceId) {
        this.resourceId = resourceId;
    }

    public String getResourceModuleId() {
        return resourceModuleId;
    }

    public void setResourceModuleId(String resourceModuleId) {
        this.resourceModuleId = resourceModuleId;
    }
}
