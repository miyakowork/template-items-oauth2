package org.templateproject.items.oauth2.entity;

import org.templateproject.items.oauth2.entity.base.DataEntity;
import org.templateproject.tools.sqlgen.annotation.SQLColumn;
import org.templateproject.tools.sqlgen.annotation.SQLTable;

/**
 * Created by yuanqi on 2017/7/12/012.
 * 系统参数
 */
@SQLTable("t_oauth_system_param")
public class ISystemParam extends DataEntity {

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
