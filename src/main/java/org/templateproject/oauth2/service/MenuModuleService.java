package org.templateproject.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.oauth2.entity.OauthMenuModule;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.oauth2.support.pojo.bo.MenuModuleBO;
import org.templateproject.oauth2.support.pojo.vo.MenuModuleVO;
import org.templateproject.pojo.page.Page;

/**
 * Created by Wuwenbin on 2017/8/102/.
 */
@Service
@Transactional
@SqlMapper("menu_module")
public class MenuModuleService extends SimpleBaseCrudService<OauthMenuModule, Integer> {

    /**
     * 查询菜单模块页面对象
     *
     * @param page         page
     * @param menuModuleBO 搜索对象
     * @return page
     */
    public Page<MenuModuleVO> findMenuModulePage(Page<MenuModuleVO> page, MenuModuleBO menuModuleBO) {
        return findPagination(page, MenuModuleVO.class, sql(), menuModuleBO);
    }


    /**
     * 禁用菜单模块
     *
     * @param ids 禁用的菜单模块的id集合
     * @throws Exception e
     */
    public void forbidMenuModule(String ids) throws Exception {
        executeBatch(sql(), "id", ids.split(","));
    }


}
