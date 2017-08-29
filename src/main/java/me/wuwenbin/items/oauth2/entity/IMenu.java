package me.wuwenbin.items.oauth2.entity;

import me.wuwenbin.items.oauth2.entity.base.DataEntity;
import org.templateproject.tools.sqlgen.annotation.SQLColumn;
import org.templateproject.tools.sqlgen.annotation.SQLTable;

/**
 * 菜单表
 * Created by wuwenbin on 2017/7/12.
 */

@SQLTable("t_oauth_menu")
public class IMenu extends DataEntity {

    @SQLColumn
    private String name;    //名称
    @SQLColumn
    private Integer resourceId;     //资源id
    @SQLColumn
    private String systemCode;//系统模块代码
    @SQLColumn
    private String icon;    //菜单图标
    @SQLColumn
    private String iconLarger;//菜单大图标
    @SQLColumn
    private String menuType;       //菜单类型
    @SQLColumn
    private String href;            //外部链接地址
    @SQLColumn
    private String onclick;         //onclick事件
    @SQLColumn
    private String target;          //target属性
    @SQLColumn
    private Integer roleId;         //角色id
    @SQLColumn
    private Integer menuModuleId;   //菜单模块id
    @SQLColumn
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

    public String getSystemCode() {
        return systemCode;
    }

    public void setSystemCode(String systemCode) {
        this.systemCode = systemCode;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getIconLarger() {
        return iconLarger;
    }

    public void setIconLarger(String iconLarger) {
        this.iconLarger = iconLarger;
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
     *
     * @return root
     */
    public static IMenu root() {
        IMenu root = new IMenu();
        root.setId(0);
        root.setName("菜单根节点");
        root.setParentId(-1);
        root.setRemark("根节点菜单，无任何意义，作为树形菜单的象征节点");
        return root;
    }
}
