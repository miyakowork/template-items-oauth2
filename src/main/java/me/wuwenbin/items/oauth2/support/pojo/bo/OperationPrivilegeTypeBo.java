package me.wuwenbin.items.oauth2.support.pojo.bo;

import me.wuwenbin.items.oauth2.support.annotation.query.QueryTable;
import me.wuwenbin.items.oauth2.support.pojo.BootstrapTableQuery;

/**
 * Created by zhangteng on 2017/7/12.
 * <p>
 * 操作级权限类型查询BO对象
 */
@QueryTable("toyopt")
public class OperationPrivilegeTypeBo extends BootstrapTableQuery {

    private String name;

    private String enabled;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEnabled() {
        return enabled;
    }

    public void setEnabled(String enabled) {
        this.enabled = enabled;
    }
}
