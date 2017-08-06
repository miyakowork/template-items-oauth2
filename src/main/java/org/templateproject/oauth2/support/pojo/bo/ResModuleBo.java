package org.templateproject.oauth2.support.pojo.bo;


import org.templateproject.oauth2.support.pojo.PageQueryBO;

/**
 * 资源模块管理查询BO对象
 * Created by tuchen on 2017/7/8.
 */
public class ResModuleBo extends PageQueryBO {
    private String  name;

    private Boolean selectEnabled;

    private String systemCode;

    public String getSystemCode() {
        return systemCode;
    }

    public void setSystemCode(String systemCode) {
        this.systemCode = systemCode;
    }

    public Boolean getSelectEnabled() {
        return selectEnabled;
    }

    public void setSelectEnabled(Boolean selectEnabled) {
        this.selectEnabled = selectEnabled;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
