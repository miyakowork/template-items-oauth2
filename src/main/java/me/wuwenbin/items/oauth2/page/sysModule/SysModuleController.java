package me.wuwenbin.items.oauth2.page.sysModule;

import me.wuwenbin.items.oauth2.support.TemplateController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * 资源模块控制层
 * 修改备注：增加控制层的注释
 * <p>
 * modify by wuwenbin
 * Created by tuchen on 2017/7/12.
 */
@Controller
@RequestMapping("/oauth2/systemModule")
public class SysModuleController extends TemplateController {


    @RequestMapping
    @RequiresPermissions("base:systemModule:list")
    @AuthResource(name = "系统模块列表页面")
    public ModelAndView list() {
        return new ModelAndView("router/system_module/list");
    }


}
