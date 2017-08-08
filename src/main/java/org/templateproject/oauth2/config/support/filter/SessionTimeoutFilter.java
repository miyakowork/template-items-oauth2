package org.templateproject.oauth2.config.support.filter;

import jodd.util.StringUtil;
import me.wuwenbin.json.JoddJsonUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ShiroConsts;
import org.templateproject.pojo.response.R;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * 先处理session是否过期。
 * 访问时先判断session是否已过期，过期了再根据访问的方式(ajax、router、html等)来进行下一步处理。
 * 处理完之后就不必再继续下一个filter处理了，因为已经处理完了(页面重定向、ajax返回等)
 * Created by wuwenbin on 2017/6/1.
 */
@Component
public class SessionTimeoutFilter extends AccessControlFilter {


    private static Logger LOG = LoggerFactory.getLogger(SessionTimeoutFilter.class);

    @Override
    protected boolean isAccessAllowed(ServletRequest servletRequest, ServletResponse servletResponse, Object mappedValue) throws Exception {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String URI = request.getRequestURI();
        LOG.info("访问URI:[{}]，请求方式:[{}]", URI, request.getMethod());

        String[] URIS = URI.split(";");
        boolean isLoginUriOrRouter = URIS[0].equalsIgnoreCase(getLoginUrl())
                || URIS[0].equalsIgnoreCase(CommonConsts.LOGIN_ROUTER);

        if (URI.startsWith(CommonConsts.STATIC_RESOURCE_URI))
            return true;
        if (URI.endsWith(CommonConsts.FAVICON))
            return true;
        if (isLoginUriOrRouter)
            return true;

        Subject subject = getSubject(servletRequest, servletResponse);
        Session session = subject.getSession(false);

        //保存登录之前的url，以供登录成功之后跳转
        if (request.getQueryString() != null)
            URI = URI.concat("?").concat(request.getQueryString());
        request.getSession().setAttribute(ShiroConsts.BEGORE_LOGIN_SUCCESS_URL, URI);

        boolean isSubjectNull = subject == null;
        boolean isSessionTimeout = session == null
                || System.currentTimeMillis() - session.getLastAccessTime().getTime() > session.getTimeout();

        if (isSubjectNull || isSessionTimeout) {
            if (isAjax(request)) {
                if (isRouter(request)) {
                    String loginRouter = CommonConsts.LOGIN_ROUTER;
                    WebUtils.issueRedirect(servletRequest, servletResponse, loginRouter);
                } else {
                    String forceLogoutSign = request.getParameter("forceLogout");
                    String message = "login timeout, Please sign in again!";
                    if (StringUtil.isNotEmpty(forceLogoutSign)) {
                        message = "You have been forced to log out. Please sign in again!";
                    }
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();
                    String json = JoddJsonUtils.serializer()
                            .include("code", "message")
                            .serialize(R.ok(message));
                    out.println(json);
                    out.flush();
                    out.close();
                }
            } else {
                redirectToLogin(servletRequest, servletResponse);
            }
            return false;
        } else return true;
    }


    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        return false;//如果访问被拒绝了则返回false表名自己已经处理了，不需要下一个处理了，不继续拦截器链的执行
    }


    private boolean isAjax(HttpServletRequest request) {
        String header = request.getHeader("X-Requested-With");
        return "XMLHttpRequest".equalsIgnoreCase(header);
    }

    private boolean isJson(HttpServletRequest request) {
        String headerAccept = request.getHeader("Accept");
        return !StringUtils.isEmpty(headerAccept) && headerAccept.contains("application/json");
    }

    private boolean isRouter(HttpServletRequest request) {
        String headerAccept = request.getHeader("Accept");
        return !StringUtils.isEmpty(headerAccept) && headerAccept.contains("text/html") && !isJson(request) && isAjax(request) && isGet(request);
    }

    private boolean isGet(HttpServletRequest request) {
        String method = request.getMethod();
        return StringUtils.equalsIgnoreCase("GET", method);
    }
}
