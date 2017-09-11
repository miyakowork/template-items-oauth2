package me.wuwenbin.items.oauth2.page.menuModule;

import me.wuwenbin.items.oauth2.support.BaseController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * created by Wuwenbin on 2017/9/8 at 14:18
 */
@Controller
@RequestMapping("oauth2/menuModule")
public class MenuModuleController extends BaseController {

    @RequestMapping
    @RequiresPermissions("base:menuModule:list")
    @AuthResource(name = "菜单模块页面展示")
    public ModelAndView list() {
        return new ModelAndView("router/menu_module/list");
    }
}
