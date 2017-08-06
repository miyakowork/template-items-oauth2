package org.templateproject.oauth2.page.resmodule;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.templateproject.oauth2.support.TemplateController;

/**
 * 资源模块控制层
 * 修改备注：增加控制层的注释
 * <p>
 * modify by wuwenbin
 * Created by tuchen on 2017/7/12.
 */
@Controller
@RequestMapping("/resmodule")
public class ResourceModuleController extends TemplateController {

    @RequestMapping
    public ModelAndView list() {
        return new ModelAndView("router/res_module/list");
    }


}
