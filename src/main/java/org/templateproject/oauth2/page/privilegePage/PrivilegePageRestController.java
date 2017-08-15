package org.templateproject.oauth2.page.privilegePage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.entity.OauthMenuModule;
import org.templateproject.oauth2.entity.OauthPrivilegePage;
import org.templateproject.oauth2.entity.OauthResourceModule;
import org.templateproject.oauth2.service.MenuModuleService;
import org.templateproject.oauth2.service.PrivilegePageService;
import org.templateproject.oauth2.service.ResModuleService;
import org.templateproject.oauth2.support.BaseRestController;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.oauth2.support.pojo.bo.PrivilegePageBo;
import org.templateproject.oauth2.support.pojo.vo.PrivilegePageVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * Created by zhangteng on 2017/7/19.
 */
@RestController
@RequestMapping("oauth2/privilegePage/api")
public class PrivilegePageRestController extends BaseRestController {

    private PrivilegePageService privilegePageService;

    @Autowired
    public void setPrivilegePageService(PrivilegePageService privilegePageService) {
        this.privilegePageService = privilegePageService;
    }


    @RequestMapping("list")
    public BootstrapTable<PrivilegePageVO> bootstrapTable(Page<PrivilegePageVO> page, PrivilegePageBo privilegePageBo) throws Exception {
        page = privilegePageService.findPrivilegePagePage(page, privilegePageBo);
        return bootstrapTable(page);
    }


    @RequestMapping("add")
    public R add(OauthPrivilegePage resource) {
        try {
            if (privilegePageService.save(resource, OauthPrivilegePage.class))
                return R.ok("添加成功");
            else
                return R.error("添加失败");
        } catch (Exception e) {
            LOGGER.error("添加出现异常，异常信息：{}", e);
            return R.error("添加出现异常，异常信息：" + e.getMessage());
        }
    }

    @RequestMapping("edit")
    public R doEdit(OauthPrivilegePage resource) {
        try {
            if (privilegePageService.edit(resource, OauthPrivilegePage.class))
                return R.ok("修改成功");
            else
                return R.error("修改失败");
        } catch (Exception e) {
            LOGGER.error("修改出现异常，异常信息：{}", e);
            return R.error("修改出现异常，异常信息：" + e.getMessage());
        }
    }
}
