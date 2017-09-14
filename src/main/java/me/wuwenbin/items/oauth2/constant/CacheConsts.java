package me.wuwenbin.items.oauth2.constant;


/**
 * Created by wuwenbin on 2017/4/18.
 */
public interface CacheConsts {

    /**
     * 系统默认缓存
     */
    String SYS_CACHE = "defaultCache";

    /**
     * 权限缓存
     */
    String PERMIT_CACHE = "authorizationCache";

    /**
     * 菜单缓存
     */
    String TEMPLATE_CACHE = "templateCache";

    /**
     * 认证缓存
     */
    String AUTH_CACHE = "authenticationCache";

    /**
     * 会话活动缓存
     */
    String SESSION_CACHE = "shiro-activeSessionCache";

    /**
     * 登录记录缓存
     */
    String PASSWORD_RETRY_CACHE = "passwordRetryCache";

}
