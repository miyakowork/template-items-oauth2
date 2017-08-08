package org.templateproject.oauth2.constant;

import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;

/**
 * Shiro静态常量
 * Created by wuwenbin on 2017/4/25.
 */
public interface ShiroConsts {

    //获取当前session中的用户名key
    String SESSION_USERNAME_KEY = "session.username.key";

    //获取登录失败时候的错误异常的key
    String LOGIN_FAILURE = FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME;

    //获取强制退出的标识的key
    String SESSION_FORCE_LOGOUT_KEY = "session.force.logout";

    //获取当前登录用的使用的登录角色的key
    String SESSION_CURRENT_LOGIN_ROLE = "session.current.login.role";

    //获取登录前的url，准备登陆成功之后跳转的url的key
    String BEGORE_LOGIN_SUCCESS_URL = "before.login.success.url";
}

