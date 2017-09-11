package me.wuwenbin.items.oauth2.page.log;

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
@RequestMapping("oauth2/log")
public class LogController extends BaseController {

    @RequestMapping
    @RequiresPermissions("base:log:list")
    @AuthResource(name = "用户登录日志列表展示页面")
    public ModelAndView list() {
        return new ModelAndView("router/log/list");
    }
}
