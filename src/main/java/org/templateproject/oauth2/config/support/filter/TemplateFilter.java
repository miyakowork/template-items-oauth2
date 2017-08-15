package org.templateproject.oauth2.config.support.filter;

import me.wuwenbin.json.JoddJsonUtils;
import org.apache.shiro.web.util.WebUtils;
import org.templateproject.oauth2.config.support.utils.FilterUtils;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.util.HttpUtils;
import org.templateproject.pojo.response.R;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * created by Wuwenbin on 2017/8/11 at 19:11
 */
public interface TemplateFilter {

    /**
     * 通用被拒绝时候的处理
     *
     * @param servletRequest
     * @param servletResponse
     * @param ajaxMessage
     * @param loginUrl
     * @throws IOException
     */
    default boolean denyControl(ServletRequest servletRequest, ServletResponse servletResponse, String ajaxMessage, String loginUrl) throws IOException {
        HttpServletRequest request = WebUtils.toHttp(servletRequest);
        HttpServletResponse response = WebUtils.toHttp(servletResponse);
        if (HttpUtils.isAjax(request)) {
            if (HttpUtils.isRouter(request)) {
                WebUtils.issueRedirect(servletRequest, servletResponse, CommonConsts.LOGIN_ROUTER);
            } else {
                FilterUtils.ajaxControl(response, ajaxMessage);
            }
        } else {
            if (loginUrl == null || "".equals(loginUrl)) {
                loginUrl = CommonConsts.LOGIN_URL;
            }
            WebUtils.saveRequest(servletRequest);
            WebUtils.issueRedirect(request, response, loginUrl);
        }
        return false;
    }

    /**
     * authc验证器的处理
     *
     * @param servletRequest
     * @param servletResponse
     * @param ajaxMessage
     * @param loginUrl
     * @return
     * @throws IOException
     */
    default boolean denyControlOnFormAuthenticationFilter(ServletRequest servletRequest, ServletResponse servletResponse, String ajaxMessage, String loginUrl) throws IOException {
        HttpServletRequest request = WebUtils.toHttp(servletRequest);
        HttpServletResponse response = WebUtils.toHttp(servletResponse);
        if (HttpUtils.isAjax(request)) {
            if (HttpUtils.isRouter(request)) {
                WebUtils.issueRedirect(servletRequest, servletResponse, CommonConsts.LOGIN_ROUTER);
                return false;
            } else {
                if (HttpUtils.isAjax(request) && !HttpUtils.isRouter(request)) {
                    FilterUtils.ajaxControl(response, ajaxMessage);
                    return false;
                }

            }
        }
        return true;
    }

    /**
     * 判断url是不是登录页面、登录路由或者事favicon
     *
     * @param uri
     * @return
     */
    default boolean isLoginOrFavicon(String uri) {
        return uri.contains(CommonConsts.LOGIN_ROUTER) || uri.contains(CommonConsts.LOGIN_URL) || uri.contains(CommonConsts.FAVICON);
    }

}
