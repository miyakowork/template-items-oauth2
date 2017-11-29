package me.wuwenbin.items.oauth2.page;

import me.wuwenbin.items.oauth2.config.support.realm.UserRealm;
import me.wuwenbin.items.oauth2.entity.IUser;
import me.wuwenbin.items.oauth2.service.UserService;
import me.wuwenbin.items.oauth2.support.BaseController;
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

    private UserService userService;
    private UserRealm userRealm;

    @Autowired
    public void setUserRealm(UserService userService, UserRealm userRealm) {
        this.userService = userService;
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
        if (!StringUtils.isEmpty(getRequest().getParameter(TO_ROLE_ID))) {
            int toRoleId = getParameter(Integer.class, TO_ROLE_ID);
            IUser user = UserUtils.getLoginUser();
            //TODO:获取修改之前的默认角色id，然后清除该角色id的当前系统的菜单缓存
            try {
                userService.setDefaultRoleId(user.getId(), toRoleId);
            } catch (Exception ignore) {
            }
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

    @RequestMapping("oauth2/systems")
    public String systems() {
        return "systems";
    }
}
