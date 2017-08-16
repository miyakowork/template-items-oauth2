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
        try {
            if (menuModuleService.save(iMenuModule, IMenuModule.class))
                return R.ok("添加菜单模块成功！");
            else
                return R.error("添加菜单模块失败！");
        } catch (Exception e) {
            LOGGER.error("添加菜单模块发生异常，异常信息：{}", e);
            return R.error("添加菜单模块发生异常，异常信息：" + e.getMessage());
        }
    }


    /**
     * 修改菜单模块
     *
     * @param iMenuModule 修改的对象
     * @return R
     */
    @RequestMapping("edit")
    public R doEdit(IMenuModule iMenuModule) {
        try {
            if (menuModuleService.edit(iMenuModule, IMenuModule.class))
                return R.ok("修改菜单模块成功！");
            else
                return R.error("修改菜单模块失败！");
        } catch (Exception e) {
            LOGGER.error("修改菜单模块发生异常，异常信息：{}", e);
            return R.error("修改菜单模块发生异常，异常信息：" + e.getMessage());
        }
    }

    /**
     * 禁用菜单模块
     *
     * @param id 禁用的id集合
     * @return R
     */
    @RequestMapping("forbid")
    public R delete(String id) {
        try {
            menuModuleService.hideMenuModule(id);
            return R.ok("删除成功");
        } catch (Exception e) {
            LOGGER.error("禁用菜单模块发生异常，异常信息：{}", e);
            return R.error("禁用菜单模块发生异常，异常信息：" + e.getMessage());
        }
    }

}