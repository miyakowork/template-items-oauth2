package org.templateproject.items.oauth2.page.log;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.items.oauth2.service.LogService;
import org.templateproject.items.oauth2.support.TemplateController;
import org.templateproject.items.oauth2.support.pojo.BootstrapTable;
import org.templateproject.items.oauth2.support.pojo.bo.LogBO;
import org.templateproject.items.oauth2.support.pojo.vo.LoginLogVO;
import org.templateproject.pojo.page.Page;

import java.util.List;

/**
 * Created by Administrator on 2017/7/13/013.
 */
@RestController
@RequestMapping("log/api")
public class logRestController extends TemplateController {

    private LogService logService;

    @Autowired
    public void setLogService(LogService logService) {
        this.logService = logService;
    }

    @RequestMapping("list")
    public BootstrapTable<LoginLogVO> list(Page<LoginLogVO> page, LogBO logBO) {
        page = queryParam2Page(logBO, page);
        page = logService.findPage(page, logBO);
        List<LoginLogVO> result = page.getTResult();
        return new BootstrapTable<>(page.getTotalCount(), result);
    }

}
