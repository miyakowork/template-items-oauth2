package org.templateproject.items.oauth2.page.menuModule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.items.oauth2.entity.IMenuModule;
import org.templateproject.items.oauth2.service.MenuModuleService;
import org.templateproject.items.oauth2.support.BaseRestController;
import org.templateproject.items.oauth2.support.pojo.BootstrapTable;
import org.templateproject.items.oauth2.support.pojo.bo.MenuModuleBO;
import org.templateproject.items.oauth2.support.pojo.vo.MenuModuleVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

/**
 * Created by Wuwenbin on 2017/08/01.
 */
@RestController
@RequestMapping("oauth2/menuModule/api")
public class MenuModuleRestController extends BaseRestController {

    private MenuModuleService menuModuleService;

    @Autowired
    public void setMenuModuleService(MenuModuleService menuModuleService) {
        this.menuModuleService = menuModuleService;
    }


    /**
     * 菜单模块页面
     *
     * @param page         page
     * @param menuModuleBO 搜索对象
     * @return bootstrapTable
     */
    @RequestMapping("list")
    public BootstrapTable<MenuModuleVO> list(Page<MenuModuleVO> page, MenuModuleBO menuModuleBO) {
        page = menuModuleService.findMenuModulePage(page, menuModuleBO);
        return bootstrapTable(page);
    }

    /**
     * 添加新的菜单模块
     *
     * @param iMenuModule 添加的对象
     * @return R
     */
    @RequestMapping("add")
    public R add(IMenuModule iMenuModule) {
        return ajaxDoneAdd("菜单模块", menuModuleService, iMenuModule, IMenuModule.class);
    }


    /**
     * 修改菜单模块
     *
     * @param iMenuModule 修改的对象
     * @return R
     */
    @RequestMapping("edit")
    public R doEdit(IMenuModule iMenuModule) {
        return ajaxDoneEdit("菜单模块", menuModuleService, iMenuModule, IMenuModule.class);
    }

    /**
     * 删除菜单模块
     *
     * @param ids
     * @return R
     */
    @RequestMapping("delete")
    public R delete(String ids) {
        return ajaxDoneDelete("菜单模块", ids.split(","), menuModuleService, IMenuModule.class);
    }

}
