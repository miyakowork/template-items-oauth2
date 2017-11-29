package me.wuwenbin.items.oauth2.service.shiro;

import me.wuwenbin.items.oauth2.constant.CacheConsts;
import me.wuwenbin.items.oauth2.entity.IDept;
import me.wuwenbin.items.oauth2.entity.IMenu;
import me.wuwenbin.items.oauth2.entity.IMenuModule;
import me.wuwenbin.items.oauth2.entity.IUser;
import me.wuwenbin.items.oauth2.service.base.SimpleBaseCrudService;
import me.wuwenbin.items.oauth2.util.UserUtils;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 用户权限菜单Service
 * Created by Wuwenbin on 2017/7/17.
 */
@Service
@Transactional(readOnly = true)
public class ShiroMenuService extends SimpleBaseCrudService<IDept, Integer> {


    /**
     * 根据用户的角色id、所属菜单的模块id以及哪个系统（系统代码）来查询侧边栏菜单
     *
     * @param roleId       角色id
     * @param menuModuleId 菜单模块id
     * @param systemCode   系统模块代码
     * @return 侧边栏菜单
     */
    @Cacheable(value = CacheConsts.MENU_CACHE, key = "#systemCode.concat(':').concat(#roleId).concat(':').concat(#menuModuleId)")
    public List<IMenu> findLeftMenuByRoleId(int roleId, int menuModuleId, String systemCode) {
        String sql = "SELECT * FROM t_oauth_menu WHERE enabled = 1 AND role_id = ? AND menu_module_id = ? AND system_code = ? ORDER BY order_index ASC ";
        return mysql.findListBeanByArray(sql, IMenu.class, roleId, menuModuleId, systemCode);
    }

    /**
     * 查找当前用户的默认角色的菜单list集合
     *
     * @param menuModuleId
     * @param systemCode
     * @return
     */
    public List<IMenu> findLeftMenuByCurrentUserDefaultRole(int menuModuleId, String systemCode) {
        IUser currentUser = UserUtils.getLoginUser();
        int defaultRoleId = currentUser.getDefaultRoleId();
        return findLeftMenuByRoleId(defaultRoleId, menuModuleId, systemCode);
    }

    /**
     * 查找当前用户默认角色的可用的菜单模块
     *
     * @param systemModuleCode
     * @return
     */
    public List<IMenuModule> findMenuModulesByCurrentUserDefaultRole(String systemModuleCode) {
        String sql = "SELECT tomm.* FROM t_oauth_menu_module tomm WHERE tomm.id " +
                "IN (SELECT DISTINCT tom.menu_module_id FROM t_oauth_menu tom WHERE tom.role_id = ? AND tom.system_code = ?) " +
                "AND tomm.enabled = 1";
        IUser currentUser = UserUtils.getLoginUser();
        int defaultRoleId = currentUser.getDefaultRoleId();
        return mysql.findListBeanByArray(sql, IMenuModule.class, defaultRoleId, systemModuleCode);
    }

}
