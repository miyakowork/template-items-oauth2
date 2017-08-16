package org.templateproject.items.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.items.oauth2.entity.IMenuModule;
import org.templateproject.items.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.items.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.items.oauth2.support.pojo.bo.MenuModuleBO;
import org.templateproject.items.oauth2.support.pojo.vo.MenuModuleVO;
import org.templateproject.pojo.page.Page;

import java.util.List;

/**
 * Created by Wuwenbin on 2017/8/102/.
 */
@Service
@Transactional
@SqlMapper("menu_module")
public class MenuModuleService extends SimpleBaseCrudService<IMenuModule, Integer> {

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
    public void hideMenuModule(String ids) throws Exception {
        executeBatch(sql(), "id", ids.split(","));
    }

    /**
     * 查询所有可用的菜单模块，根据系统模块代码
     *
     * @return
     */
    public List<IMenuModule> findEnabledMenuModule(String systemModuleCode) {
        return mysql.findListBeanByArray(sql(), IMenuModule.class, systemModuleCode);
    }

}