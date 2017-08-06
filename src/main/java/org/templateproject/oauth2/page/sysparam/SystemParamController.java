package org.templateproject.oauth2.page.sysparam;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.templateproject.oauth2.support.TemplateController;

/**
 * Created by tuchen on 2017/7/13.
 */
@Controller
@RequestMapping("/sysparam")
public class SystemParamController extends TemplateController {

    @RequestMapping
    public ModelAndView list() {
        return new ModelAndView("router/sys_param/list");
    }

}
