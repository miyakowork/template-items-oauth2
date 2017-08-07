package org.templateproject.oauth2.page.menuModule;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;
import org.templateproject.oauth2.entity.OauthMenuModule;
import org.templateproject.oauth2.service.MenuModuleService;
import org.templateproject.oauth2.support.BaseRestController;
import org.templateproject.oauth2.support.TemplateController;
import org.templateproject.oauth2.support.pojo.bo.MenuModuleBO;
import org.templateproject.oauth2.support.pojo.vo.MenuModuleVO;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * Created by Wuwenbin on 2017/08/01.
 */
@RestController
@RequestMapping("menumodule/api")
public class MenuModuleRestController extends BaseRestController {

    private MenuModuleService menuModuleService;

    @Autowired
    public void setMenuModuleService(MenuModuleService menuModuleService){
        this.menuModuleService = menuModuleService;
    }

    /**
     * 返回list
     */
    @RequestMapping("list")
    public BootstrapTable<MenuModuleVO> list(Page<MenuModuleVO> page, MenuModuleBO menuModuleBO) {

         page = queryParam2Page(menuModuleBO, page);
           page = menuModuleService.getPage(page, menuModuleBO);
           List<MenuModuleVO> result = page.getTResult();
          return new BootstrapTable<>(page.getTotalCount(), result);
    }

    /**
     *add
     */

    @RequestMapping("add")
    public R add(OauthMenuModule oauthMenuModule) {

        boolean b = false;
        try {
            b = menuModuleService.save(oauthMenuModule);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            if (b)
                return R.ok("添加成功");
            else {
                return R.error("添加失败");
            }
        }
    }

    /**
     *提交编辑
     */

    @RequestMapping("doEdit")
    public R doEdit(OauthMenuModule oauthMenuModule) throws Exception {

        boolean flag = false;
        try {
            flag = menuModuleService.edit(oauthMenuModule);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            if (flag) {
                return R.ok("更新成功");
            } else {
                return R.ok("更新失败");
            }
        }
    }

    /**
     *删除
     */
    @RequestMapping("delete")
    public R delete(String id) {
        try {
            menuModuleService.delete(id);
        }catch (Exception e){
            e.printStackTrace();
        }
        return R.ok("删除成功");

    }
}
