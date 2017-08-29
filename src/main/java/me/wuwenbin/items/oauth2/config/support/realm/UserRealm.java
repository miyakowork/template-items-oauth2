package me.wuwenbin.items.oauth2.config.support.realm;

import me.wuwenbin.items.oauth2.constant.CacheConsts;
import me.wuwenbin.items.oauth2.entity.IUser;
import me.wuwenbin.items.oauth2.service.shiro.ShiroPermissionService;
import me.wuwenbin.items.oauth2.service.shiro.ShiroRoleService;
import me.wuwenbin.items.oauth2.service.shiro.ShiroUserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 用户权限认证
 *
 * @author wuwenbin
 */
@Component
public class UserRealm extends AuthorizingRealm implements CacheConsts {

    private ShiroUserService shiroUserService;
    private ShiroRoleService shiroRoleService;
    private ShiroPermissionService shiroPermissionService;

    @Autowired
    public void setShiroUserService(ShiroUserService shiroUserService) {
        this.shiroUserService = shiroUserService;
    }

    @Autowired
    public void setShiroRoleService(ShiroRoleService shiroRoleService) {
        this.shiroRoleService = shiroRoleService;
    }

    @Autowired
    public void setShiroPermissionService(ShiroPermissionService shiroPermissionService) {
        this.shiroPermissionService = shiroPermissionService;
    }


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
    protected AuthenticationInfo doGetAuthenticationInfo(
            AuthenticationToken token) throws RuntimeException {
        String username = (String) token.getPrincipal();
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


    @Override
    public void clearCachedAuthorizationInfo(PrincipalCollection principals) {
        super.clearCachedAuthorizationInfo(principals);
    }

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
