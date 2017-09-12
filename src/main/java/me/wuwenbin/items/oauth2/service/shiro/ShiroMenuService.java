package me.wuwenbin.items.oauth2.service.shiro;

import me.wuwenbin.items.oauth2.constant.CacheConsts;
import me.wuwenbin.items.oauth2.entity.IDept;
import me.wuwenbin.items.oauth2.entity.IMenu;
import me.wuwenbin.items.oauth2.service.base.SimpleBaseCrudService;
import me.wuwenbin.items.oauth2.util.CacheUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 用户权限菜单Service
 * Created by Wuwenbin on 2017/7/17.
 */
@Service
@Transactional
public class ShiroMenuService extends SimpleBaseCrudService<IDept, Integer> {


    /**
     * 根据用户的角色id、所属菜单的模块id以及哪个系统（系统代码）来查询侧边栏菜单
     *
     * @param roleId       角色id
     * @param menuModuleId 菜单模块id
     * @param systemCode   系统模块代码
     * @return 侧边栏菜单
     */
    public List<IMenu> findLeftMenuByRoleId(int roleId, int menuModuleId, String systemCode) {
        String key = "menu::" + systemCode + ":" + roleId + ":" + menuModuleId;
        List<IMenu> leftMenus = CacheUtils.get(CacheConsts.MENU_CACHE, key);
        if (leftMenus == null || leftMenus.size() == 0) {
            String sql = "SELECT * FROM t_oauth_menu WHERE enabled = 1 AND role_id = ? AND menu_module_id = ? AND system_code = ? ORDER BY order_index ASC ";
            List<IMenu> menus = mysql.findListBeanByArray(sql, IMenu.class, roleId, menuModuleId, systemCode);
            CacheUtils.put(CacheConsts.MENU_CACHE, key, menus);
            return menus;
        } else {
            return leftMenus;
        }

    }

}
