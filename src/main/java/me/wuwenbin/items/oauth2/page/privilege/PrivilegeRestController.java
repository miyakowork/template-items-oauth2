package me.wuwenbin.items.oauth2.page.privilege;

import me.wuwenbin.items.oauth2.service.PrivilegeService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import me.wuwenbin.items.oauth2.support.pojo.bo.ZTreeBO;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * Created by tuchen on 2017/7/21.
 */
@RestController
@RequestMapping("oauth2/privilege/api")
public class PrivilegeRestController extends BaseRestController {

    private PrivilegeService privilegeService;

    @Autowired
    public void setPrivilegeService(PrivilegeService privilegeService) {
        this.privilegeService = privilegeService;
    }

    /**
     * 异步加载权限资源
     *
     * @param resourceModuleId
     * @param roleId
     * @return
     */
    @RequestMapping("getAjaxPrivilegeData")
    @RequiresPermissions("base:privilege:getAjaxPrivilegeData")
    @AuthResource(name = "获取异步加载权限资源的操作")
    public List<ZTreeBO<String>> getAjaxPrivilegeData(String resourceModuleId, String roleId) {
        return privilegeService.getPrivilegeData(resourceModuleId, roleId);
    }

    /**
     * 分配操作权限
     *
     * @param resourceIds
     * @param roleId
     * @param checked
     * @return
     */
    @RequestMapping("setPrivilege")
    @RequiresPermissions("base:privilege:setPrivilege")
    @AuthResource(name = "分配操作权限的操作")
    public R setPrivilege(@RequestParam(value = "resourceIds[]") String[] resourceIds, String roleId, boolean checked) {
        String operate = checked ? "分配" : "撤销";
        try {
            privilegeService.setPrivilege(resourceIds, roleId, checked);
            return R.ok(operate + "权限成功！");
        } catch (Exception e) {
            LOGGER.error(operate + "权限失败，异常：{}", e);
            return R.error(operate + "权限失败，失败原因:" + e.getMessage());
        }
    }
}
