package me.wuwenbin.items.oauth2.page.log;

import me.wuwenbin.items.oauth2.service.LogService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import me.wuwenbin.items.oauth2.support.pojo.bo.LogBO;
import me.wuwenbin.items.oauth2.support.pojo.vo.LoginLogVO;
import me.wuwenbin.modules.pagination.model.bootstrap.BootstrapTable;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.pojo.page.Page;

/**
 * Created by Administrator on 2017/7/13/013.
 */
@RestController
@RequestMapping("oauth2/log/api")
public class logRestController extends BaseRestController {

    private LogService logService;

    @Autowired
    public void setLogService(LogService logService) {
        this.logService = logService;
    }

    @RequestMapping("list")
    @RequiresPermissions("base:log:list")
    @AuthResource(name = "获取用户登录日志列表")
    public BootstrapTable<LoginLogVO> list(Page<LoginLogVO> page, LogBO logBO) {
        page = logService.findLogPage(page, logBO);
        return bootstrapTable(page);
    }

}
