package org.templateproject.items.oauth2.page.log;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.items.oauth2.service.LogService;
import org.templateproject.items.oauth2.support.BaseRestController;
import org.templateproject.items.oauth2.support.pojo.BootstrapTable;
import org.templateproject.items.oauth2.support.pojo.bo.LogBO;
import org.templateproject.items.oauth2.support.pojo.vo.LoginLogVO;
import org.templateproject.pojo.page.Page;

/**
 * Created by Administrator on 2017/7/13/013.
 */
@RestController
@RequestMapping("log/api")
public class logRestController extends BaseRestController {

    private LogService logService;

    @Autowired
    public void setLogService(LogService logService) {
        this.logService = logService;
    }

    @RequestMapping("list")
    public BootstrapTable<LoginLogVO> list(Page<LoginLogVO> page, LogBO logBO) {
        page = logService.findLogPage(page, logBO);
        return bootstrapTable(page);
    }

}
