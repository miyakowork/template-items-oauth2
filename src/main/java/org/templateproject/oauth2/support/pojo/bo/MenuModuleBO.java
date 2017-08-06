package org.templateproject.oauth2.support.pojo.bo;


import org.templateproject.oauth2.support.pojo.PageQueryBO;

/**
 * Created by yuanqi on 2017/7/12/012.
 */
public class MenuModuleBO  extends PageQueryBO {

    private String name;

    private String systemCodeName;

    public Boolean enabled;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSystemCodeName() {
        return systemCodeName;
    }

    public void setSystemCodeName(String systemCodeName) {
        this.systemCodeName = systemCodeName;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }
}
