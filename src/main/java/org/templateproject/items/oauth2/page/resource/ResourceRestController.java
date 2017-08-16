package org.templateproject.items.oauth2.page.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.items.oauth2.entity.IResource;
import org.templateproject.items.oauth2.service.ResourceService;
import org.templateproject.items.oauth2.support.BaseRestController;
import org.templateproject.items.oauth2.support.pojo.BootstrapTable;
import org.templateproject.items.oauth2.support.pojo.bo.ResourceBO;
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
        page = resourceService.findResourcePage(resourceBO, queryParam2Page(resourceBO, page));
        return bootstrapTable(page);
    }

    /**
     * 添加新资源
     *
     * @param iResource
     * @return
     */
    @RequestMapping("add")
    public R add(IResource iResource) {
        try {
            if (resourceService.save(iResource, IResource.class))
                return R.ok("添加成功");
            else return R.error("添加失败");
        } catch (Exception e) {
            return R.error("添加异常，异常信息：" + e.getMessage());
        }
    }

    /**
     * 编辑资源信息
     *
     * @param iResource
     * @return
     */
    @RequestMapping("edit")
    public R edit(IResource iResource) {
        try {
            if (resourceService.edit(iResource, IResource.class))
                return R.ok("编辑成功");
            else return R.error("编辑失败");
        } catch (Exception e) {
            return R.error("编辑异常，异常信息：" + e.getMessage());
        }
    }

    @RequestMapping("hide")
    public R hide(String ids) {
        try {
            resourceService.hideResourceByIds(ids);
            return R.ok("删除成功");
        } catch (Exception e) {
            LOGGER.error("删除过程出现异常，异常信息：{}", e);
            return R.error("删除过程中出现异常，异常信息：", e.getMessage());
        }
    }

    @RequestMapping("delete")
    public R delete(String ids) throws Exception {
        resourceService.delete(ids);
        return R.ok("删除成功");
    }

}
