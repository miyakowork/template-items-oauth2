package org.templateproject.oauth2.page.log;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by yuanqi on 2017/7/12/012.
 */
@Controller
@RequestMapping("log")
public class logController {

    @RequestMapping
    public ModelAndView list(){
        return new ModelAndView("router/log/list");
    }

}
