package org.templateproject.oauth2.constant;

import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;

/**
 * Shiro静态常量
 * Created by wuwenbin on 2017/4/25.
 */
public interface ShiroConsts {

    String SESSION_USERNAME_KEY = "session.username.key";

    String LOGIN_FAILURE = FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME;

    String SESSION_FORCE_LOGOUT_KEY = "session.force.logout";

    /**
     * 当前登录用的使用的登录角色
     */
    String SESSION_CURRENT_LOGIN_ROLE = "session.current.login.role";
}

