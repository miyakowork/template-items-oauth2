package me.wuwenbin.items.oauth2.page.user;

import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by wuwenbin on 2017/8/19/019.
 */

@Controller
@RequestMapping("oauth2/user")
public class UserController {


    @RequestMapping
    @RequiresPermissions("base:user:list")
    @AuthResource(name = "用户列表页面")
    public ModelAndView list() {
        return new ModelAndView("router/user/list");
    }

    @RequestMapping("treeDept")
    @RequiresPermissions("base:user:treeDept")
    @AuthResource(name = "用户部门选择弹框页面")
    public ModelAndView deptTree() {
        return new ModelAndView("router/user/deptTree");
    }

    @RequestMapping("treeRole")
    @RequiresPermissions("base:user:treeRole")
    @AuthResource(name = "用户角色选择弹框页面")
    public ModelAndView roleTree() {
        return new ModelAndView("router/user/roleTree");
    }
}
