package org.templateproject.oauth2.page.privilegeOperationType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.entity.OauthOperationPrivilegeType;
import org.templateproject.oauth2.service.OperationPrivilegeTypeService;
import org.templateproject.oauth2.support.BaseRestController;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.oauth2.support.pojo.bo.OperationPrivilegeTypeBo;
import org.templateproject.oauth2.support.pojo.vo.OperationPrivilegeTypeVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

/**
 * Created by zhangteng on 2017/7/12.
 */
@RestController
@RequestMapping("oauth2/privilegeOperationType/api")
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
        page = operationPrivilegeTypeService.getPage(page, operationPrivilegeTypeBo);
        return bootstrapTable(page);
    }


    @RequestMapping("add")
    public R add(OauthOperationPrivilegeType resource) {
        boolean b = false;
        try {
            b = operationPrivilegeTypeService.save(resource);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (b) {
            return R.ok("添加操作级权限类型成功");
        } else {
            return R.ok("添加操作权限类型失败");
        }
    }


    @RequestMapping("doEdit")
    public R doEdit(OauthOperationPrivilegeType resource) {
        boolean flag = false;
        try {
            flag = operationPrivilegeTypeService.edit(resource);
        } catch (Exception e) {

            e.printStackTrace();
        } finally {

            if (flag) {

                return R.ok("更新模块成功");
            } else {

                return R.ok("更新模块失败");
            }

        }

    }

    @RequestMapping("delete")
    public R delete(String ids) {

        try {
            operationPrivilegeTypeService.delete(ids);
        } catch (Exception e) {

            e.printStackTrace();
        }
        return R.ok("删除模块成功");
    }

}
