package me.wuwenbin.items.oauth2.service;

import me.wuwenbin.items.oauth2.entity.IRole;
import me.wuwenbin.items.oauth2.service.base.SimpleBaseCrudService;
import me.wuwenbin.items.oauth2.support.pojo.bo.RoleBo;
import me.wuwenbin.items.oauth2.support.pojo.bo.ZTreeBO;
import me.wuwenbin.items.oauth2.support.pojo.vo.RoleVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.pojo.page.Page;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

/**
 * 继承AbstractBaseCrudService
 * Created by tuchen on 2017/7/12.
 */
@Service
@Transactional
public class RoleService extends SimpleBaseCrudService<IRole, Integer> {

    /**
     * 通过名称模糊 查询Page
     *
     * @param page   page
     * @param roleBo roleBo
     * @return Page
     */
    public Page<RoleVO> findRolePage(Page<RoleVO> page, RoleBo roleBo) {
        String sql = "SELECT tor.*, tor1.CN_NAME  AS parent_name, tou1.username AS create_name, tou2.username AS update_name, tosm.NAME  AS system_module_name" +
                " FROM t_oauth_user tou1, t_oauth_user tou2, t_oauth_role tor LEFT JOIN t_oauth_role tor1 ON tor1.id = tor.parent_id" +
                " LEFT JOIN T_OAUTH_SYSTEM_MODULE tosm ON tor.SYSTEM_CODE = tosm.SYSTEM_CODE" +
                " WHERE tor.create_user = tou1.id AND tor.update_user = tou2.id AND tosm.SYSTEM_CODE = tor.SYSTEM_CODE";
        return findPagination(page, RoleVO.class, sql, roleBo);
    }


    /**
     * zTree形式的j角色树列表
     * 根
     *
     * @return role tree
     */
    public List<ZTreeBO> findRoleTree(String roleId, String systemModuleCode) {
        String sql = "SELECT * FROM T_OAUTH_ROLE tor WHERE tor.ENABLED = 1 AND tor.SYSTEM_CODE = ?";
        List<IRole> iRoles = mysql.findListBeanByArray(sql, IRole.class, systemModuleCode);
        if ("0".equalsIgnoreCase(roleId))
            iRoles.add(IRole.root());
        return roleToZTree(iRoles);
    }


    /**
     * 將Role列表转为zTree树对象
     *
     * @param iRoles iRoles
     * @return List<ZTreeBO>
     */
    private List<ZTreeBO> roleToZTree(Collection<IRole> iRoles) {
        List<ZTreeBO> zTreeList = new LinkedList<>();
        for (IRole role : iRoles) {
            ZTreeBO zTree = new ZTreeBO();
            zTree.setId(role.getId().toString());
            zTree.setpId(role.getParentId().toString());
            zTree.setName(role.getCnName());
            zTree.setOpen(true);
            zTree.setisParent(checkIsParent(role.getId())); //根据是否有子节点设置isParent属性
            zTreeList.add(zTree);
        }
        return zTreeList;
    }

    /**
     * 根据节点id判断指定节点是否为父节点
     *
     * @param roleId roleId
     * @return 是否为父节点
     */

    private boolean checkIsParent(int roleId) {
        String sql = " SELECT count(0) FROM T_OAUTH_ROLE tor WHERE tor.ENABLED = 1 AND tor.PARENT_ID = ?";
        long count = mysql.queryNumberByArray(sql, Long.class, roleId);
        return count != 0;
    }

}
