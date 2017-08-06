package org.templateproject.oauth2.page.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.entity.OauthResource;
import org.templateproject.oauth2.service.ResourceService;
import org.templateproject.oauth2.support.TemplateController;
import org.templateproject.oauth2.support.pojo.bo.ResourceBO;
import org.templateproject.oauth2.support.pojo.vo.ResourceVO;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * Created by Liurongqi on 2017/7/13.
 */

@RestController
@RequestMapping("resource/api")
public class ResourceRestController extends TemplateController {

    private ResourceService resourceService;

    @Autowired
    public void setResourceService(ResourceService resourceService) {
        this.resourceService = resourceService;
    }

    @RequestMapping("list")
    public BootstrapTable<ResourceVO> resources(Page<ResourceVO> page, ResourceBO resourceBO){
        page = resourceService.getResourcePage(resourceBO, queryParam2Page(resourceBO, page));
        List<ResourceVO> result = page.getTResult();
        return new BootstrapTable<>(page.getTotalCount(), result);
    }

    @RequestMapping("add")
    public R add(OauthResource oauthResource){
        try {
            if (resourceService.save(oauthResource))
                return R.ok("添加成功");
            else return R.error("添加失败");
        } catch (Exception e) {
             return R.error("添加异常，异常信息："+e.getMessage());
        }
    }

    @RequestMapping("edit")
    public R edit(OauthResource oauthResource){
        try {
            if (resourceService.edit(oauthResource))
                return R.ok("编辑成功");
            else return R.error("编辑失败");
        } catch (Exception e) {
            return R.error("编辑异常，异常信息："+e.getMessage());
        }
    }

    @RequestMapping("delete")
    public R delete(String ids)throws Exception{
        resourceService.delete(ids);
        return R.ok("删除成功");
    }

}
