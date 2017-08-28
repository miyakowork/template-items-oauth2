package org.templateproject.items.oauth2.page.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.items.oauth2.entity.IResource;
import org.templateproject.items.oauth2.service.ResourceService;
import org.templateproject.items.oauth2.support.BaseRestController;
import org.templateproject.items.oauth2.support.pojo.BootstrapTable;
import org.templateproject.items.oauth2.support.pojo.LayTable;
import org.templateproject.items.oauth2.support.pojo.bo.ResourceBO;
import org.templateproject.items.oauth2.support.pojo.bo.ResourceLayBO;
import org.templateproject.items.oauth2.support.pojo.vo.ResourceVO;
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
    public BootstrapTable<ResourceVO> resources(Page<ResourceVO> page, ResourceBO resourceBO) {
        page = resourceService.findResourcePage(resourceBO, page);
        return bootstrapTable(page);
    }

    @RequestMapping("selectResources")
    public LayTable<ResourceVO> selectResources(Page<ResourceVO> page, ResourceLayBO resourceBO) {
        ResourceBO resBO = new ResourceBO();
        resBO.setName(resourceBO.getName());
        resBO.setPageNo(resourceBO.getPage());
        resBO.setLimit(resourceBO.getLimit());
        resBO.setSystemCode(resourceBO.getSystemModuleCode());
        page = resourceService.findResourcePage(resBO, page);
        return new LayTable<>(0, "", page.getTotalCount(), page.getTResult());
    }

    /**
     * 添加新资源
     *
     * @param iResource
     * @return
     */
    @RequestMapping("add")
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
    public R delete(String ids) throws Exception {
        return ajaxDoneDelete("资源", ids.split(","), resourceService, IResource.class);
    }


}
