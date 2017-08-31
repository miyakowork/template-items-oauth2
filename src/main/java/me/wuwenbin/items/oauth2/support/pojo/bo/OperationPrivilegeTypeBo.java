package me.wuwenbin.items.oauth2.support.pojo.bo;


import me.wuwenbin.modules.pagination.query.model.bootstrap.BootstrapTableQuery;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryTable;

/**
 * Created by zhangteng on 2017/7/12.
 * <p>
 * 操作级权限类型查询BO对象
 */
@QueryTable(aliasName = "toyopt")
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
