package me.wuwenbin.items.oauth2.page.role;

import me.wuwenbin.items.oauth2.entity.IRole;
import me.wuwenbin.items.oauth2.service.RoleService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import me.wuwenbin.items.oauth2.support.pojo.bo.RoleBo;
import me.wuwenbin.items.oauth2.support.pojo.bo.ZTreeBO;
import me.wuwenbin.items.oauth2.support.pojo.vo.RoleVO;
import me.wuwenbin.modules.pagination.model.bootstrap.BootstrapTable;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * Created by tuchen on 2017/7/13.
 */
@RestController
@RequestMapping("/oauth2/role/api")
public class RoleRestController extends BaseRestController {

    //下方set方法注入roleService
    private RoleService roleService;

    @Autowired
    public void setRoleService(RoleService roleService) {
        this.roleService = roleService;
    }

    /**
     * 角色对象的page
     *
     * @param roleBo 角色查询控件对应的对象
     * @param page   page
     * @return BootstrapTable
     */
    @RequestMapping("list")
    @RequiresPermissions("base:role:tree")
    @AuthResource(name = "获取角色列表页面的数据")
    public BootstrapTable<RoleVO> sysParams(RoleBo roleBo, Page<RoleVO> page) {
        page = roleService.findRolePage(page, roleBo);
        return bootstrapTable(page);
    }

    /**
     * 添加一个新角色
     *
     * @param iRole iRole
     * @return R
     */
    @RequestMapping("add")
    @RequiresPermissions("base:role:add")
    @AuthResource(name = "添加一个新角色的操作")
    public R add(IRole iRole) {
        return ajaxDoneAdd("角色", roleService, iRole, IRole.class);
    }

    /**
     * 修改一个角色对象
     *
     * @param iRole iRole
     * @return R
     */
    @RequestMapping("edit")
    @RequiresPermissions("base:role:edit")
    @AuthResource(name = "修改一个角色对象的操作")
    public R edit(IRole iRole) {
        return ajaxDoneEdit("角色", roleService, iRole, IRole.class);
    }

    /**
     * 根据父节点和系统模块获取该节点下面的树数据
     *
     * @return json R
     */
    @RequestMapping("selectRole")
    @RequiresPermissions("base:role:selectRole")
    @AuthResource(name = "根据父节点和系统模块获取该节点下面的树数据")
    public List<ZTreeBO> selectRoleZTree(String id, String systemModuleCode) {
        return roleService.findRoleTree(id, systemModuleCode);
    }

}
