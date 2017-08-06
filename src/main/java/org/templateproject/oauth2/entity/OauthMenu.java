package org.templateproject.oauth2.entity;

import org.templateproject.oauth2.entity.base.DataEntity;
import org.templateproject.sql.annotation.SQLTable;

import java.time.LocalDateTime;

/**
 * 菜单表
 * Created by Liurongqi on 2017/7/12.
 */

@SQLTable("t_oauth_menu")
public class OauthMenu extends DataEntity {
    private String name;    //名称
    private Integer resourceId;     //资源id
    private String icon;    //菜单图标
    private String menuType;       //菜单类型
    private String href;            //外部链接地址
    private String onclick;         //onclick事件
    private String target;          //target属性
    private Integer roleId;         //角色id
    private Integer menuModuleId;   //菜单模块id
    private Integer parentId;            //父级角色id

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getResourceId() {
        return resourceId;
    }

    public void setResourceId(Integer resourceId) {
        this.resourceId = resourceId;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getMenuType() {
        return menuType;
    }

    public void setMenuType(String menuType) {
        this.menuType = menuType;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public String getOnclick() {
        return onclick;
    }

    public void setOnclick(String onclick) {
        this.onclick = onclick;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Integer getMenuModuleId() {
        return menuModuleId;
    }

    public void setMenuModuleId(Integer menuModuleId) {
        this.menuModuleId = menuModuleId;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    /**
     * 生成root节点
     * @return root
     */
    public static OauthMenu root(){
        OauthMenu root = new OauthMenu();
        root.setId(0);
        root.setName("菜单根节点");
        root.setParentId(-1);
        root.setRemark("根节点菜单，无任何意义，作为树形菜单的象征节点");
        return root;
    }
}
