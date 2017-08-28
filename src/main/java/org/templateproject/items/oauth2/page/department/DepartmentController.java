package org.templateproject.items.oauth2.page.department;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.templateproject.items.oauth2.support.BaseController;

/**
 * 部门管理控制层
 * Created by Liurongqi on 2017/7/12.
 */
@Controller
@RequestMapping("oauth2/department")
public class DepartmentController extends BaseController {

    @RequestMapping("tree")
    public ModelAndView tree() {
        return new ModelAndView("router/department/pIdTree");
    }

}
