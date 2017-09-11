package me.wuwenbin.items.oauth2.page.session;

import me.wuwenbin.items.oauth2.config.support.session.MySQLSessionDao;
import me.wuwenbin.items.oauth2.constant.ShiroConsts;
import me.wuwenbin.items.oauth2.entity.shiro.ShiroSession;
import me.wuwenbin.items.oauth2.service.shiro.ShiroSessionService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import me.wuwenbin.items.oauth2.support.pojo.bo.SessionBO;
import me.wuwenbin.modules.pagination.model.bootstrap.BootstrapTable;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

/**
 * Created by Wuwenbin on 2017/7/20.
 */
@RestController
@RequestMapping("oauth2/session/api")
public class SessionRestController extends BaseRestController {

    private ShiroSessionService shiroSessionService;
    private MySQLSessionDao sessionDao;

    @Autowired
    public SessionRestController(ShiroSessionService shiroSessionService, MySQLSessionDao sessionDao) {
        this.shiroSessionService = shiroSessionService;
        this.sessionDao = sessionDao;
    }

    @RequestMapping("list")
    @RequiresPermissions("base:session:list")
    @AuthResource(name = "获取会话列表页面的数据")
    public BootstrapTable<ShiroSession> page(Page<ShiroSession> page, SessionBO sessionBO) {
        page = shiroSessionService.findPage(page, sessionBO);
        return bootstrapTable(page);
    }

    /**
     * 强制踢出用户
     *
     * @param sessionId session id
     * @return 处理信息
     */
    @RequestMapping("forcelogout")
    @RequiresPermissions("base:session:forcelogout")
    @AuthResource(name = "强制踢出用户")
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
