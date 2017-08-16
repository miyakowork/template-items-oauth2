package org.templateproject.items.oauth2.page.privilege;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by tuchen on 2017/7/21.
 */
@Controller
@RequestMapping("privilege")
public class PrivilegeController {
    @RequestMapping
    public ModelAndView list() {
        return new ModelAndView("router/privilege/list");
    }

    @RequestMapping("roleTree")
    public ModelAndView roleList() {
        return new ModelAndView("router/role/pIdTree");
    }
}
