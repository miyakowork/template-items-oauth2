package org.templateproject.items.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.items.oauth2.entity.IMenuModule;
import org.templateproject.items.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.items.oauth2.support.pojo.bo.MenuModuleBO;
import org.templateproject.items.oauth2.support.pojo.vo.MenuModuleVO;
import org.templateproject.pojo.page.Page;

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
        String sql = "SELECT" +
                "  tomm.*," +
                "  tou1.username AS createUsername," +
                "  tou2.username AS updateUsername" +
                " FROM t_oauth_menu_module tomm," +
                "  t_oauth_user tou1," +
                "  t_oauth_user tou2" +
                " WHERE tomm.create_user = tou1.id AND tomm.update_user = tou2.id";
        return findPagination(page, MenuModuleVO.class, sql, menuModuleBO);
    }


}
