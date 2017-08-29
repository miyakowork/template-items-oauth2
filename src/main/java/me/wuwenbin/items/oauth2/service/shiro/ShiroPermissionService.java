package me.wuwenbin.items.oauth2.service.shiro;

import me.wuwenbin.items.oauth2.entity.IRole;
import me.wuwenbin.items.oauth2.service.base.SimpleBaseCrudService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 权限信息Service
 * Created by Wuwenbin on 2017/7/17.
 */
@Service
@Transactional
public class ShiroPermissionService extends SimpleBaseCrudService<IRole, Integer> {

    /**
     * 通过角色id查找当前角色id的所拥有的权限表示
     *
     * @param roleId 角色id
     * @return 所拥有的权限标识
     */
    public Set<String> findPermissionsByRoleId(int roleId) {
        String sql = "SELECT tor.PERMISSION_MARK AS pm FROM T_OAUTH_RESOURCE tor" +
                " WHERE tor.ENABLED = 1 AND tor.ID IN " +
                "(SELECT tom.RESOURCE_ID FROM T_OAUTH_MENU tom" +
                " WHERE tom.ENABLED = 1 AND tom.RESOURCE_ID = tor.ID AND tom.ROLE_ID = ?)";
        List<Map<String, Object>> permissions = mysql.findListMapByArray(sql, roleId);
        Set<String> permissionMarks = new HashSet<>(permissions.size());
        for (Map<String, Object> map : permissions) {
            permissionMarks.add(map.get("pm").toString());
        }
        return permissionMarks;
    }

    /**
     * 通过用户id查找当前用户id的所拥有的权限表示
     *
     * @param userId 用户id
     * @return 所拥有的权限标识
     */
    public Set<String> findPermissionsByUserId(int userId) {
        String sql = "SELECT tor.PERMISSION_MARK AS pm FROM T_OAUTH_RESOURCE tor" +
                " WHERE tor.ENABLED = 1 AND tor.ID IN " +
                "(SELECT tom.RESOURCE_ID FROM T_OAUTH_MENU tom " +
                "WHERE tom.RESOURCE_ID = tor.ID AND tom.ENABLED = 1 AND tom.ROLE_ID IN " +
                "(SELECT tour.ROLE_ID FROM T_OAUTH_USER_ROLE tour WHERE tour.USER_ID = ?))";
        List<Map<String, Object>> permissions = mysql.findListMapByArray(sql, userId);
        Set<String> permissionMarks = new HashSet<>(permissions.size());
        for (Map<String, Object> map : permissions) {
            permissionMarks.add(map.get("pm").toString());
        }
        return permissionMarks;
    }
}
