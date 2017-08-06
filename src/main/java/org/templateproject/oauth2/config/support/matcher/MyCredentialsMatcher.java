package org.templateproject.oauth2.config.support.matcher;

import org.apache.shiro.authc.*;
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.codec.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.templateproject.oauth2.config.support.password.PasswordHelper;
import org.templateproject.oauth2.constant.ShiroConsts;
import org.templateproject.oauth2.entity.OauthUser;
import org.templateproject.oauth2.service.LogService;
import org.templateproject.oauth2.service.shiro.ShiroUserService;
import org.templateproject.oauth2.util.UserUtils;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 凭证匹配器自定义实现
 * Created by wuwenbin on 2017/2/6.
 */
@Component
public class MyCredentialsMatcher extends SimpleCredentialsMatcher {

    private static final Logger LOGGER = LoggerFactory.getLogger(MyCredentialsMatcher.class);

    private PasswordHelper passwordHelper;
    private ShiroUserService userService;
    private CacheManager cacheManager;
    private LogService logService;

    private Cache<String, AtomicInteger> passwordRetryCache;

    @Autowired
    public void setPasswordRetryCache() {
        this.passwordRetryCache = cacheManager.getCache("passwordRetryCache");
    }

    @Autowired
    public MyCredentialsMatcher(PasswordHelper passwordHelper, ShiroUserService userService, CacheManager cacheManager, LogService logService) {
        this.passwordHelper = passwordHelper;
        this.userService = userService;
        this.cacheManager = cacheManager;
        this.logService = logService;
    }

    @Override
    public boolean doCredentialsMatch(AuthenticationToken authToken, AuthenticationInfo info) {
        String username = (String) authToken.getPrincipal();
        //retry count + 1
        AtomicInteger retryCount = passwordRetryCache.get(username);
        if (retryCount == null) {
            retryCount = new AtomicInteger(0);
            passwordRetryCache.put(username, retryCount);
        }
        if (retryCount.incrementAndGet() > 5) {
            //if retry count > 5 throw
            throw new ExcessiveAttemptsException();
        }

        Object tokenCredentials = encrypt(authToken);
        Object accountCredentials = getCredentials(info);

        boolean matches = equals(tokenCredentials, accountCredentials);
        if (matches) {
            //clear retry count
            passwordRetryCache.remove(username);
            //验证用户成功了，把用户名信息放到session中去
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            request.getSession().setAttribute(ShiroConsts.SESSION_USERNAME_KEY, username);
            try {
                logService.traceLog(userService.findByUserName(username).getId(), getRemoteAddr(request));
            } catch (Exception e) {
                e.printStackTrace();
                LOGGER.error("记录用户登录日志失败，异常信息：{}", e.getMessage());
            }
        }
        return matches;
    }

    /**
     * 将前台传递进来的密码使用自定义的方式进行加密处理进行匹配
     *
     * @return
     */
    private String encrypt(AuthenticationToken authToken) {
        UsernamePasswordToken token = (UsernamePasswordToken) authToken;
        String username = token.getUsername();
        char[] password = token.getPassword();
        String plainPassword = new String(Base64.decode(String.valueOf(password)));
        OauthUser user = userService.findByUserName(username);
        if (user == null) {
            throw new UnknownAccountException();//没找到帐号
        } else {
            return passwordHelper.getPassword(user, plainPassword);
        }
    }


    /**
     * 获取IP地址
     * <p>
     * 使用Nginx等反向代理软件， 则不能通过request.getRemoteAddr()获取IP地址
     * 如果使用了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP地址，X-Forwarded-For中第一个非unknown的有效IP字符串，则为真实IP地址
     *
     * @return
     */
    private String getRemoteAddr(HttpServletRequest request) {
        String remoteAddress = null;
        try {
            remoteAddress = request.getHeader("x-forwarded-for");
            if (StringUtils.isEmpty(remoteAddress) || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = request.getHeader("Proxy-Client-IP");
            }
            if (StringUtils.isEmpty(remoteAddress) || remoteAddress.length() == 0 || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = request.getHeader("WL-Proxy-Client-IP");
            }
            if (StringUtils.isEmpty(remoteAddress) || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = request.getHeader("HTTP_CLIENT_IP");
            }
            if (StringUtils.isEmpty(remoteAddress) || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = request.getHeader("HTTP_X_FORWARDED_FOR");
            }
            if (StringUtils.isEmpty(remoteAddress) || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = request.getRemoteAddr();
            }
        } catch (Exception ignored) {
        }
        return remoteAddress;
    }
}
