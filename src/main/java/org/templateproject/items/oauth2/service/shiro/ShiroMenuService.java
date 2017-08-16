package org.templateproject.items.oauth2.service.shiro;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.items.oauth2.entity.IDepartment;
import org.templateproject.items.oauth2.entity.IMenu;
import org.templateproject.items.oauth2.service.base.SimpleBaseCrudService;

import java.util.List;

/**
 * 用户权限菜单Service
 * Created by Wuwenbin on 2017/7/17.
 */
@Service
@Transactional
public class ShiroMenuService extends SimpleBaseCrudService<IDepartment, Integer> {

    /**
     * 根据用户的角色id、所属菜单的模块id以及哪个系统（系统代码）来查询所拥有的所有菜单
     *
     * @param roleId       角色id
     * @param menuModuleId 菜单模块id
     * @param systemCode   系统模块代码
     * @return 所有菜单
     */
    public List<IMenu> findAllMenusByRoleId(int roleId, int menuModuleId, String systemCode) {
        String sql = "SELECT * FROM T_OAUTH_MENU WHERE ROLE_ID = ? AND MENU_MODULE_ID = ? AND SYSTEM_CODE = ? AND ENABLED = 1";
        return mysql.findListBeanByArray(sql, IMenu.class, roleId, menuModuleId, systemCode);
    }

    /**
     * 根据用户的角色id、所属菜单的模块id以及哪个系统（系统代码）来查询侧边栏菜单
     *
     * @param roleId       角色id
     * @param menuModuleId 菜单模块id
     * @param systemCode   系统模块代码
     * @return 侧边栏菜单
     */
    public List<IMenu> findLeftMenuByRoleId(int roleId, int menuModuleId, String systemCode) {
        String sql = "SELECT tom.* FROM T_OAUTH_MENU tom WHERE tom.ENABLED = 1 AND tom.ROLE_ID = ? " +
                "AND tom.MENU_MODULE_ID = ? AND tom.SYSTEM_CODE = ? AND tom.RESOURCE_ID IN " +
                "(SELECT topp.RESOURCE_ID FROM T_OAUTH_PRIVILEGE_PAGE topp WHERE topp.ENABLED = 1)";
        return mysql.findListBeanByArray(sql, IMenu.class, roleId, menuModuleId, systemCode);

    }

}
