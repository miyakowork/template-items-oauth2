package org.templateproject.items.oauth2.config.support.filter;

import me.wuwenbin.json.JoddJsonUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.templateproject.items.oauth2.config.support.utils.FilterUtils;
import org.templateproject.items.oauth2.constant.CommonConsts;
import org.templateproject.items.oauth2.constant.ShiroConsts;
import org.templateproject.items.oauth2.util.HttpUtils;
import org.templateproject.pojo.response.R;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * 用于验证码验证的 Shiro 拦截器在用于身份认证的拦截器之前运行;
 * 但是如果验证码验证 拦截器失败了，就不需要进行身份认证拦截器流程了;
 * 所以需要修改下如 FormAuthenticationFilter 身份认证拦截器，当验证码验证失败时不再走身份认证拦截器。
 * Created by wuwenbin on 2017/2/22.
 *
 * @author wuwenbin
 * @since 1.0
 */
public class MyFormAuthenticationFilter extends FormAuthenticationFilter implements TemplateFilter {

    private static final Logger LOG = LoggerFactory.getLogger(MyFormAuthenticationFilter.class);

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        HttpServletRequest req = (HttpServletRequest) request;
        String URI = req.getRequestURI();
        String method = req.getMethod();
        LOG.info("-- FormAuthenticationFilter，访问URI：[{}]，请求方式：[{}]", URI, method);

        //保存登录之前的url，以供登录成功之后跳转
        if (req.getQueryString() != null)
            URI = URI.concat("?").concat(req.getQueryString());
        if (!isLoginOrFavicon(URI))
            req.getSession().setAttribute(ShiroConsts.BEGORE_LOGIN_SUCCESS_URL, URI);

        return super.isAccessAllowed(request, response, mappedValue);
    }

    @Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;
        httpServletRequest.getSession().removeAttribute(ShiroConsts.SESSION_FORCE_LOGOUT_KEY);
        Object URI = httpServletRequest.getSession().getAttribute(ShiroConsts.BEGORE_LOGIN_SUCCESS_URL);
        String uri = URI != null ? StringUtils.isNotEmpty(URI.toString()) ? URI.toString() : getSuccessUrl() : getSuccessUrl();
        if (!HttpUtils.isAjax(httpServletRequest)) {// 不是ajax请求
            WebUtils.getAndClearSavedRequest(request);
            WebUtils.redirectToSavedRequest(request, response, uri);
            return false;
        } else {
            httpServletResponse.setCharacterEncoding("UTF-8");
            PrintWriter out = httpServletResponse.getWriter();
            String json = JoddJsonUtils.serializer()
                    .include("code", "message", "data").serialize(R.ok("登录成功", uri));
            out.println(json);
            out.flush();
            out.close();
            return false;
        }
    }

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        if (isLoginRequest(request, response)) {
            if (isLoginSubmission(request, response)) {
                if (LOG.isTraceEnabled()) {
                    LOG.trace("检测到登录操作，尝试执行登录.");
                }
                return executeLogin(request, response);
            } else {
                if (LOG.isTraceEnabled()) {
                    LOG.trace("转向登录页面");
                }
                //allow them to see the login page ;)
                return true;
            }
        } else {
            HttpServletRequest httpServletRequest = WebUtils.toHttp(request);
            if (HttpUtils.isAjax(httpServletRequest)) {
                if (HttpUtils.isRouter(httpServletRequest)) {
                    if (LOG.isTraceEnabled()) {
                        LOG.trace("尝试访问一个需要认证身份信息的路由. 跳转至认证路由：[" + CommonConsts.LOGIN_ROUTER + "]");
                    }
                    saveRequest(request);
                    WebUtils.issueRedirect(request, response, CommonConsts.LOGIN_ROUTER);
                } else {
                    HttpServletResponse httpServletResponse = WebUtils.toHttp(response);
                    if (LOG.isTraceEnabled()) {
                        LOG.trace("尝试访问一个需要认证身份信息的路由. 跳转至认证地址：[" + getLoginUrl() + "]");
                    }
                    saveRequest(request);
                    FilterUtils.ajaxControl(httpServletResponse, "请登陆后再操作！");
                }
            } else {
                if (LOG.isTraceEnabled()) {
                    LOG.trace("尝试访问一个需要认证身份信息的路由. 跳转至认证地址：[" + getLoginUrl() + "]");
                }
                saveRequestAndRedirectToLogin(request, response);
            }
            return false;
        }
//        return super.onAccessDenied(request, response);
    }

    @Override
    protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) {
        String username = getUsername(request);
        String password = getPassword(request);
        return this.createToken(username, password, request);
    }

    private AuthenticationToken createToken(String username, String password, ServletRequest request) {
        boolean rememberMe = isRememberMe(request);
        String host = getHost(request);
        return this.createToken(username, password, rememberMe, host);
    }

    protected AuthenticationToken createToken(String username, String password, boolean rememberMe, String host) {
        return new UsernamePasswordToken(username, password, rememberMe, host);
    }


}
