package org.templateproject.oauth2.entity;

import org.templateproject.oauth2.entity.base.DataEntity;
import org.templateproject.sql.annotation.SQLColumn;
import org.templateproject.sql.annotation.SQLTable;

import java.time.LocalDate;

/**
 * Created by yuanqi on 2017/7/12/012.
 * 系统参数
 */
@SQLTable("t_oauth_system_param")
public class OauthSystemParam extends DataEntity {

    @SQLColumn
    private String name;//名称

    @SQLColumn
    private String value;//参数值

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }


}
