package me.wuwenbin.items.oauth2.page.menu;

import me.wuwenbin.items.oauth2.support.BaseController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * created by Wuwenbin on 2017/8/27 at 10:21
 */
@Controller
@RequestMapping("oauth2/menu")
public class MenuController extends BaseController {

    @RequestMapping
    @RequiresPermissions("base:menu:list")
    @AuthResource(name = "菜单树列表表格页面展示")
    public ModelAndView list() {
        return new ModelAndView("router/menu/list");
    }

    @RequestMapping("parentTree")
    @RequiresPermissions("base:menu:parentTree")
    @AuthResource(name = "选择父级菜单的弹出框页面")
    public ModelAndView parentTree() {
        return new ModelAndView("router/menu/parentTree");
    }

    @RequestMapping("resourceSelect")
    @RequiresPermissions("base:menu:resourceSelect")
    @AuthResource(name = "勾选菜单的对应的资源弹出框页面")
    public ModelAndView resourceSelect() {
        return new ModelAndView("router/menu/resourceSelect");
    }
}
