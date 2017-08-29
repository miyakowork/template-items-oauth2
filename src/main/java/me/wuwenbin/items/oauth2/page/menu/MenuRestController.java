package me.wuwenbin.items.oauth2.page.menu;

import me.wuwenbin.items.oauth2.entity.IMenu;
import me.wuwenbin.items.oauth2.service.MenuService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.pojo.bo.ZTreeBO;
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

    @Autowired
    public void setMenuService(MenuService menuService) {
        this.menuService = menuService;
    }

    /**
     * 菜单表格树
     *
     * @param roleId
     * @return
     */
    @RequestMapping("list")
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
    public List<ZTreeBO> findMenuTree(String menuModuleId) {
        if (TP.stringhelper.isNotEmpty(menuModuleId)) {
            return menuService.menuList2MenuTree(menuService.findEnableMenusByMenuModuleId(menuModuleId));
        } else {
            return menuService.menuList2MenuTree(menuService.findEnabledListBean(IMenu.class));
        }
    }
}
