package me.wuwenbin.items.oauth2.page;

import me.wuwenbin.items.oauth2.config.support.realm.UserRealm;
import me.wuwenbin.items.oauth2.support.BaseController;
import me.wuwenbin.items.oauth2.util.ShiroUtils;
import me.wuwenbin.items.oauth2.util.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * 首页控制类
 * Created by Wuwenbin on 2017/7/11.
 */
@Controller
public class IndexController extends BaseController {

    private static final String TO_ROLE_ID = "roleId";

    private UserRealm userRealm;

    @Autowired
    public void setUserRealm(UserRealm userRealm) {
        this.userRealm = userRealm;
    }

    /**
     * 请求系统访问页
     *
     * @return
     */
    @RequestMapping({"", "/"})
    public ModelAndView index() {
        //切换角色id
        //TODO:做更改菜单缓存的操作以及切换菜单
        if (!StringUtils.isEmpty(getRequest().getParameter(TO_ROLE_ID))) {
            userRealm.clearCachedAuthorizationInfo(ShiroUtils.getSubject().getPrincipals());
            int toRoleId = getParameter(Integer.class, TO_ROLE_ID);
            UserUtils.getLoginUser().setDefaultRoleId(toRoleId);
        }
        if (isRouter()) //防止路由地址无限循环请求
            return page("router/dashboard");
        return page("index");
    }

    @RequestMapping({"oauth2", "oauth2/index"})
    public ModelAndView oauth2Index() {
        return redirectPage("/");
    }

    @RequestMapping("oauth2/dashboard")
    public String dashboard() {
        return "router/dashboard";
    }
}
