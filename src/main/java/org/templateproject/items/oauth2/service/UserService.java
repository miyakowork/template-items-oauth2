package org.templateproject.items.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.items.oauth2.entity.IUser;
import org.templateproject.items.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.items.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.items.oauth2.support.pojo.bo.UserBO;
import org.templateproject.items.oauth2.support.pojo.vo.UserVO;
import org.templateproject.pojo.page.Page;

/**
 * Created by wuwenbin on 2017/8/7.
 */

@Service
@Transactional
@SqlMapper("user")
public class UserService extends SimpleBaseCrudService<IUser, Integer> {

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
     * @param iUser
     * @return
     * @throws Exception
     */
    public boolean edit(IUser iUser) throws Exception {
        return mysql.executeBean(sql(), iUser) == 1;
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
