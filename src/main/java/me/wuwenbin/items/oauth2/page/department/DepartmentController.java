package me.wuwenbin.items.oauth2.page.department;

import me.wuwenbin.items.oauth2.support.BaseController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * 部门管理控制层
 * Created by wuwenbin on 2017/7/12.
 */
@Controller
@RequestMapping("oauth2/department")
public class DepartmentController extends BaseController {

    @RequestMapping
    @RequiresPermissions("base:department:list")
    @AuthResource(name = "部门列表展示页面")
    public ModelAndView list() {
        return new ModelAndView("router/department/list");
    }

    @RequestMapping("tree")
    @RequiresPermissions("base:department:tree")
    @AuthResource(name = "父部门节点的树展示页面")
    public ModelAndView tree() {
        return new ModelAndView("router/department/pIdTree");
    }

}
