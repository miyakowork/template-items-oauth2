package me.wuwenbin.items.oauth2.service;

import me.wuwenbin.items.oauth2.entity.IUser;
import me.wuwenbin.items.oauth2.service.base.SimpleBaseCrudService;
import me.wuwenbin.items.oauth2.support.pojo.bo.UserBO;
import me.wuwenbin.items.oauth2.support.pojo.vo.UserVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.pojo.page.Page;

/**
 * Created by wuwenbin on 2017/8/7.
 */

@Service
@Transactional
public class UserService extends SimpleBaseCrudService<IUser, Integer> {

    /**
     * 获取用户对象分页信息
     *
     * @param page
     * @param userBO
     * @return
     */
    public Page<UserVO> findUserPage(Page<UserVO> page, UserBO userBO) {
        String sql = "SELECT tou.*, tod.name AS departmentName, tor.cn_name AS roleName" +
                " FROM T_OAUTH_USER tou LEFT JOIN T_OAUTH_DEPARTMENT tod ON tou.dept_id = tod.id" +
                " LEFT JOIN T_OAUTH_ROLE tor ON tou.default_role_id = tor.id";
        return findPagination(page, UserVO.class, sql, userBO);
    }


    /**
     * 修改用户
     *
     * @param iUser
     * @return
     * @throws Exception
     */
    public boolean edit(IUser iUser) throws Exception {
        String sql = "UPDATE t_oauth_user" +
                " SET cname = :cname, email = :email, mobile = :mobile, order_index = :orderIndex, dept_id = :deptId," +
                " default_role_id = :defaultRoleId, enabled = :enabled, remark = :remark" +
                " WHERE id = :id";
        return mysql.executeBean(sql, iUser) == 1;
    }


    /**
     * 批量禁用用户
     *
     * @param ids
     * @throws Exception
     */
    public void disabledUser(String ids) throws Exception {
        String[] userIds = ids.split(",");
        String sql = "UPDATE T_OAUTH_USER SET ENABLED = 0 WHERE id = :id";
        executeBatch(sql, "id", userIds);
    }
}
