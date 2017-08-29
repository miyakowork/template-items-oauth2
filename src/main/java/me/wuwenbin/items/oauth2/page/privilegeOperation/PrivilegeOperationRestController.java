package me.wuwenbin.items.oauth2.page.privilegeOperation;

import me.wuwenbin.items.oauth2.entity.IPrivilegeOperation;
import me.wuwenbin.items.oauth2.service.PrivilegeOperationService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.pojo.LayTable;
import me.wuwenbin.items.oauth2.support.pojo.vo.PrivilegeOperationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

/**
 * created by Wuwenbin on 2017/8/22 at 13:42
 */
@RestController
@RequestMapping("oauth2/privilegeOperation/api")
public class PrivilegeOperationRestController extends BaseRestController {

    private PrivilegeOperationService privilegeOperationService;

    @Autowired
    public void setPrivilegeOperationService(PrivilegeOperationService privilegeOperationService) {
        this.privilegeOperationService = privilegeOperationService;
    }

    @RequestMapping("list")
    public LayTable<PrivilegeOperationVO> privilegeOperationPage(Page<PrivilegeOperationVO> pageVO, int page, int limit, String privilegeOperationName, String pagePrivilegeId) {
        pageVO = privilegeOperationService.findPrivilegeOperationPage(pageVO, page, limit, privilegeOperationName, pagePrivilegeId);
        return new LayTable<>(0, "", pageVO.getTotalCount(), pageVO.getTResult());
    }

    @RequestMapping("add")
    public R add(IPrivilegeOperation privilegeOperation) {
        return ajaxDoneAdd("操作级权限", privilegeOperationService, privilegeOperation, IPrivilegeOperation.class);
    }

    @RequestMapping("edit")
    public R edit(String id, String operationName) {
        try {
            if (privilegeOperationService.editPrivilegeOperationName(id, operationName)) {
                return R.ok("修改操作权限名称成功！");
            } else {
                return R.error("修改操作权限名称失败！");
            }
        } catch (Exception e) {
            LOGGER.error("修改{}异常，异常原因：{}", e);
            return R.error("修改操作权限名称出现异常，异常信息：" + e.getMessage());
        }
    }

    @RequestMapping("delete")
    public R delete(String id) {
        return ajaxDoneDelete("操作权限名称", id.split(","), privilegeOperationService, IPrivilegeOperation.class);
    }
}
