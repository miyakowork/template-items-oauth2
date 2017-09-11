package me.wuwenbin.items.oauth2.page.privilege;

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
@RequestMapping("oauth2/privilege")
public class PrivilegeController extends BaseController {

    @RequestMapping
    @RequiresPermissions("base:privilege:list")
    @AuthResource(name = "权限配置页面")
    public ModelAndView list() {
        return new ModelAndView("router/privilege/list");
    }
}
