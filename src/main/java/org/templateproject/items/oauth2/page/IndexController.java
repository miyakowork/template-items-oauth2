package org.templateproject.items.oauth2.page;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.templateproject.items.oauth2.config.support.realm.UserRealm;
import org.templateproject.items.oauth2.support.TemplateController;
import org.templateproject.items.oauth2.util.ShiroUtils;

/**
 * 首页控制类
 * Created by Wuwenbin on 2017/7/11.
 */
@Controller
public class IndexController extends TemplateController {

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
    @RequestMapping("")
    public String index() {
        //切换角色id
        if (!StringUtils.isEmpty(getRequest().getParameter(TO_ROLE_ID))) {
            userRealm.clearCachedAuthorizationInfo(ShiroUtils.getSubject().getPrincipals());
            int toRoleId = getParameter(Integer.class, TO_ROLE_ID);
            ShiroUtils.getUserEntity().setDefaultRoleId(toRoleId);
        }
        if (isRouter()) //防止路由地址无限循环请求
            return "router/dashboard";
        else return "index";
    }

    /**
     * 登录进系统的首页展示
     *
     * @return
     */
    @RequestMapping({"oauth2/dashboard", "oauth2/index"})
    public String dashboard() {
        return "router/dashboard";
    }

}
