package me.wuwenbin.items.oauth2.page.resource;

import me.wuwenbin.items.oauth2.entity.IResource;
import me.wuwenbin.items.oauth2.service.ResourceService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import me.wuwenbin.items.oauth2.support.pojo.bo.ResourceBO;
import me.wuwenbin.items.oauth2.support.pojo.bo.ResourceLayBO;
import me.wuwenbin.items.oauth2.support.pojo.vo.ResourceVO;
import me.wuwenbin.modules.pagination.model.bootstrap.BootstrapTable;
import me.wuwenbin.modules.pagination.model.layui.LayTable;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

/**
 * Created by Wuwenbin on 2017/8/3.
 */
@RestController
@RequestMapping("oauth2/resource/api")
public class ResourceRestController extends BaseRestController {

    private ResourceService resourceService;

    @Autowired
    public void setResourceService(ResourceService resourceService) {
        this.resourceService = resourceService;
    }

    /**
     * 资源列表页面
     *
     * @param page
     * @param resourceBO
     * @return
     */
    @RequestMapping("list")
    @RequiresPermissions("base:resource:list")
    @AuthResource(name = "获取资源列表页面数据")
    public BootstrapTable<ResourceVO> resources(Page<ResourceVO> page, ResourceBO resourceBO) {
        page = resourceService.findResourcePage(resourceBO, page);
        return bootstrapTable(page);
    }

    /**
     * 查询未分配的资源列表
     *
     * @param page
     * @param resourceBO
     * @return
     */
    @RequestMapping("selectResources")
    @RequiresPermissions("base:resource:selectResources")
    @AuthResource(name = "获取资源列表弹框选择页面的数据")
    public LayTable<ResourceVO> selectResources(Page<ResourceVO> page, ResourceLayBO resourceBO) {
        page = resourceService.findResourceSelectPage(resourceBO, page);
        return layTable(page);
    }

    /**
     * 添加新资源
     *
     * @param iResource
     * @return
     */
    @RequestMapping("add")
    @RequiresPermissions("base:resource:add")
    @AuthResource(name = "添加新资源操作")
    public R add(IResource iResource) {
        return ajaxDoneAdd("资源", resourceService, iResource, IResource.class);
    }

    /**
     * 编辑资源信息
     *
     * @param iResource
     * @return
     */
    @RequestMapping("edit")
    @RequiresPermissions("base:resource:edit")
    @AuthResource(name = "编辑资源信息操作")
    public R edit(IResource iResource) {
        return ajaxDoneEdit("资源", resourceService, iResource, IResource.class);
    }


    /**
     * 删除资源
     *
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping("delete")
    @RequiresPermissions("base:resource:delete")
    @AuthResource(name = "删除资源信息操作")
    public R delete(String ids) throws Exception {
        return ajaxDoneDelete("资源", ids.split(","), resourceService, IResource.class);
    }


}
