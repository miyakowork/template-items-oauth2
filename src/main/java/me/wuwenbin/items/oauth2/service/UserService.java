package me.wuwenbin.items.oauth2.service;

import me.wuwenbin.items.oauth2.entity.ISystemModule;
import me.wuwenbin.items.oauth2.entity.IUser;
import me.wuwenbin.items.oauth2.service.base.SimpleBaseCrudService;
import me.wuwenbin.items.oauth2.support.pojo.bo.UserBO;
import me.wuwenbin.items.oauth2.support.pojo.vo.UserVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.pojo.page.Page;

import java.util.*;

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
     * 通过用户名查找该用户可登录的系统有哪些
     *
     * @param username
     * @return
     */
    public List<ISystemModule> findSystemModuleUserCanLogin(String username) {
        String sql = "SELECT DISTINCT m.* FROM t_oauth_system_module m WHERE system_code " +
                "IN(SELECT DISTINCT system_code FROM t_oauth_role WHERE  id " +
                "IN(SELECT role_id FROM t_oauth_user_role ur,t_oauth_user u WHERE u.id = ur.user_id AND u.username = ?))";
        return mysql.findListBeanByArray(sql, ISystemModule.class, username);
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
        simpleExecutes(sql, "id", userIds);
    }

    /**
     * 修改用户角色组
     *
     * @param roleIds
     * @param userId
     * @throws Exception
     */
    public void modifyUserRoles(String[] roleIds, String userId) throws Exception {
        String sql = "delete from t_oauth_user_role where user_id = ?";
        mysql.executeArray(sql, userId);
        Collection<Map<String, Object>> maps = new ArrayList<>(roleIds.length);
        for (String roleId : roleIds) {
            Map<String, Object> map = new HashMap<>();
            map.put("roleId", roleId);
            map.put("userId", userId);
            maps.add(map);
        }
        sql = "insert into t_oauth_user_role(user_id,role_id,enabled) values(:userId,:roleId,1)";
        mysql.executeBatchByCollectionMaps(sql, maps);
    }

    /**
     * 设置更换默认角色id
     *
     * @param userId
     * @param roleId
     * @throws Exception
     */
    public void setDefaultRoleId(int userId, int roleId) throws Exception {
        String sql = "update t_oauth_user set default_role_id = ? where id = ?";
        mysql.executeArray(sql, roleId, userId);
    }
}
