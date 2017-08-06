package org.templateproject.oauth2.support.pojo.bo;

import org.templateproject.oauth2.support.pojo.PageQueryBO;

/**
 * 部门管理页搜素面查询对象
 * Created by Liurongqi on 2017/7/12.
 */
public class DepartmentBO extends PageQueryBO {

    private String name;  //部门名称
    private Integer parentId;  //父节点id
    private Boolean enabled;   //是否可用


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }
}
