package org.templateproject.items.oauth2.entity;


import org.templateproject.items.oauth2.entity.base.DataEntity;
import org.templateproject.tools.sqlgen.annotation.SQLColumn;
import org.templateproject.tools.sqlgen.annotation.SQLTable;

/**
 * Created by yuanqi on 2017/7/12/012.
 * 资源模块
 */
@SQLTable("t_oauth_resource_module")
public class IResourceModule extends DataEntity {
    @SQLColumn
    private String name;  //名称

    @SQLColumn
    private String systemCode;

    public String getSystemCode() {
        return systemCode;
    }

    public void setSystemCode(String systemCode) {
        this.systemCode = systemCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


}
