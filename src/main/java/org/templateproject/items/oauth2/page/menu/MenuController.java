package org.templateproject.items.oauth2.page.menu;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.templateproject.items.oauth2.support.TemplateController;

/**
 * 菜单配置
 * <p>
 * Created by Liurongqi on 2017/7/21.
 */
@Controller
@RequestMapping("menu")
public class MenuController extends TemplateController {

    @RequestMapping
    public ModelAndView menuPage() {
        return new ModelAndView("/router/menu/list");
    }
}
