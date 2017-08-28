package org.templateproject.items.oauth2.page.operationPrviilegeType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.items.oauth2.entity.IOperationPrivilegeType;
import org.templateproject.items.oauth2.service.OperationPrivilegeTypeService;
import org.templateproject.items.oauth2.support.BaseRestController;
import org.templateproject.items.oauth2.support.pojo.BootstrapTable;
import org.templateproject.items.oauth2.support.pojo.bo.OperationPrivilegeTypeBo;
import org.templateproject.items.oauth2.support.pojo.vo.OperationPrivilegeTypeVO;
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
    public R edit(IOperationPrivilegeType resource) {
        return ajaxDoneEdit("操作级权限类型", operationPrivilegeTypeService, resource, IOperationPrivilegeType.class);
    }


    @RequestMapping("find/operationType/enabled")
    public List<IOperationPrivilegeType> findEnabledOperationTypes() {
        return operationPrivilegeTypeService.findEnabledListBean(IOperationPrivilegeType.class);
    }
}
