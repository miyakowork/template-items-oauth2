package me.wuwenbin.items.oauth2.page.resModule;

import me.wuwenbin.items.oauth2.entity.IResourceModule;
import me.wuwenbin.items.oauth2.service.ResModuleService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.pojo.bo.ResModuleBo;
import me.wuwenbin.items.oauth2.support.pojo.bo.ZTreeBO;
import me.wuwenbin.items.oauth2.support.pojo.vo.ResourceModuleVO;
import me.wuwenbin.modules.pagination.model.bootstrap.BootstrapTable;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
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
        return ajaxDoneAdd("资源模块", resModuleService, iResourceModule, IResourceModule.class);
    }

    /**
     * 修改资源模块
     *
     * @param iResourceModule 修改的资源模块
     * @return R
     */
    @RequestMapping("edit")
    public R edit(IResourceModule iResourceModule) {
        return ajaxDoneEdit("资源模块", resModuleService, iResourceModule, IResourceModule.class);
    }

    /**
     * 删除资源模块
     *
     * @param ids
     * @return
     */
    @RequestMapping("delete")
    public R delete(String ids) {
        return ajaxDoneDelete("资源模块", ids.split(","), resModuleService, IResourceModule.class);
    }

    /**
     * 查询出资源模块树
     *
     * @return list zTree
     */
    @RequestMapping("resModuleTree")
    public List<ZTreeBO> resourceModulesTree(String systemModuleCode) {
        if (StringUtils.isEmpty(systemModuleCode))
            return resModuleService.resModuleToZTree(resModuleService.findEnabledListBean(IResourceModule.class));
        else
            return resModuleService.resModuleToZTree(resModuleService.findEnabledResModulesBySystemModuleCode(systemModuleCode));
    }


}
