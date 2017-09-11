package me.wuwenbin.items.oauth2.page.sysModule;

import me.wuwenbin.items.oauth2.entity.ISystemModule;
import me.wuwenbin.items.oauth2.service.SystemModuleService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import me.wuwenbin.items.oauth2.support.pojo.bo.SystemModuleBo;
import me.wuwenbin.items.oauth2.support.pojo.bo.ZTreeBO;
import me.wuwenbin.items.oauth2.support.pojo.vo.SystemModuleVO;
import me.wuwenbin.modules.pagination.model.bootstrap.BootstrapTable;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * 系统面模块数据处理层
 * Created by zhangteng on 2017/7/14.
 */
@RequestMapping("/oauth2/systemModule/api")
@RestController
public class SysModuleRestController extends BaseRestController {

    //下方注入系统模块相关的service
    private SystemModuleService systemModuleService;

    @Autowired
    public void setSystemModuleService(SystemModuleService systemModuleService) {
        this.systemModuleService = systemModuleService;
    }

    /**
     * 系统模块列表
     *
     * @param page           页面对象
     * @param systemModuleBo 页面查询对象
     * @return 页面对象（包含数据、分页、查询等信息）
     */
    @RequestMapping("list")
    @RequiresPermissions("base:systemModule:list")
    @AuthResource(name = "获取系统模块列表页面的数据")
    public BootstrapTable<SystemModuleVO> list(Page<SystemModuleVO> page, SystemModuleBo systemModuleBo) {
        page = systemModuleService.findSystemModulePage(page, systemModuleBo);
        return bootstrapTable(page);
    }

    /**
     * 系统模块的添加处理
     *
     * @param systemModule 添加的系统模块对象
     * @return 添加处理情况
     */
    @RequestMapping("add")
    @RequiresPermissions("base:systemModule:add")
    @AuthResource(name = "系统模块的添加处理")
    public R add(ISystemModule systemModule) {
        if (systemModuleService.isExistSystemCode(systemModule.getSystemCode()))
            return R.error("系统模块代码已存在");
        else {
            return ajaxDoneAdd("系统模块", systemModuleService, systemModule, ISystemModule.class);
        }
    }

    /**
     * 修改系统模块的操作
     *
     * @param systemModule 修改的系统模块对象
     * @return 修改处理结果
     */
    @RequestMapping("edit")
    @RequiresPermissions("base:systemModule:edit")
    @AuthResource(name = "修改系统模块的操作")
    public R doEdit(ISystemModule systemModule) {
        return ajaxDoneEdit("系统模块", systemModuleService, systemModule, ISystemModule.class);
    }


    /**
     * 删除系统模块处理操作
     *
     * @param ids 删除模块对象的id集合字符串
     * @return 删除的处理结果
     */
    @RequestMapping("delete")
    @RequiresPermissions("base:systemModule:delete")
    @AuthResource(name = "删除系统模块处理操作")
    public R delete(String ids) {
        String[] idArr = ids.split(",");
        return ajaxDoneDelete("系统模块", idArr, systemModuleService, ISystemModule.class);
    }

    /**
     * @return 获取所有可用的系统模块
     */
    @RequestMapping("find/modules/enabled")
    @RequiresPermissions("base:systemModule:enabled")
    @AuthResource(name = "获取所有可用的系统模块")
    public List<ISystemModule> findModulesEnabled() {
        return systemModuleService.findEnabledListBean(ISystemModule.class);
    }

    /**
     * 获取系统模块的zTree树，无异步加载
     *
     * @return List<ZTreeBO>
     */
    @RequestMapping("/find/modules/enabled/moduleTree")
    @RequiresPermissions("base:systemModule:moduleTree")
    @AuthResource(name = "获取系统模块的zTree树，无异步加载")
    public List<ZTreeBO<String>> findModulesTreeEnabled() {
        return systemModuleService.module2ZTree(systemModuleService.findEnabledListBean(ISystemModule.class));
    }

}
