package me.wuwenbin.items.oauth2.support;


import me.wuwenbin.items.oauth2.util.UserUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

/**
 * 控制类基类
 * Created by Wuwenbin on 2017/7/31.
 */
public class BaseController extends TemplateController {

    /**
     * 路由页面
     *
     * @param router
     * @return
     */
    protected ModelAndView page(String router) {
        return new ModelAndView(router);
    }

    /**
     * 重定向页面路由
     *
     * @param router
     * @return
     */
    protected ModelAndView redirectPage(String router) {
        return new ModelAndView(new RedirectView(router));
    }

    /**
     * 转发地址
     *
     * @param router
     * @return
     */
    protected ModelAndView forwardPage(String router) {
        return new ModelAndView("forward:".concat(router));
    }

    /**
     * 用户是否已登录
     *
     * @return
     */
    protected boolean isUserLogged() {
        return UserUtils.getLoginUser() != null;
    }

}
