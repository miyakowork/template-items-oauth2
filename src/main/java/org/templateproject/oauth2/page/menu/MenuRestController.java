package org.templateproject.oauth2.page.menu;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.page.department.ZTreeBO;
import org.templateproject.oauth2.service.MenuService;
import org.templateproject.pojo.response.R;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Liurongqi on 2017/7/21.
 */
@RestController
@RequestMapping("menu/api")
public class MenuRestController {

    private MenuService menuService;

    @Autowired
    public void setMenuService(MenuService menuService) {
        this.menuService = menuService;
    }

    @RequestMapping("selectMenu")
    public R selectMenu(HttpServletRequest request){
        try {
            return R.ok(menuService.selectMenu(request));
        } catch (Exception e) {
            return R.error("获取数据失败");
        }
    }

    @RequestMapping("selectPartMenu")
    public List<ZTreeBO> selectPartMenu(HttpServletRequest request){
        try {
            return menuService.selectMenu(request);
        } catch (Exception e) {
            return null;
        }
    }

}
