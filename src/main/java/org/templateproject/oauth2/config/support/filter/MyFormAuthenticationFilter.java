package org.templateproject.oauth2.config.support.filter;

import me.wuwenbin.json.JoddJsonUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMethod;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ShiroConsts;
import org.templateproject.oauth2.util.ShiroUtils;
import org.templateproject.oauth2.util.SpringUtils;
import org.templateproject.pojo.response.R;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.*;

/**
 * 用于验证码验证的 Shiro 拦截器在用于身份认证的拦截器之前运行;
 * 但是如果验证码验证 拦截器失败了，就不需要进行身份认证拦截器流程了;
 * 所以需要修改下如 FormAuthenticationFilter 身份认证拦截器，当验证码验证失败时不再走身份认证拦截器。
 * Created by wuwenbin on 2017/2/22.
 *
 * @author wuwenbin
 * @since 1.0
 */
public class MyFormAuthenticationFilter extends FormAuthenticationFilter {

    private static final Logger LOG = LoggerFactory.getLogger(MyFormAuthenticationFilter.class);

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        HttpServletRequest req = (HttpServletRequest) request;
        String URI = req.getRequestURI();
        String method = req.getMethod();
        LOG.info("-- FormAuthenticationFilter，访问URI：[{}]，请求方式：[{}]", URI, method);

        //如果是ico
        if (URI.contains(CommonConsts.FAVICON))
            return true;

        //如果是静态资源，pass
        if (URI.startsWith("/static/")) return true;

        //如果是登录url（路由形式的）并且是get请求方式，pass
        if (URI.equalsIgnoreCase(CommonConsts.LOGIN_ROUTER) && method.equals(RequestMethod.GET.name()))
            return true;

        //如果是登录url（普通url的请求形式），并且是get请求方式，pass
        return (URI.equalsIgnoreCase(CommonConsts.LOGIN_URL) || URI.contains(";JSESSIONID=")) && method.equals(RequestMethod.GET.name()) || super.isAccessAllowed(request, response, mappedValue);

    }

    @Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;
        Object URI = httpServletRequest.getSession().getAttribute(ShiroConsts.BEGORE_LOGIN_SUCCESS_URL);
        String uri = URI != null ? StringUtils.isNotEmpty(URI.toString()) ? URI.toString() : getSuccessUrl() : getSuccessUrl();
        if (!"XMLHttpRequest".equalsIgnoreCase(httpServletRequest.getHeader("X-Requested-With"))) {// 不是ajax请求
            WebUtils.getAndClearSavedRequest(request);
            WebUtils.redirectToSavedRequest(request, response, uri);
//            return super.onLoginSuccess(token, subject, request, response);
            return false;
        } else {
            httpServletResponse.setCharacterEncoding("UTF-8");
            PrintWriter out = httpServletResponse.getWriter();
            String json = JoddJsonUtils.serializer().include("code", "message", "data").serialize(R.ok("登录成功", uri));
            out.println(json);
            out.flush();
            out.close();
            return false;
        }
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
