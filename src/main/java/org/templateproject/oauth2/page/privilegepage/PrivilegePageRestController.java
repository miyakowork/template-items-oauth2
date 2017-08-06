package org.templateproject.oauth2.page.privilegepage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.entity.OauthPrivilegePage;
import org.templateproject.oauth2.service.PrivilegePageService;
import org.templateproject.oauth2.support.TemplateController;
import org.templateproject.oauth2.support.pojo.bo.PrivilegePageBo;
import org.templateproject.oauth2.support.pojo.vo.PrivilegePageVO;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * Created by zhangteng on 2017/7/19.
 */
@RestController
@RequestMapping("privilegepage/api")
public class PrivilegePageRestController extends TemplateController {


    private PrivilegePageService privilegePageService;


    @Autowired
    public void setPrivilegePageService(PrivilegePageService privilegePageService) {
        this.privilegePageService = privilegePageService;
    }


    /*
    * 获取资源模块的树形结构
    *
    * */
    @RequestMapping("selectPrivilegePage")
    public R selectPrivilegePage() throws Exception {

        return R.ok(privilegePageService.findResourceModulTree());

    }


    @RequestMapping("list")
    public BootstrapTable<PrivilegePageVO> org(Page<PrivilegePageVO> page, PrivilegePageBo privilegePageBo, javax.servlet.http.HttpServletRequest request) throws Exception {
        page = queryParam2Page(privilegePageBo, page);
        page = privilegePageService.list(page, privilegePageBo);
        List<PrivilegePageVO> result = page.getTResult();
        return new BootstrapTable<>(page.getTotalCount(), result);
    }

    @RequestMapping("add")
    public R add(PrivilegePageVO resource) {
        boolean b = false;
        try {
            b = privilegePageService.save(resource);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (b) {
            return R.ok("添加操作级权限类型成功");
        } else {
            return R.ok("添加操作权限类型失败");
        }
    }

    @RequestMapping("edit")
    public R doEdit(OauthPrivilegePage resource) {

        boolean flag = false;
        try {
            flag = privilegePageService.edit(resource);
            if (flag) {
                return R.ok("更新模块成功");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return R.ok("更新模块失败");
    }
}
