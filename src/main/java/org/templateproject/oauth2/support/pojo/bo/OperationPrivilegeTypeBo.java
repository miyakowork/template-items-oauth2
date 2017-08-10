package org.templateproject.oauth2.support.pojo.bo;

import org.templateproject.oauth2.support.annotation.query.QueryTable;
import org.templateproject.oauth2.support.pojo.PageQueryBO;

/**
 * Created by zhangteng on 2017/7/12.
 * <p>
 * 操作级权限类型查询BO对象
 */
@QueryTable("toyopt")
public class OperationPrivilegeTypeBo extends PageQueryBO {

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
