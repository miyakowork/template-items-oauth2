package org.templateproject.oauth2.page.menuModule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.entity.OauthMenuModule;
import org.templateproject.oauth2.entity.OauthSystemModule;
import org.templateproject.oauth2.service.MenuModuleService;
import org.templateproject.oauth2.service.SystemModuleService;
import org.templateproject.oauth2.support.BaseRestController;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.oauth2.support.pojo.bo.MenuModuleBO;
import org.templateproject.oauth2.support.pojo.bo.SelectBO;
import org.templateproject.oauth2.support.pojo.vo.MenuModuleVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by Wuwenbin on 2017/08/01.
 */
@RestController
@RequestMapping("oauth2/menuModule/api")
public class MenuModuleRestController extends BaseRestController {

    private MenuModuleService menuModuleService;
    private SystemModuleService systemModuleService;

    @Autowired
    public void setMenuModuleService(MenuModuleService menuModuleService) {
        this.menuModuleService = menuModuleService;
    }

    @Autowired
    public void setSystemModuleService(SystemModuleService systemModuleService) {
        this.systemModuleService = systemModuleService;
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
     * @param oauthMenuModule 添加的对象
     * @return R
     */
    @RequestMapping("add")
    public R add(OauthMenuModule oauthMenuModule) {
        try {
            if (menuModuleService.save(oauthMenuModule, OauthMenuModule.class))
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
     * @param oauthMenuModule 修改的对象
     * @return R
     */
    @RequestMapping("edit")
    public R doEdit(OauthMenuModule oauthMenuModule) {
        try {
            if (menuModuleService.edit(oauthMenuModule, OauthMenuModule.class))
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
            menuModuleService.forbidMenuModule(id);
            return R.ok("删除成功");
        } catch (Exception e) {
            LOGGER.error("禁用菜单模块发生异常，异常信息：{}", e);
            return R.error("禁用菜单模块发生异常，异常信息：" + e.getMessage());
        }
    }

    /**
     * 表格中使用系统模块查询的下拉框操作
     *
     * @return 下拉框对象
     */
    @RequestMapping("systemModule/select")
    public Map<Object, Object> systemModuleSelect() {
        List<SelectBO> selectBOs = new ArrayList<>();
        List<OauthSystemModule> systemModules = systemModuleService.findAllEnabledSystemModules();
        for (OauthSystemModule systemModule : systemModules) {
            SelectBO selectBO = SelectBO.create(systemModule.getSystemCode(), systemModule.getName());
            selectBOs.add(selectBO);
        }
        return searchSelect(selectBOs);
    }
}
