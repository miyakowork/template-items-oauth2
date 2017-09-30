package me.wuwenbin.items.oauth2.config.support.filter;

import me.wuwenbin.items.oauth2.constant.CommonConsts;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/**
 * 先处理session是否过期。
 * 访问时先判断session是否已过期，过期了再根据访问的方式(ajax、router、html等)来进行下一步处理。
 * 处理完之后就不必再继续下一个filter处理了，因为已经处理完了(页面重定向、ajax返回等)
 * Created by wuwenbin on 2017/6/1.
 */
@Component
public class SessionTimeoutFilter extends AccessControlFilter implements TemplateFilter {

    private static Logger LOG = LoggerFactory.getLogger(SessionTimeoutFilter.class);

    @Override
    protected boolean isAccessAllowed(ServletRequest servletRequest, ServletResponse servletResponse, Object mappedValue) throws Exception {
        HttpServletRequest request = WebUtils.toHttp(servletRequest);
        String URI = request.getRequestURI();
        String method = request.getMethod();
        LOG.info("--SessionTimeoutFilter，访问URI:[{}]，请求方式:[{}]", URI, method);

        Subject subject = getSubject(servletRequest, servletResponse);
        Session session = subject.getSession(false);

        boolean isSessionTimeout = session == null || System.currentTimeMillis() - session.getLastAccessTime().getTime() > session.getTimeout();
        return !isSessionTimeout;
    }


    /**
     * 如果访问被拒绝了则返回false表名自己已经处理了，不需要下一个处理了，不继续拦截器链的执行
     * 此处返回true表明继续下一个拦截器处理
     *
     * @param servletRequest
     * @param servletResponse
     * @return
     * @throws Exception
     */
    @Override
    protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
        return denyControl(servletRequest, servletResponse, "登录过期超时，请重新登录！", CommonConsts.LOGIN_URL);
    }

}
