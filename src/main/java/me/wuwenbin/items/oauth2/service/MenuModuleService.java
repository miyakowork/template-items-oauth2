package me.wuwenbin.items.oauth2.service;

import me.wuwenbin.items.oauth2.entity.IMenuModule;
import me.wuwenbin.items.oauth2.service.base.SimpleBaseCrudService;
import me.wuwenbin.items.oauth2.support.pojo.bo.MenuModuleBO;
import me.wuwenbin.items.oauth2.support.pojo.vo.MenuModuleVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.pojo.page.Page;

import java.util.List;

/**
 * Created by Wuwenbin on 2017/8/102/.
 */
@Service
@Transactional
public class MenuModuleService extends SimpleBaseCrudService<IMenuModule, Integer> {

    /**
     * 查询菜单模块页面对象
     *
     * @param page         page
     * @param menuModuleBO 搜索对象
     * @return page
     */
    public Page<MenuModuleVO> findMenuModulePage(Page<MenuModuleVO> page, MenuModuleBO menuModuleBO) {
        String sql = "SELECT tomm.*, tou1.username AS createUsername, tou2.username AS updateUsername" +
                " FROM t_oauth_menu_module tomm, t_oauth_user tou1, t_oauth_user tou2" +
                " WHERE tomm.create_user = tou1.id AND tomm.update_user = tou2.id";
        return findPagination(page, MenuModuleVO.class, sql, menuModuleBO);
    }

    /**
     * 根据系统模块代码查找可用的菜单模块集合
     *
     * @param systemModuleCode
     * @return
     */
    public List<IMenuModule> findEnabledMenuModuleBySystemModuleCode(String systemModuleCode) {
        String sql = "SELECT * FROM t_oauth_menu_module WHERE enabled = 1 AND system_code = ? ORDER BY order_index ASC ";
        return mysql.findListBeanByArray(sql, IMenuModule.class, systemModuleCode);
    }


}
