package org.templateproject.oauth2.page.sysParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.entity.OauthSystemParam;
import org.templateproject.oauth2.service.SystemParamService;
import org.templateproject.oauth2.support.BaseRestController;
import org.templateproject.oauth2.support.TemplateController;
import org.templateproject.oauth2.support.pojo.bo.SysParamBo;
import org.templateproject.oauth2.support.pojo.vo.SystemParamVO;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * Created by Wuwenbin on 2017/8/03.
 */
@RestController
@RequestMapping("oauth2/systemParam/api")
public class SystemParamRestController extends BaseRestController {


    private SystemParamService systemParamService;

    @Autowired
    public void setSystemParamService(SystemParamService systemParamService) {
        this.systemParamService = systemParamService;
    }

    /**
     * 系统参数页面
     *
     * @param sysParamBo sysParamBo
     * @param page       page
     * @return BootstrapTable
     */
    @RequestMapping("list")
    public BootstrapTable<SystemParamVO> sysParams(SysParamBo sysParamBo, Page<SystemParamVO> page) {
        page = systemParamService.findSystemParamPage(page, sysParamBo);
        return bootstrapTable(page);
    }

    /**
     * 添加系统参数
     *
     * @param oauthSystemParam 添加的对象
     * @return R
     */
    @RequestMapping("add")
    public R add(OauthSystemParam oauthSystemParam) {
        try {
            if (systemParamService.save(oauthSystemParam, OauthSystemParam.class))
                return R.ok("添加系统参数成功");
            else return R.error("添加失败");
        } catch (Exception e) {
            return R.error("添加系统参数失败，原因：" + e.getMessage());
        }
    }

    /**
     * 编辑的系统参数
     *
     * @param oauthSystemParam 编辑的对象
     * @return R
     */
    @RequestMapping("edit")
    public R edit(OauthSystemParam oauthSystemParam) {
        try {
            if (systemParamService.edit(oauthSystemParam, OauthSystemParam.class))
                return R.ok("编辑系统参数成功");
            else return R.error("编辑系统参数失败");
        } catch (Exception e) {
            return R.error("编辑系统参数失败，原因：" + e.getMessage());
        }

    }

}
