package me.wuwenbin.items.oauth2.page.privilegePage;

import me.wuwenbin.items.oauth2.support.BaseController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by zhangteng on 2017/7/19.
 */
@Controller
@RequestMapping("oauth2/privilegePage")
public class PrivilegePageController extends BaseController {

    @RequestMapping
    @RequiresPermissions("base:privilegePage:list")
    @AuthResource(name = "页面级权限页面")
    public ModelAndView list() {
        return new ModelAndView("router/privilege_page/list");
    }

    /**
     * 添加页面级权限资源的时候获取的资源树弹出框
     *
     * @return
     */
    @RequestMapping("resourceSelect")
    @RequiresPermissions("base:privilegePage:resourceSelect")
    @AuthResource(name = "添加页面级权限资源的时候获取的资源树弹出框")
    public ModelAndView resourceTree() {
        return new ModelAndView("router/privilege_page/resourceSelect");
    }
}
