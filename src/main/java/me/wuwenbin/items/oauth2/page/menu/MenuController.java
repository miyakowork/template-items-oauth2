package me.wuwenbin.items.oauth2.page.menu;

import me.wuwenbin.items.oauth2.support.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * created by Wuwenbin on 2017/8/27 at 10:21
 */
@Controller
@RequestMapping("oauth2/menu")
public class MenuController extends BaseController {

    @RequestMapping("parentTree")
    public ModelAndView parentTree() {
        return new ModelAndView("router/menu/parentTree");
    }

    @RequestMapping("resourceSelect")
    public ModelAndView resourceSelect() {
        return new ModelAndView("router/menu/resourceSelect");
    }
}
