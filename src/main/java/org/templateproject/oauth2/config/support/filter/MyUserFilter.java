package org.templateproject.oauth2.config.support.filter;

import me.wuwenbin.json.JoddJsonUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.web.filter.authc.UserFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMethod;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.util.ShiroUtils;
import org.templateproject.pojo.response.R;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * created by Wuwenbin on 2017/8/2 at 20:44
 */
public class MyUserFilter extends UserFilter {

    private static final Logger LOG = LoggerFactory.getLogger(MyUserFilter.class);

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        HttpServletRequest req = (HttpServletRequest) request;
        String URI = req.getRequestURI();
        String method = req.getMethod();
        LOG.info("-- MyUserFilter，访问URI：[{}]，请求方式：[{}]", URI, method);

        //如果是ico
        if (URI.contains(CommonConsts.FAVICON))
            return true;
        //如果是静态资源，pass
        if (URI.startsWith("/static/")) return true;
        //如果是登录url（路由形式的）并且是get请求方式，pass
        if (URI.equalsIgnoreCase(CommonConsts.LOGIN_ROUTER) && method.equals(RequestMethod.GET.name()))
            return true;
        //如果是登录url（普通url的请求形式），并且是get请求方式，pass
        if ((URI.equalsIgnoreCase(CommonConsts.LOGIN_URL) || URI.contains(";JSESSIONID=")) && method.equals(RequestMethod.GET.name()))
            return true;
        boolean isRemembered = ShiroUtils.getSubject().isRemembered();
        return isRemembered || super.isAccessAllowed(request, response, mappedValue);
    }

    /**
     * 访问被拒绝就不再执行下一个filter
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;
        String headerAccept = httpServletRequest.getHeader("Accept");
        if (!StringUtils.isEmpty(headerAccept) && headerAccept.contains("text/html") && !isJson(httpServletRequest) && isAjax(httpServletRequest) && isGet(httpServletRequest)) {
            WebUtils.issueRedirect(request, response, CommonConsts.LOGIN_ROUTER);
        } else if (isJson(httpServletRequest)) {
            httpServletResponse.setCharacterEncoding("UTF-8");
            PrintWriter out = httpServletResponse.getWriter();
            String json = JoddJsonUtils.serializer().include("code", "message", "data").serialize(R.custom(301, "登录过期，请重新登录", CommonConsts.LOGIN_ROUTER));
            out.println(json);
            out.flush();
            out.close();
        } else {
            super.onAccessDenied(request, response);
        }
        return false;
    }


    /**
     * 是否为ajax请求
     *
     * @return
     */
    private boolean isAjax(HttpServletRequest request) {
        String header = request.getHeader("X-Requested-With");
        return "XMLHttpRequest".equalsIgnoreCase(header);
    }

    /**
     * 是否为json请求
     *
     * @return
     */
    private boolean isJson(HttpServletRequest request) {
        String headerAccept = request.getHeader("Accept");
        return !org.springframework.util.StringUtils.isEmpty(headerAccept) && headerAccept.contains("application/json");
    }

    /**
     * 是否为GET请求
     *
     * @return
     */
    protected boolean isGet(HttpServletRequest request) {
        String method = request.getMethod();
        return "GET".equalsIgnoreCase(method);
    }

}
