package org.templateproject.items.oauth2.page.session;

import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.items.oauth2.config.support.session.MySQLSessionDao;
import org.templateproject.items.oauth2.constant.ShiroConsts;
import org.templateproject.items.oauth2.entity.shiro.ShiroSession;
import org.templateproject.items.oauth2.service.shiro.ShiroSessionService;
import org.templateproject.items.oauth2.support.TemplateController;
import org.templateproject.items.oauth2.support.pojo.BootstrapTable;
import org.templateproject.items.oauth2.support.pojo.bo.SessionBO;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

/**
 * Created by Wuwenbin on 2017/7/20.
 */
@RestController
@RequestMapping("session/api")
public class SessionRestController extends TemplateController {

    private ShiroSessionService shiroSessionService;
    private MySQLSessionDao sessionDao;

    @Autowired
    public SessionRestController(ShiroSessionService shiroSessionService, MySQLSessionDao sessionDao) {
        this.shiroSessionService = shiroSessionService;
        this.sessionDao = sessionDao;
    }

    @RequestMapping("list")
    public BootstrapTable<ShiroSession> page(Page<ShiroSession> page, SessionBO sessionBO) {
        page = queryParam2Page(sessionBO, page);
        page = shiroSessionService.findPage(page, sessionBO);
        return new BootstrapTable<>(page.getTotalCount(), page.getTResult());
    }

    /**
     * 强制踢出用户
     *
     * @param sessionId session id
     * @return 处理信息
     */
    @RequestMapping("forcelogout")
    public R forcelogout(String sessionId) {
        String[] sessionIds = sessionId.split(",");
        try {
            for (String sId : sessionIds) {
                Session session = sessionDao.readSession(sId);
                if (session != null) {
                    session.setAttribute(ShiroConsts.SESSION_FORCE_LOGOUT_KEY, Boolean.TRUE);
                    sessionDao.delete(session);
                }
            }
            return R.ok("强制退出成功！");
        } catch (Exception e) {
            return R.error("强制退出发生异常，异常信息：" + e.getMessage());
        }
    }
}
