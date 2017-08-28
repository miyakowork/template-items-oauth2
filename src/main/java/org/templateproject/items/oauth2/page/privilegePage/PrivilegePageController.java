package org.templateproject.items.oauth2.page.privilegePage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.templateproject.items.oauth2.support.BaseController;

/**
 * Created by zhangteng on 2017/7/19.
 */
@Controller
@RequestMapping("oauth2/privilegePage")
public class PrivilegePageController extends BaseController {

    /**
     * 添加页面级权限资源的时候获取的资源树弹出框
     *
     * @return
     */
    @RequestMapping("resourceSelect")
    public ModelAndView resourceTree() {
        return new ModelAndView("router/privilege_page/resourceSelect");
    }
}
