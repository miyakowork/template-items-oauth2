package org.templateproject.oauth2.page.operationprivilegetype;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by zhangteng on 2017/7/12.
 */
@Controller
@RequestMapping("operationprivilegetype")
public class OperationPrivilegeTypeController {


    @RequestMapping
    public ModelAndView list() {
        return new ModelAndView("router/operationprivilegetype/list");
    }

}
