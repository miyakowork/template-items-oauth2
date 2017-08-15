package org.templateproject.oauth2.service.shiro;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.oauth2.config.support.password.PasswordHelper;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ServiceConsts;
import org.templateproject.oauth2.entity.OauthUser;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;

/**
 * 有关登录权限的Service操作
 * Created by Wuwenbin on 2017/7/17.
 */
@Service
@Transactional
public class ShiroUserService extends SimpleBaseCrudService<OauthUser, Integer> {

    private PasswordHelper passwordHelper;

    @Autowired
    public void setPasswordHelper(PasswordHelper passwordHelper) {
        this.passwordHelper = passwordHelper;
    }

    /**
     * 修改密码
     *
     * @param userId      用户id
     * @param password    修改前的密码
     * @param newPassword 新密码
     * @throws Exception 修改用户密码异常
     */
    public void changePasswordById(int userId, String password, String newPassword) throws Exception {
        OauthUser user = findOne(userId, OauthUser.class);
        String oldRightPassword = user.getPassword();
        user.setPassword(password);
        String inputPassword = passwordHelper.getPassword(user);
        if (oldRightPassword.equals(inputPassword)) {
            user.setPassword(newPassword);
            passwordHelper.encryptPassword(user);
            save(user, OauthUser.class);
        } else throw new RuntimeException("原始密码错误");
    }

    /**
     * 修改密码
     *
     * @param user        用户对象
     * @param newPassword 新密码
     * @throws Exception 修改出现的异常
     */
    public void changePasswordByUser(OauthUser user, String newPassword) throws Exception {
        user.setPassword(newPassword);
        passwordHelper.encryptPassword(user);
        edit(user, OauthUser.class);
    }

    /**
     * 根据用户名查找用户，缓存有就从缓存中取
     *
     * @param username 用户名
     * @return 用户对象
     */
    public OauthUser findByUserName(String username) {
        if (StringUtils.isEmpty(username))
            return null;
        String sql = "SELECT * FROM T_OAUTH_USER WHERE USERNAME = ?";
        return mysql.findBeanByArray(sql, OauthUser.class, username);
    }

    /**
     * 添加新用户
     *
     * @param user 新增的用户对象
     * @return 新增条数
     * @throws Exception 添加用户时出现的异常
     */
    public int addNewUser(OauthUser user) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(OauthUser.class);
        String sql = sbb.insertRoutersWithoutPk(CommonConsts.CREATE_ROUTER,
                CommonConsts.ENABLED_ROUTER, CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER, ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER);
        user.preInsert();
        passwordHelper.encryptPassword(user);
        return mysql.executeBean(sql, user);
    }
}
