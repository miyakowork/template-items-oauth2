package org.templateproject.oauth2.page.sysparam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.entity.OauthSystemParam;
import org.templateproject.oauth2.service.SystemParamService;
import org.templateproject.oauth2.support.TemplateController;
import org.templateproject.oauth2.support.pojo.bo.SysParamBo;
import org.templateproject.oauth2.support.pojo.vo.SystemParamVO;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * Created by tuchen on 2017/7/13.
 */
@RestController
@RequestMapping("/sysparam/api")
public class SystemParamRestController extends TemplateController {


    private SystemParamService systemParamService;

    @Autowired
    public void setSystemParamService(SystemParamService systemParamService) {
        this.systemParamService = systemParamService;
    }

    @RequestMapping("/list")
    public BootstrapTable<SystemParamVO> sysParams(SysParamBo sysParamBo, Page<SystemParamVO> page) {
        //把当前PageSize 和 当前页面的最后一条记录传给Page
        page = queryParam2Page(sysParamBo, page);
        //通过sysParamBo传递的参数 查询page
        page = systemParamService.findPageByName(page, sysParamBo);
        //返回结果
        List<SystemParamVO> result = page.getTResult();
        return new BootstrapTable<>(page.getTotalCount(), result);
    }

    @RequestMapping("/add")
    public R add(OauthSystemParam oauthSystemParam) {
        //增加对象
        try {
            if (systemParamService.save(oauthSystemParam))
                return R.ok("添加成功");
            else return R.error("添加失败");

        } catch (Exception e) {
            return R.error("添加失败" + e.getMessage());
        }
    }

    @RequestMapping("/edit")
    public R edit(OauthSystemParam oauthSystemParam) {
        //修改数据
        try {
            if (systemParamService.edit(oauthSystemParam))
                return R.ok("编辑成功");
            else return R.error("编辑失败");
        } catch (Exception e) {
            return R.error("编辑失败" + e.getMessage());
        }

    }

    @RequestMapping("del")
    public R del(String _ids) {
        try {
            systemParamService.del(_ids);
            return R.ok("删除成功");
        } catch (Exception e) {
            return R.error("删除失败" + e.getMessage());
        }
    }
}
