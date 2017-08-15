package org.templateproject.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.oauth2.entity.OauthUser;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.oauth2.support.pojo.bo.UserBO;
import org.templateproject.oauth2.support.pojo.vo.UserVO;
import org.templateproject.pojo.page.Page;

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
        return mysql.executeBean(sql(), oauthUser) == 1;
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
