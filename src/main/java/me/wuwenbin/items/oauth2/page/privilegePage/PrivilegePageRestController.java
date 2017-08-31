package me.wuwenbin.items.oauth2.page.privilegePage;

import me.wuwenbin.items.oauth2.entity.IPrivilegePage;
import me.wuwenbin.items.oauth2.service.PrivilegePageService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.pojo.bo.PrivilegePageBo;
import me.wuwenbin.items.oauth2.support.pojo.vo.PrivilegePageVO;
import me.wuwenbin.modules.pagination.model.bootstrap.BootstrapTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

/**
 * Created by wuwenbin on 2017/8/19.
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
    public R add(IPrivilegePage privilegePage) {
        return ajaxDoneAdd("页面资源权限", privilegePageService, privilegePage, IPrivilegePage.class);
    }

    @RequestMapping("edit")
    public R doEdit(IPrivilegePage privilegePage) {
        return ajaxDoneEdit("页面资源权限", privilegePageService, privilegePage, IPrivilegePage.class);
    }

    @RequestMapping("delete")
    public R delete(String ids) {
        return ajaxDoneDelete("页面资源权限", ids.split(","), privilegePageService, IPrivilegePage.class);
    }
}
