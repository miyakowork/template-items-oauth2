package org.templateproject.oauth2.page.resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.templateproject.oauth2.support.TemplateController;

/**
 * Created by Liurongqi on 2017/7/13.
 */
@Controller
@RequestMapping("resource")
public class resourceController extends TemplateController {
    @RequestMapping
    public ModelAndView list(){
        return new ModelAndView("router/resource/list");
    }
}
