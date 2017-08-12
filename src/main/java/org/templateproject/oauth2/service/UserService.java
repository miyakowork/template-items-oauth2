package org.templateproject.oauth2.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.oauth2.config.support.password.PasswordHelper;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ServiceConsts;
import org.templateproject.oauth2.entity.OauthRole;
import org.templateproject.oauth2.entity.OauthUser;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.oauth2.support.pojo.bo.UserBO;
import org.templateproject.oauth2.support.pojo.vo.UserVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wuwenbin on 2017/8/7.
 */

@Service
@Transactional
@SqlMapper("user")
public class UserService extends SimpleBaseCrudService<OauthUser, Integer> {

    /**
     * 获取用户对象分页信息
     *
     * @param page
     * @param userBO
     * @return
     */
    public Page<UserVO> findUserPage(Page<UserVO> page, UserBO userBO) {
        return findPagination(page, UserVO.class, sql(), userBO);
    }


    /**
     * 修改用户
     *
     * @param oauthUser
     * @return
     * @throws Exception
     */
    public boolean edit(OauthUser oauthUser) throws Exception {
        return h2Dao.executeBean(sql(), oauthUser) == 1;
    }



    /**
     * 批量禁用用户
     *
     * @param ids
     * @throws Exception
     */
    public void disabledUser(String ids) throws Exception {
        String[] userIds = ids.split(",");
        executeBatch(sql(), "id", userIds);
    }
}
