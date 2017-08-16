package org.templateproject.items.oauth2.page;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.templateproject.items.oauth2.support.TemplateController;
import org.templateproject.items.oauth2.util.ShiroUtils;
import org.templateproject.items.oauth2.util.UserUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * 登录控制类
 * Created by Wuwenbin on 2017/7/11.
 */
@Controller
public class LoginController extends TemplateController {

    @RequestMapping(value = "login", method = RequestMethod.GET)
    public ModelAndView login() throws Exception {
        String userName = UserUtils.getLoginUserName();
        if (StringUtils.isNotEmpty(userName)) {
            return new ModelAndView(new RedirectView(""));
        }
        return new ModelAndView("login");
    }

    @RequestMapping(value = "login/router", method = RequestMethod.GET)
    public ModelAndView loginRouter() {
        return new ModelAndView("router/login");
    }


    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public ModelAndView logout(HttpServletRequest request) {
        request.getSession().invalidate();
        ShiroUtils.logout();
        return new ModelAndView(new RedirectView("login"));
    }

}
