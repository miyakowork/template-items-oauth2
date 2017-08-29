package me.wuwenbin.items.oauth2.page.department;

import me.wuwenbin.items.oauth2.support.BaseController;
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

    @RequestMapping("tree")
    public ModelAndView tree() {
        return new ModelAndView("router/department/pIdTree");
    }

}
