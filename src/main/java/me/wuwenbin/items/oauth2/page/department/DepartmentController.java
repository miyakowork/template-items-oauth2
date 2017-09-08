package me.wuwenbin.items.oauth2.page.department;

import me.wuwenbin.items.oauth2.support.BaseController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import me.wuwenbin.items.oauth2.support.annotation.AuthScan;
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
@AuthScan
public class DepartmentController extends BaseController {

    @RequestMapping("tree")
    @AuthResource(name = "父部门节点的树")
    @RequiresPermissions("base:department:parentTree")
    public ModelAndView tree() {
        return new ModelAndView("router/department/pIdTree");
    }

}
