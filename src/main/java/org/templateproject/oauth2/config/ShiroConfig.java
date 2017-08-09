package org.templateproject.oauth2.config;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.apache.shiro.codec.Base64;
import org.apache.shiro.session.mgt.SessionManager;
import org.apache.shiro.session.mgt.quartz.QuartzSessionValidationScheduler;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.templateproject.oauth2.config.support.realm.UserRealm;
import org.templateproject.oauth2.config.support.session.MySQLSessionDao;
import org.templateproject.oauth2.constant.CacheConsts;

/**
 * Shiro权限配置
 * Created by wuwenbin on 2017/5/22.
 */
@Configuration
public class ShiroConfig implements CacheConsts {

    /**
     * Realm实现
     *
     * @param credentialsMatcher
     * @return
     */
    @Bean
    public UserRealm userRealm(CredentialsMatcher credentialsMatcher) {
        UserRealm userRealm = new UserRealm();
        userRealm.setCredentialsMatcher(credentialsMatcher);
        userRealm.setCachingEnabled(false);
        userRealm.setAuthenticationCachingEnabled(true);
        userRealm.setAuthenticationCacheName(AUTH_CACHE);//认证缓存的key
        userRealm.setAuthorizationCachingEnabled(true);
        userRealm.setAuthorizationCacheName(PERMIT_CACHE);//权限缓存的key
        return userRealm;
    }

    /**
     * 会话Cookie模板
     *
     * @return
     */
    @Bean
    public SimpleCookie sessionIdCookie() {
        SimpleCookie simpleCookie = new SimpleCookie("sid");
        simpleCookie.setHttpOnly(true);
        simpleCookie.setMaxAge(-1);
        return simpleCookie;
    }

    @Bean
    public SimpleCookie rememberMeCookie() {
        SimpleCookie simpleCookie = new SimpleCookie("rememberMe");
        simpleCookie.setHttpOnly(true);
        simpleCookie.setMaxAge(7 * 24 * 60 * 60);
        return simpleCookie;
    }

    /**
     * rememberMe管理器
     *
     * @return
     */
    @Bean
    public CookieRememberMeManager rememberMeManager(SimpleCookie rememberMeCookie) {
        CookieRememberMeManager rememberMeManager = new CookieRememberMeManager();
        rememberMeManager.setCipherKey(Base64.decode("4AvVhmFLUs0KTA3Kprsdag=="));//rememberMe cookie加密的密钥 建议每个项目都不一样 默认AES算法 密钥长度（128 256 512 位）
        rememberMeManager.setCookie(rememberMeCookie);
        return rememberMeManager;
    }

    /**
     * 会话验证调度器。调度时间间隔默认1小时定时清理过期会话
     *
     * @param sessionManager
     * @return
     */
    @Bean
    public QuartzSessionValidationScheduler sessionValidationScheduler(DefaultWebSessionManager sessionManager) {
        QuartzSessionValidationScheduler sessionValidationScheduler = new QuartzSessionValidationScheduler();
        sessionValidationScheduler.setSessionManager(sessionManager);//设置会话验证调度器进行会话验证时的会话管理器
        return sessionValidationScheduler;
    }


    /**
     * 会话管理器。全局会话超时时间，默认30分钟，即如果30分钟内没有访问会话将过期
     *
     * @param sessionIdCookie
     * @param sessionDao
     * @return
     */
    @Bean
    public DefaultWebSessionManager sessionManager(SimpleCookie sessionIdCookie, MySQLSessionDao sessionDao) {
        DefaultWebSessionManager sessionManager = new DefaultWebSessionManager();
        sessionManager.setGlobalSessionTimeout(30 * 60 * 1000);//session有效空闲时间30分钟默认
        sessionManager.setDeleteInvalidSessions(true);//删除失效的会话
        sessionManager.setSessionDAO(sessionDao);//sessionDAO
        sessionManager.setSessionIdCookie(sessionIdCookie);
        sessionManager.setSessionIdCookieEnabled(true);
        return sessionManager;
    }

    /**
     * 安全管理器
     *
     * @param userRealm
     * @param sessionManager
     * @param cacheManager
     * @param rememberMeManager
     * @return
     */
    @Bean
    public DefaultWebSecurityManager securityManager(
            UserRealm userRealm,
            SessionManager sessionManager,
            EhCacheManager cacheManager,
            CookieRememberMeManager rememberMeManager) {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager(userRealm);
        securityManager.setSessionManager(sessionManager);
        securityManager.setCacheManager(cacheManager);
        securityManager.setRememberMeManager(rememberMeManager);
        SecurityUtils.setSecurityManager(securityManager);
        return securityManager;
    }


}
