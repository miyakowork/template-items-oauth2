package org.templateproject.items.oauth2.util;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.templateproject.items.oauth2.entity.IUser;
import org.templateproject.items.oauth2.service.shiro.ShiroUserService;

/**
 * 用户工具类
 * Created by Wuwenbin on 2017/7/17.
 */
public class UserUtils {
    /**
     * 用户服务对象
     */
    private static ShiroUserService userService = SpringUtils.getBean(ShiroUserService.class);

    /**
     * 获取当前访问用户名
     *
     * @return 当前登录用户名
     */
    public static String getLoginUserName() {
        Subject subject = SecurityUtils.getSubject();
        return (String) subject.getPrincipal();
    }

    /**
     * 获取当前登录用户
     *
     * @return 当前登录用户
     */
    public static IUser getLoginUser() {
        Subject subject = SecurityUtils.getSubject();
        String userName = (String) subject.getPrincipal();
        return userService.findByUserName(userName);
    }

}
