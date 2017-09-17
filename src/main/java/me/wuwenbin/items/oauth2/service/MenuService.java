package me.wuwenbin.items.oauth2.service;

import me.wuwenbin.items.oauth2.entity.IMenu;
import me.wuwenbin.items.oauth2.service.base.SimpleBaseCrudService;
import me.wuwenbin.items.oauth2.support.pojo.bo.ZTreeBO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Created by Wuwenbin on 2017/8/21.
 */
@Service
@Transactional
public class MenuService extends SimpleBaseCrudService<IMenu, Integer> {

    /**
     * 根据菜单模块查找菜单
     *
     * @param menuModuleId
     * @return
     */
    public List<IMenu> findEnableMenusByMenuModuleId(String menuModuleId) {
        String sql = "SELECT * FROM t_oauth_menu WHERE menu_module_id  = ? AND enabled = 1";
        return mysql.findListBeanByArray(sql, IMenu.class, menuModuleId);
    }

    /**
     * 查询某个角色对应的菜单
     *
     * @param roleId
     * @return
     */
    public List<IMenu> findEnabledMenusByRoleId(String roleId) {
        String sql = "SELECT * FROM t_oauth_menu WHERE role_id = ? ORDER BY order_index ASC ";
        return mysql.findListBeanByArray(sql, IMenu.class, roleId);
    }


    /**
     * 修改菜单内容
     *
     * @param menu
     * @return
     * @throws Exception
     */
    public boolean editMenu(IMenu menu) throws Exception {
        String sql = "UPDATE t_oauth_menu " +
                "SET name = :name , icon = :icon , icon_larger = :iconLarger , order_index = :orderIndex , enabled = :enabled , remark = :remark " +
                "WHERE id = :id";
        return mysql.executeBean(sql, menu) == 1;
    }

    /**
     * 删除菜单
     *
     * @param id
     * @return
     * @throws Exception
     */
    public boolean deleteMenu(String id) throws Exception {
        String sql = "DELETE FROM t_oauth_menu WHERE id = ? OR parent_id = ?";
        return mysql.executeArray(sql, id, id) > 0;
    }

    /**
     * 菜单list集合转菜单zTree树
     *
     * @param menuList
     * @return
     */
    public List<ZTreeBO> menuList2MenuTree(List<IMenu> menuList) {
        List<ZTreeBO> zTree = new ArrayList<>(menuList.size());
        for (IMenu menu : menuList) {
            ZTreeBO zTreeBO = new ZTreeBO();
            zTreeBO.setId(menu.getId().toString());
            zTreeBO.setpId(menu.getParentId().toString());
            zTreeBO.setName(menu.getName());
            zTreeBO.setOpen(true);
            zTree.add(zTreeBO);
        }
        return zTree;
    }

    /**
     * 添加菜单中获取当前添加菜单对应的权限资源，所对应的都是页面级的权限，
     * 应为菜单都是有页面的链接的，按钮级别的则应该不显示。按钮级别都应该对应各自的页面上
     *
     * @param resourceModuleId
     * @param roleId
     * @return
     */
    public List<ZTreeBO<String>> getSelectMenuPrivilege(String resourceModuleId, String roleId) {
        String privilegePageSql = "SELECT topp.*,tor.url  FROM t_oauth_privilege_page topp " +
                "LEFT JOIN t_oauth_resource tor ON tor.id = topp.resource_id " +
                "WHERE topp.resource_module_id = ? " +
                "AND topp.resource_id IN (" +
                "SELECT torr.resource_id FROM t_oauth_role_resource torr WHERE torr.role_id = ?" +
                ")";
        List<Map<String, Object>> privilegePageList = mysql.findListMapByArray(privilegePageSql, resourceModuleId, roleId);

        List<ZTreeBO<String>> pagePrivilegeTree = new LinkedList<>();
        // page_privilege
        for (Map<String, Object> privilegePage : privilegePageList) {
            ZTreeBO<String> pageTree = new ZTreeBO<>();
            pageTree.setId(privilegePage.get("id").toString());
            pageTree.setName(privilegePage.get("name").toString());
            pageTree.setOther(privilegePage.get("url").toString());
            pageTree.setOpen(true);
            pageTree.setpId(privilegePage.get("resource_module_id").toString());
            pageTree.setResourceId(privilegePage.get("resource_id").toString());
            pageTree.setisParent(false);
            pagePrivilegeTree.add(pageTree);
        }
        return pagePrivilegeTree;
    }

}
