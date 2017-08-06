package org.templateproject.oauth2.page.resmodule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.entity.OauthResourceModule;
import org.templateproject.oauth2.service.ResModuleService;
import org.templateproject.oauth2.support.TemplateController;
import org.templateproject.oauth2.support.pojo.bo.ResModuleBo;
import org.templateproject.oauth2.support.pojo.bo.ZTreeBO;
import org.templateproject.oauth2.support.pojo.vo.ResourceModuleVO;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * 资源模块的REST控制层
 * 修改备注：增加类注释
 * modify by wuwenbin on 2017/7/14.
 * Created by tuchen on 2017/7/12.
 */
@RestController
@RequestMapping("/resmodule/api")
public class ResourceModuleRestController extends TemplateController {


    private ResModuleService resModuleService;

    @Autowired
    public void setResModuleService(ResModuleService resModuleService) {
        this.resModuleService = resModuleService;
    }

    @RequestMapping("list")
    public BootstrapTable<ResourceModuleVO> oauthResourceModule(ResModuleBo resModuleBo, Page<ResourceModuleVO> page) {
        //把当前PageSize 和 当前页面的最后一条记录传给Page
        page = queryParam2Page(resModuleBo, page);

        //通过resModuleBo传递的参数 查询 page
        page = resModuleService.findPageByName(page, resModuleBo);

        //返回结果
        List<ResourceModuleVO> result = page.getTResult();
        return new BootstrapTable<>(page.getTotalCount(), result);
    }

    @RequestMapping("add")
    public R add(OauthResourceModule oauthResourceModule) {
        //添加数据
        try {
            if (resModuleService.save(oauthResourceModule))
                return R.ok("添加成功");
            else {
                return R.ok();
            }
        } catch (Exception e) {
            return R.error("添加失败" + e.getMessage());
        }

    }

    @RequestMapping("edit")
    public R edit(OauthResourceModule oauthResourceModule) {
        //修改数据
        try {
            if (resModuleService.edit(oauthResourceModule))
                return R.ok("编辑资源模块成功");
            else
                return R.error("编辑资源模块失败");

        } catch (Exception e) {
            return R.error("编辑资源模块失败" + e.getMessage());
        }
    }

    @RequestMapping("del")
    public R del(String _ids) {
        try {
            resModuleService.del(_ids);
            return R.ok("删除成功");
        } catch (Exception e) {
            return R.error("删除失败，失败信息：" + e.getMessage());
        }
    }

    /**
     * 根据资源模块Id 和角色Id 查询出资源模块树
     * @param roleId
     * @return
     */
    @RequestMapping("resmoduleTree")
    public List<ZTreeBO> resourceModulesTree(String roleId, String resModuleId){
        try {
            return resModuleService.findResModuleTree(roleId,resModuleId);
        } catch (Exception e) {
            return null;
        }

    }


}
