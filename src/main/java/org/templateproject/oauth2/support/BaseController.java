package org.templateproject.oauth2.support;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * 通用list页面展示控制层
 * Created by Wuwenbin on 2017/7/31.
 */
@Controller
@RequestMapping("oauth2")
public class BaseController extends TemplateController {

        @RequestMapping("{module}")
        public String listB(@PathVariable("module") String module) {
                if (module.contains("-")) {
                        module = module.replace("-", "_");
                }
                return "router/".concat(module).concat("/list");
        }
}
