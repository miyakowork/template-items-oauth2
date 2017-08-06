package org.templateproject.oauth2.page.menumodule;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by yuanqi on 2017/7/12/012.
 */
@Controller
@RequestMapping("menumodule")
public class menumoduleController{

    @RequestMapping
    public ModelAndView list(){
        return new ModelAndView("router/menumodule/list");
    }

    @RequestMapping("add")
    public ModelAndView add(){
        return new ModelAndView("router/menumodule/add");
    }


}
