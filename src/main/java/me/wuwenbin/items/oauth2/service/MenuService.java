package me.wuwenbin.items.oauth2.service;

import me.wuwenbin.items.oauth2.entity.IMenu;
import me.wuwenbin.items.oauth2.service.base.SimpleBaseCrudService;
import me.wuwenbin.items.oauth2.support.pojo.bo.ZTreeBO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

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
        String sql = "SELECT * FROM t_oauth_menu WHERE role_id = ?";
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
                "SET name = :name , icon = :icon , icon_larger = :iconLarge , order_index = :orderIndex , enabled = :enabled , remark = :remark " +
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
}
