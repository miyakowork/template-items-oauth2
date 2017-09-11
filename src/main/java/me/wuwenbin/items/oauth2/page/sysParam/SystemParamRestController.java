package me.wuwenbin.items.oauth2.page.sysParam;

import me.wuwenbin.items.oauth2.entity.ISystemParam;
import me.wuwenbin.items.oauth2.service.SystemParamService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import me.wuwenbin.items.oauth2.support.pojo.bo.SysParamBo;
import me.wuwenbin.items.oauth2.support.pojo.vo.SystemParamVO;
import me.wuwenbin.modules.pagination.model.bootstrap.BootstrapTable;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

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
    @RequiresPermissions("base:systemParam:list")
    @AuthResource(name = "获取系统参数列表页面的数据")
    public BootstrapTable<SystemParamVO> sysParams(SysParamBo sysParamBo, Page<SystemParamVO> page) {
        page = systemParamService.findSystemParamPage(page, sysParamBo);
        return bootstrapTable(page);
    }

    /**
     * 添加系统参数
     *
     * @param iSystemParam 添加的对象
     * @return R
     */
    @RequestMapping("add")
    @RequiresPermissions("base:systemParam:add")
    @AuthResource(name = "添加系统参数")
    public R add(ISystemParam iSystemParam) {
        return ajaxDoneAdd("系统参数", systemParamService, iSystemParam, ISystemParam.class);
    }

    /**
     * 编辑系统参数
     *
     * @param iSystemParam 编辑的对象
     * @return R
     */
    @RequestMapping("edit")
    @RequiresPermissions("base:systemParam:edit")
    @AuthResource(name = "编辑系统参数")
    public R edit(ISystemParam iSystemParam) {
        return ajaxDoneEdit("系统参数", systemParamService, iSystemParam, ISystemParam.class);
    }

    /**
     * 删除参数
     *
     * @param ids
     * @return
     */
    @RequestMapping("delete")
    @RequiresPermissions("base:systemParam:delete")
    @AuthResource(name = "删除参数")
    public R delete(String ids) {
        return ajaxDoneDelete("系统参数", ids.split(","), systemParamService, ISystemParam.class);
    }

}
