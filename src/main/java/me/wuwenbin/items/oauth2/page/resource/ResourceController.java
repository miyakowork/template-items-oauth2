package me.wuwenbin.items.oauth2.page.resource;

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
@RequestMapping("oauth2/resource")
public class ResourceController extends BaseController {

    @RequestMapping
    @RequiresPermissions("base:resource:list")
    @AuthResource(name = "资源列表页面")
    public ModelAndView list() {
        return new ModelAndView("router/resource/list");
    }
}
