package me.wuwenbin.items.oauth2.config.support.realm;

import me.wuwenbin.items.oauth2.constant.CacheConsts;
import me.wuwenbin.items.oauth2.constant.ShiroConsts;
import me.wuwenbin.items.oauth2.entity.ISystemModule;
import me.wuwenbin.items.oauth2.entity.IUser;
import me.wuwenbin.items.oauth2.service.UserService;
import me.wuwenbin.items.oauth2.service.shiro.ShiroPermissionService;
import me.wuwenbin.items.oauth2.service.shiro.ShiroRoleService;
import me.wuwenbin.items.oauth2.service.shiro.ShiroUserService;
import me.wuwenbin.items.oauth2.util.HttpUtils;
import me.wuwenbin.items.oauth2.util.SpringUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 用户权限认证
 *
 * @author wuwenbin
 */
@Component
public class UserRealm extends AuthorizingRealm implements CacheConsts {

    private ShiroUserService shiroUserService = SpringUtils.getBean(ShiroUserService.class);
    private ShiroRoleService shiroRoleService = SpringUtils.getBean(ShiroRoleService.class);
    private ShiroPermissionService shiroPermissionService = SpringUtils.getBean(ShiroPermissionService.class);


    /**
     * 授权 每次点击都会进行验证
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        String username = (String) principals.getPrimaryPrincipal();
        IUser currentUser = shiroUserService.findByUserName(username);
        //获取当前用户的角色名称
        authorizationInfo.setRoles(shiroRoleService.findRoleNamesByUserId(currentUser.getId()));
        //获取当前用户默认角色
        int roleId = currentUser.getDefaultRoleId();
        authorizationInfo.setStringPermissions(shiroPermissionService.findPermissionsByRoleId(roleId));
        return authorizationInfo;
    }


    /**
     * 登录认证 登录时验证
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws RuntimeException {
        String username = (String) token.getPrincipal();
        HttpServletRequest request = HttpUtils.getRequest();
        List<ISystemModule> systemModules = SpringUtils.getBean(UserService.class).findSystemModuleUserCanLogin(username);
        if (systemModules != null) {
            if (systemModules.size() == 1)//表示该用户仅有一个可登录的系统，直接让他登录此系统首页，不显示系统选择界面
                request.getSession().setAttribute(ShiroConsts.BEGORE_LOGIN_SUCCESS_URL, systemModules.get(0).getIndexUrl());
            //其余的则表示该用户有多个可登录的系统，登陆成功之后显示系统选择界面
        } else {//表示该用户没有一个可以登录的系统，显示错误页面
            //TODO:转向错误提示页面（提示该用户没有一个系统可以让他登录）
            request.getSession().setAttribute(ShiroConsts.BEGORE_LOGIN_SUCCESS_URL, "/error/404");
        }

        IUser user = shiroUserService.findByUserName(username);
        if (user == null) {
            throw new UnknownAccountException();// 没找到帐号
        }
        if (Boolean.FALSE.equals(user.getEnabled())) {
            throw new LockedAccountException(); // 帐号锁定
        }
        // 交给AuthenticatingRealm使用CredentialsMatcher进行密码匹配
        return new SimpleAuthenticationInfo(
                user.getUsername(), // 用户名
                user.getPassword(), // 密码
                ByteSource.Util.bytes(user.getCredentialsSalt()),// salt=username+salt
                getName() // realm name
        );
    }


    /**
     * 清除授权
     *
     * @param principals
     */
    @Override
    public void clearCachedAuthorizationInfo(PrincipalCollection principals) {
        super.clearCachedAuthorizationInfo(principals);
    }

    /**
     * 清除认证
     *
     * @param principals
     */
    @Override
    public void clearCachedAuthenticationInfo(PrincipalCollection principals) {
        super.clearCachedAuthenticationInfo(principals);
    }


    @Override
    public void clearCache(PrincipalCollection principals) {
        super.clearCache(principals);
    }

    private void clearAllCachedAuthorizationInfo() {
        getAuthorizationCache().clear();
    }

    private void clearAllCachedAuthenticationInfo() {
        getAuthenticationCache().clear();
    }

    @SuppressWarnings("unused")
    public void clearAllCache() {
        clearAllCachedAuthenticationInfo();
        clearAllCachedAuthorizationInfo();
    }

}
