package org.templateproject.oauth2.page.privilegepage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by zhangteng on 2017/7/19.
 */
@Controller
@RequestMapping("privilegepage")
public class PrivilegePageController {


    @RequestMapping
    public ModelAndView list() {
        return new ModelAndView("router/privilegepage/list");
    }


    @RequestMapping("tree")
    public ModelAndView Tree() {
        return new ModelAndView("router/privilegepage/pIdTree");
    }


    @RequestMapping("id")
    public ModelAndView id() {

        return new ModelAndView("router/privilegepage/idList");
    }
}
