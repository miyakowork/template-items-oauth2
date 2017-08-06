package org.templateproject.oauth2.entity;

import org.templateproject.oauth2.entity.base.DataEntity;
import org.templateproject.sql.annotation.SQLColumn;
import org.templateproject.sql.annotation.SQLTable;

import java.time.LocalDate;

/**
 * Created by zhangteng on 2017/7/12.
 * 操作级权限类型基础表
 */
@SQLTable("t_oauth_operation_privilege_type")
public class OauthOperationPrivilegeType extends DataEntity{

    @SQLColumn
    private String name;  //操作级权限类型名称

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
