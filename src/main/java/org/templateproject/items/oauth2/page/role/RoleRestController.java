package org.templateproject.items.oauth2.page.role;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.items.oauth2.entity.IRole;
import org.templateproject.items.oauth2.service.RoleService;
import org.templateproject.items.oauth2.support.BaseRestController;
import org.templateproject.items.oauth2.support.pojo.BootstrapTable;
import org.templateproject.items.oauth2.support.pojo.bo.RoleBo;
import org.templateproject.items.oauth2.support.pojo.bo.ZTreeBO;
import org.templateproject.items.oauth2.support.pojo.vo.RoleVO;
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
    @RequestMapping("/list")
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
    @RequestMapping("/add")
    public R add(IRole iRole) {
        try {
            if (roleService.save(iRole, IRole.class))
                return R.ok("添加角色成功");
            else return R.error("添加失败");
        } catch (Exception e) {
            return R.error("添加失败" + e.getMessage());
        }

    }

    /**
     * 修改一个角色对象
     *
     * @param iRole iRole
     * @return R
     */
    @RequestMapping("/edit")
    public R edit(IRole iRole) {
        try {
            if (roleService.edit(iRole, IRole.class))
                return R.ok("编辑角色成功");
            else return R.error("编辑失败");
        } catch (Exception e) {
            return R.error("编辑失败" + e.getMessage());
        }

    }

    /**
     * 根据父节点和系统模块获取该节点下面的树数据
     *
     * @return json R
     */
    @RequestMapping("selectRole")
    public List<ZTreeBO> selectRoleZTree(String id, String systemModuleCode) {
        return roleService.findRoleTree(id, systemModuleCode);
    }

}