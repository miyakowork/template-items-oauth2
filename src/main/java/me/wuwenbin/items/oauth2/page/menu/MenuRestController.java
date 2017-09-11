package me.wuwenbin.items.oauth2.page.menu;

import me.wuwenbin.items.oauth2.entity.IMenu;
import me.wuwenbin.items.oauth2.service.MenuService;
import me.wuwenbin.items.oauth2.service.shiro.ShiroMenuService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import me.wuwenbin.items.oauth2.support.pojo.bo.ZTreeBO;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.lang.TP;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * Created by Wuwenbin on 2017/8/21.
 */
@RestController
@RequestMapping("oauth2/menu/api")
public class MenuRestController extends BaseRestController {

    private MenuService menuService;
    private ShiroMenuService shiroMenuService;

    @Autowired
    public MenuRestController(MenuService menuService, ShiroMenuService shiroMenuService) {
        this.menuService = menuService;
        this.shiroMenuService = shiroMenuService;
    }


    /**
     * 菜单表格树
     *
     * @param roleId
     * @return
     */
    @RequestMapping("list")
    @RequiresPermissions("base:menu:list")
    @AuthResource(name = "获取菜单表格树数据")
    public List<IMenu> findMenuTable(String roleId) {
        return menuService.findEnabledMenusByRoleId(roleId);
    }

    /**
     * 添加菜单
     *
     * @param menu
     * @return
     */
    @RequestMapping("add")
    @RequiresPermissions("base:menu:add")
    @AuthResource(name = "添加菜单操作")
    public R add(IMenu menu) {
        return ajaxDoneAdd("菜单", menuService, menu, IMenu.class);
    }

    /**
     * 编辑菜单
     *
     * @param menu
     * @return
     */
    @RequestMapping("edit")
    @RequiresPermissions("base:menu:edit")
    @AuthResource(name = "编辑菜单操作")
    public R edit(IMenu menu) {
        try {
            if (menuService.editMenu(menu))
                return R.ok("修改菜单成功！");
            else
                return R.error("修改菜单失败！");
        } catch (Exception e) {
            LOGGER.error("修改菜单出现异常，异常：{}", e);
            return R.error("修改菜单出现异常，异常信息：" + e.getMessage());
        }
    }

    /**
     * 删除菜单
     *
     * @param ids
     * @return
     */
    @RequestMapping("delete")
    @RequiresPermissions("base:menu:delete")
    @AuthResource(name = "删除菜单操作")
    public R delete(String ids) {
        try {
            if (menuService.deleteMenu(ids))
                return R.ok("删除菜单成功！");
            else
                return R.error("删除菜单失败！");
        } catch (Exception e) {
            LOGGER.error("删除菜单出现异常，异常：{}", e);
            return R.error("删除菜单出现异常，异常信息：" + e.getMessage());
        }
    }

    /**
     * 查找菜单树
     *
     * @return
     */
    @RequestMapping("menuTree")
    @RequiresPermissions("base:menu:menuTree")
    @AuthResource(name = "根据菜单模块查找菜单树操作")
    public List<ZTreeBO> findMenuTree(String menuModuleId) {
        if (TP.stringhelper.isNotEmpty(menuModuleId)) {
            return menuService.menuList2MenuTree(menuService.findEnableMenusByMenuModuleId(menuModuleId));
        } else {
            return menuService.menuList2MenuTree(menuService.findEnabledListBean(IMenu.class));
        }
    }

    /**
     * 添加菜单时候选择内置权限菜单时，查找带回选择的权限资源
     *
     * @param resourceModuleId
     * @param roleId
     * @return
     */
    @RequestMapping("addMenuRes")
    @RequiresPermissions("base:menu:addMenuRes")
    @AuthResource(name = "添加菜单查找带回的权限资源")
    public List<ZTreeBO<String>> findAddMenuPrivilegeResource(String resourceModuleId, String roleId) {
        return menuService.getSelectMenuPrivilege(resourceModuleId, roleId);
    }

    /**
     * 首页获取左侧菜单
     *
     * @param roleId
     * @param menuModuleId
     * @param systemCode
     * @return
     */
    @RequestMapping("getMenuListIndex")
    @RequiresPermissions("base:menu:getMenuListIndex")
    @AuthResource(name = "首页获取左侧菜单")
    public List<IMenu> getMenuListIndex(int roleId, int menuModuleId, String systemCode) {
        return shiroMenuService.findLeftMenuByRoleId(roleId, menuModuleId, systemCode);
    }
}
