package org.templateproject.oauth2.page.loginsum;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.templateproject.oauth2.support.TemplateController;

/**
 * 用户登录统计
 * Created by Liurongqi on 2017/7/19.
 */

@Controller
@RequestMapping("loginsum")
public class LoginSumController extends TemplateController {

    @RequestMapping
    public ModelAndView chart(){
        return new ModelAndView("router/charts/loginsum");
    }
}
