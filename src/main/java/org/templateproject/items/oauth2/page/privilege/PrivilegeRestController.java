package org.templateproject.items.oauth2.page.privilege;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.items.oauth2.service.PrivilegeService;
import org.templateproject.items.oauth2.support.pojo.bo.ZTreeBO;

import java.util.List;

/**
 * Created by tuchen on 2017/7/21.
 */
@RestController
@RequestMapping("/privilege/api")
public class PrivilegeRestController {

    private PrivilegeService privilegeService;

    /**
     * 获取页面权限树
     *
     * @param resModuleId
     * @return
     */
    @RequestMapping("privilegePageTree")
    public List<ZTreeBO> roleList(String resModuleId) {
        try {
            return privilegeService.findPageByResModuleId(resModuleId);
        } catch (Exception e) {
            return null;
        }
    }
}
