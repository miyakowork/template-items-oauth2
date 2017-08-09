package org.templateproject.oauth2.config.support.session;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.ValidatingSession;
import org.apache.shiro.session.mgt.eis.CachingSessionDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.templateproject.oauth2.constant.ShiroConsts;
import org.templateproject.oauth2.entity.shiro.ShiroSession;
import org.templateproject.oauth2.service.shiro.ShiroSessionService;
import org.templateproject.oauth2.util.SerializableUtils;
import org.templateproject.oauth2.util.SpringUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.util.Collection;

/**
 * session持久化存储
 * Created by Wuwenbin on 2017/7/19.
 */
@Component
public class MySQLSessionDao extends CachingSessionDAO {

    private static final Logger LOG = LoggerFactory.getLogger(MySQLSessionDao.class);

    private ShiroSessionService shiroSessionService = SpringUtils.getBean(ShiroSessionService.class);

    @Override
    protected void doUpdate(Session session) {
        if (session == null || session.getId() == null) {
            LOG.info("session or sessionId is null");
            return;
        }

        if (session instanceof ValidatingSession && !((ValidatingSession) session).isValid()) {
            return; //如果会话过期/停止 没必要再更新了
        }
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        if (request != null) {
            String uri = request.getRequestURI();
            if (uri.startsWith("/static/")) {
                LOG.info("-- load static resources:[" + uri + "], session is not treated");
                return;
            }
            if (uri.startsWith("/templates/") || uri.endsWith(".jsp") || uri.endsWith(".html")) {
                LOG.info("visit template view:[" + uri + "],session is not treated");
                return;
            }
        }

        ShiroSession shiroSession = new ShiroSession();
        shiroSession.setSessionId(session.getId().toString());
        shiroSession.setSessionBase64(SerializableUtils.serialize(session));
        shiroSession.setLastVisitDate(session.getLastAccessTime());
        assert request != null;
        shiroSession.setUpdateUrl(request.getRequestURL().toString());
        shiroSession.setIp(session.getHost());
        shiroSession.setSessionTimeout(session.getTimeout());
        shiroSession.setUserAgent(request.getHeader("User-Agent"));
        try {
            int n = shiroSessionService.updateShiroSession(shiroSession);
            LOG.info("更新shiroSession，影响条目:[{}]", n);
        } catch (Exception e) {
            LOG.error("更新shiroSession出现异常，异常信息：", e);
        }
    }

    @Override
    protected void doDelete(Session session) {
        if (session == null || session.getId() == null) {
            LOG.info("session or sessionId is null");
            return;
        }
        try {
            shiroSessionService.deleteShiroSession(session.getId().toString());//删除数据库中
        } catch (Exception e) {
            LOG.error("删除shiroSession出现异常，异常信息：", e);
        }
    }

    @Override
    protected Serializable doCreate(Session session) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        if (isStaticFile(request)) return null;
        Serializable sessionId = generateSessionId(session); //获取自定义 SessionID
        assignSessionId(session, sessionId);//设置SessionID
//        session.setTimeout(5000);//ShiroConfig中设置了全局的超时时间，此处可单独设置每个的超时间以覆盖全局的，此处仅
        ShiroSession shiroSession = new ShiroSession();
        shiroSession.setSessionId(session.getId().toString());
        String username;
        if (request.getSession().getAttribute(ShiroConsts.SESSION_USERNAME_KEY) != null) {
            username = request.getSession().getAttribute(ShiroConsts.SESSION_USERNAME_KEY).toString();
        } else {
            username = session.getHost();
        }
        shiroSession.setUsername(username);
        shiroSession.setFirstVisitDate(session.getStartTimestamp());
        shiroSession.setSessionBase64(SerializableUtils.serialize(session));
        shiroSession.setLastVisitDate(session.getLastAccessTime());
        shiroSession.setIp(session.getHost());
        shiroSession.setSessionTimeout(session.getTimeout());
        shiroSession.setCreateUrl(request.getRequestURL().toString());
        shiroSession.setUpdateUrl(request.getRequestURL().toString());
        shiroSession.setUserAgent(request.getHeader("User-Agent"));
        try {
            shiroSessionService.insertShiroSession(shiroSession);
            return session.getId();
        } catch (Exception e) {
            LOG.error("创建shiroSession出现异常，异常信息：", e);
            return null;
        }


    }

    @Override
    protected Session doReadSession(Serializable sessionId) {
        Session session = getCachedSession(sessionId);
        if (session == null) {
            ShiroSession sysSession = shiroSessionService.fetchSessionById(sessionId.toString());
            if (sysSession != null) {
                session = SerializableUtils.deserialize(sysSession.getSessionBase64());
            }
        }
        return session;
    }


    /**
     * 是否为静态资源文件
     *
     * @param request http请求
     * @return true：是静态文件
     */
    private boolean isStaticFile(HttpServletRequest request) {
        if (request != null) {
            String uri = request.getRequestURI();
            if (uri.startsWith("/static/")) {
                LOG.info("访问静态资源文件session不做处理");
                return true;
            }
        }
        return false;
    }


    @Override
    public Collection<Session> getActiveSessions() {
        return super.getActiveSessions();
    }
}
