package me.wuwenbin.items.oauth2.page.operationPrviilegeType;

import me.wuwenbin.items.oauth2.entity.IOperationPrivilegeType;
import me.wuwenbin.items.oauth2.service.OperationPrivilegeTypeService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import me.wuwenbin.items.oauth2.support.pojo.bo.OperationPrivilegeTypeBo;
import me.wuwenbin.items.oauth2.support.pojo.vo.OperationPrivilegeTypeVO;
import me.wuwenbin.modules.pagination.model.bootstrap.BootstrapTable;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * Created by zhangteng on 2017/7/12.
 */
@RestController
@RequestMapping("oauth2/operationPrivilegeType/api")
public class OperationPrivilegeTypeRestController extends BaseRestController {


    private OperationPrivilegeTypeService operationPrivilegeTypeService;

    @Autowired
    public void setOperationPrivilegeTypeService(OperationPrivilegeTypeService operationPrivilegeTypeService) {
        this.operationPrivilegeTypeService = operationPrivilegeTypeService;
    }

    /**
     * 权限操作类型page
     *
     * @param page
     * @param operationPrivilegeTypeBo
     * @return
     */
    @RequestMapping("list")
    @RequiresPermissions("base:operationPrivilegeType:list")
    @AuthResource(name = "获取操作级权限列表页面的数据")
    public BootstrapTable<OperationPrivilegeTypeVO> org(Page<OperationPrivilegeTypeVO> page, OperationPrivilegeTypeBo operationPrivilegeTypeBo) {
        page = operationPrivilegeTypeService.findOperationPrivilegeTypePage(page, operationPrivilegeTypeBo);
        return bootstrapTable(page);
    }


    /**
     * 添加操作级权限类型
     *
     * @param resource
     * @return
     */
    @RequestMapping("add")
    @RequiresPermissions("base:operationPrivilegeType:add")
    @AuthResource(name = "添加操作级权限类型操作")
    public R add(IOperationPrivilegeType resource) {
        return ajaxDoneAdd("操作级权限类型", operationPrivilegeTypeService, resource, IOperationPrivilegeType.class);
    }

    /**
     * 编辑操作级权限类型对象
     *
     * @param resource
     * @return
     */
    @RequestMapping("edit")
    @RequiresPermissions("base:operationPrivilegeType:edit")
    @AuthResource(name = "编辑操作级权限类型对象操作")
    public R edit(IOperationPrivilegeType resource) {
        return ajaxDoneEdit("操作级权限类型", operationPrivilegeTypeService, resource, IOperationPrivilegeType.class);
    }


    @RequestMapping("find/operationType/enabled")
    @RequiresPermissions("base:operationPrivilegeType:enabled")
    @AuthResource(name = "查询可用的操作级权限类型的操作")
    public List<IOperationPrivilegeType> findEnabledOperationTypes() {
        return operationPrivilegeTypeService.findEnabledListBean(IOperationPrivilegeType.class);
    }
}
