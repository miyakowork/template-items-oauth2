package org.templateproject.items.oauth2.page.resModule;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.items.oauth2.entity.IResourceModule;
import org.templateproject.items.oauth2.service.ResModuleService;
import org.templateproject.items.oauth2.support.BaseRestController;
import org.templateproject.items.oauth2.support.pojo.BootstrapTable;
import org.templateproject.items.oauth2.support.pojo.bo.ResModuleBo;
import org.templateproject.items.oauth2.support.pojo.bo.ZTreeBO;
import org.templateproject.items.oauth2.support.pojo.vo.ResourceModuleVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * 资源模块的REST控制层
 * Created by wuwenbin on 2017/8/8.
 */
@RestController
@RequestMapping("/oauth2/resModule/api")
public class ResourceModuleRestController extends BaseRestController {


    private ResModuleService resModuleService;

    @Autowired
    public void setResModuleService(ResModuleService resModuleService) {
        this.resModuleService = resModuleService;
    }

    /**
     * 资源模块管理页面
     *
     * @param resModuleBo 搜索对象
     * @param page        page
     * @return bootstrap table
     */
    @RequestMapping("list")
    public BootstrapTable<ResourceModuleVO> oauthResourceModule(ResModuleBo resModuleBo, Page<ResourceModuleVO> page) {
        page = resModuleService.findResModulePage(page, resModuleBo);
        return bootstrapTable(page);
    }

    /**
     * 添加新资源模块
     *
     * @param iResourceModule 添加的资源模块
     * @return R
     */
    @RequestMapping("add")
    public R add(IResourceModule iResourceModule) {
        try {
            if (resModuleService.save(iResourceModule, IResourceModule.class))
                return R.ok("添加成功");
            else {
                return R.ok();
            }
        } catch (Exception e) {
            return R.error("添加失败" + e.getMessage());
        }

    }

    /**
     * 修改资源模块
     *
     * @param iResourceModule 修改的资源模块
     * @return R
     */
    @RequestMapping("edit")
    public R edit(IResourceModule iResourceModule) {
        try {
            if (resModuleService.edit(iResourceModule, IResourceModule.class))
                return R.ok("编辑资源模块成功");
            else
                return R.error("编辑资源模块失败");

        } catch (Exception e) {
            return R.error("编辑资源模块失败" + e.getMessage());
        }
    }


    /**
     * 查询出资源模块树
     *
     * @return list zTree
     */
    @RequestMapping("resModuleTree")
    public List<ZTreeBO> resourceModulesTree(String systemModuleCode) {
        if (StringUtils.isEmpty(systemModuleCode))
            return resModuleService.resModuleToZTree(resModuleService.findEnabledResModules());
        else
            return resModuleService.resModuleToZTree(resModuleService.findEnabledResModulesBySystemModuleCode(systemModuleCode));
    }


}
