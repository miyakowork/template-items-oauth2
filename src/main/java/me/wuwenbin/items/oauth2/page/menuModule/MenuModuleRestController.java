package me.wuwenbin.items.oauth2.page.menuModule;

import me.wuwenbin.items.oauth2.entity.IMenuModule;
import me.wuwenbin.items.oauth2.service.MenuModuleService;
import me.wuwenbin.items.oauth2.service.shiro.ShiroMenuService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import me.wuwenbin.items.oauth2.support.pojo.bo.MenuModuleBO;
import me.wuwenbin.items.oauth2.support.pojo.vo.MenuModuleVO;
import me.wuwenbin.modules.pagination.model.bootstrap.BootstrapTable;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.lang.TP;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * Created by Wuwenbin on 2017/08/01.
 */
@RestController
@RequestMapping("oauth2/menuModule/api")
public class MenuModuleRestController extends BaseRestController {

    private MenuModuleService menuModuleService;
    private ShiroMenuService shiroMenuService;

    @Autowired
    public MenuModuleRestController(MenuModuleService menuModuleService, ShiroMenuService shiroMenuService) {
        this.menuModuleService = menuModuleService;
        this.shiroMenuService = shiroMenuService;
    }


    /**
     * 菜单模块页面
     *
     * @param page         page
     * @param menuModuleBO 搜索对象
     * @return bootstrapTable
     */
    @RequestMapping("list")
    @RequiresPermissions("base:menuModule:list")
    @AuthResource(name = "获取菜单模块页面的数据")
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
    @RequiresPermissions("base:menuModule:add")
    @AuthResource(name = "添加新的菜单模块操作")
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
    @RequiresPermissions("base:menuModule:edit")
    @AuthResource(name = "修改菜单模块操作")
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
    @RequiresPermissions("base:menuModule:delete")
    @AuthResource(name = "删除菜单模块操作")
    public R delete(String ids) {
        return ajaxDoneDelete("菜单模块", ids.split(","), menuModuleService, IMenuModule.class);
    }


    /**
     * 查找可用的菜单模块集合
     *
     * @return
     */
    @RequestMapping("find/enables")
    @RequiresPermissions("base:menuModule:enables")
    @AuthResource(name = "查找可用的菜单模块集合操作")
    public List<IMenuModule> findEnabledMenuModules(String systemModuleCode) {
        if (TP.stringhelper.isNotEmpty(systemModuleCode))
            return shiroMenuService.findMenuModulesByCurrentUserDefaultRole(systemModuleCode);
        else
            return menuModuleService.findEnabledListBean(IMenuModule.class);
    }
}
