package org.templateproject.oauth2.entity;

import org.templateproject.oauth2.entity.base.DataEntity;
import org.templateproject.sql.annotation.SQLColumn;
import org.templateproject.sql.annotation.SQLTable;

import java.time.LocalDateTime;

/**
 * 菜单模块基础表
 * Created by Liurongqi on 2017/7/12.
 */
@SQLTable("t_oauth_menu_module")
public class OauthMenuModule extends DataEntity {

    @SQLColumn
    private String name;    //名称

    @SQLColumn
    private String systemCode;

    @SQLColumn
    private String iconLarger;

    @SQLColumn
    private String iconMini;

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

    public String getIconLarger() {
        return iconLarger;
    }

    public void setIconLarger(String iconLarger) {
        this.iconLarger = iconLarger;
    }

    public String getIconMini() {
        return iconMini;
    }

    public void setIconMini(String iconMini) {
        this.iconMini = iconMini;
    }
}
