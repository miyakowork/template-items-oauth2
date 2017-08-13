package org.templateproject.oauth2.page.privilegeSort;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.entity.OauthMenuModule;
import org.templateproject.oauth2.entity.OauthPrivilegePage;
import org.templateproject.oauth2.service.MenuModuleService;
import org.templateproject.oauth2.service.PrivilegePageService;
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
@RequestMapping("oauth2/privilegeSort/api")
public class PrivilegePageRestController extends BaseRestController {


    private PrivilegePageService privilegePageService;
    private MenuModuleService menuModuleService;

    @Autowired
    public PrivilegePageRestController(PrivilegePageService privilegePageService, MenuModuleService menuModuleService) {
        this.privilegePageService = privilegePageService;
        this.menuModuleService = menuModuleService;
    }


    @RequestMapping("list")
    public BootstrapTable<PrivilegePageVO> org(Page<PrivilegePageVO> page, PrivilegePageBo privilegePageBo) throws Exception {
        page = privilegePageService.findPrivilegeSortPage(page, privilegePageBo);
        return bootstrapTable(page);
    }

    /**
     * 获取左侧菜单模块树
     *
     * @param systemModuleCode
     * @return
     */
    @RequestMapping("selectMenuModuleTree")
    public List<OauthMenuModule> selectMenuModuleTree(String systemModuleCode) {
        return menuModuleService.findEnabledMenuModule(systemModuleCode);
    }


    @RequestMapping("add")
    public R add(OauthPrivilegePage resource) {
        boolean b = false;
        try {
            b = privilegePageService.save(resource, OauthPrivilegePage.class);
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
            flag = privilegePageService.edit(resource, OauthPrivilegePage.class);
            if (flag) {
                return R.ok("更新模块成功");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return R.ok("更新模块失败");
    }
}
