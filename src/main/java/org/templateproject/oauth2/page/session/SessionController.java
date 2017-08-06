package org.templateproject.oauth2.page.session;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.templateproject.oauth2.support.BaseController;
import org.templateproject.oauth2.support.TemplateController;

/**
 * Created by Wuwenbin on 2017/7/20.
 */
@Controller
@RequestMapping("session")
public class SessionController extends TemplateController {

    @RequestMapping
    public ModelAndView list(){
        return new ModelAndView("router/session/list");
    }
}
