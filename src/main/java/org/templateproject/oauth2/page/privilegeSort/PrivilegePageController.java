package org.templateproject.oauth2.page.privilegeSort;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.templateproject.oauth2.support.BaseController;

/**
 * Created by zhangteng on 2017/7/19.
 */
@Controller
@RequestMapping("oauth2/privilegeSort")
public class PrivilegePageController extends BaseController {


    @RequestMapping
    public ModelAndView list() {
        return new ModelAndView("router/privilege_page/list");
    }


    @RequestMapping("tree")
    public ModelAndView Tree() {
        return new ModelAndView("router/privilege_page/pIdTree");
    }


    @RequestMapping("id")
    public ModelAndView id() {

        return new ModelAndView("router/privilege_page/idList");
    }
}
