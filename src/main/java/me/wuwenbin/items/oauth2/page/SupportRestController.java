package me.wuwenbin.items.oauth2.page;

import me.wuwenbin.items.oauth2.entity.ISystemModule;
import me.wuwenbin.items.oauth2.service.SystemModuleService;
import me.wuwenbin.items.oauth2.service.shiro.ShiroPermissionService;
import me.wuwenbin.items.oauth2.service.shiro.ShiroRoleService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import me.wuwenbin.items.oauth2.support.pojo.bo.SelectBO;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Created by Wuwenbin on 2017/8/1.
 */
@RestController
@RequestMapping("oauth2")
public class SupportRestController extends BaseRestController {

    private SystemModuleService systemModuleService;
    private ShiroPermissionService shiroPermissionService;
    private ShiroRoleService shiroRoleService;

    @Autowired
    public SupportRestController(SystemModuleService systemModuleService, ShiroPermissionService shiroPermissionService, ShiroRoleService shiroRoleService) {
        this.systemModuleService = systemModuleService;
        this.shiroPermissionService = shiroPermissionService;
        this.shiroRoleService = shiroRoleService;
    }

    /**
     * 公共的下拉框搜索对象的值
     *
     * @return map
     */
    @RequestMapping("common/select")
    @RequiresPermissions("base:support:commonSelect")
    @AuthResource(name = "公共的下拉框搜索对象的值")
    public Map<Object, Object> searchSelect() {
        List<SelectBO> selectBOs = new ArrayList<>();
        SelectBO selectBO1 = SelectBO.create("1", "可用");
        selectBOs.add(selectBO1);
        SelectBO selectBO2 = SelectBO.create("0", "不可用");
        selectBOs.add(selectBO2);
        return searchSelect(selectBOs);
    }

    /**
     * 表格中使用系统模块查询的下拉框操作
     *
     * @return 下拉框对象
     */
    @RequestMapping("systemModule/select")
    @RequiresPermissions("base:support:commonSelect")
    @AuthResource(name = "表格中使用系统模块查询的下拉框操作")
    public Map<Object, Object> systemModuleSelect() {
        List<SelectBO> selectBOs = new ArrayList<>();
        List<ISystemModule> systemModules = systemModuleService.findEnabledListBean(ISystemModule.class);
        for (ISystemModule systemModule : systemModules) {
            SelectBO selectBO = SelectBO.create(systemModule.getSystemCode(), systemModule.getName());
            selectBOs.add(selectBO);
        }
        return searchSelect(selectBOs);
    }

    /**
     * 获取当前登录用户的登录角色的所有权限标识名称
     *
     * @param roleId
     * @return
     */
    @RequestMapping("getPermissionsByRoleId")
    @RequiresPermissions("base:support:getPermissionsByRoleId")
    @AuthResource(name = "获取当前登录用户的登录角色的所有权限标识名称")
    public Collection<String> getPermissionsByRoleId(int roleId) {
        return shiroPermissionService.findPermissionsByRoleId(roleId);
    }

    /**
     * 获取当前登录用户的所有角色名称
     *
     * @param userId
     * @return
     */
    @RequestMapping("getRoleNamesByUserId")
    @RequiresPermissions("base:support:getRoleNamesByUserId")
    @AuthResource(name = "获取当前登录用户的所有角色名称")
    public Collection<String> getRoleNamesByUserId(int userId) {
        return shiroRoleService.findRoleNamesByUserId(userId);
    }
}
