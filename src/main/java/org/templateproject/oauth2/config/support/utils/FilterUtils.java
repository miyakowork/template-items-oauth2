package org.templateproject.oauth2.config.support.utils;

import me.wuwenbin.json.JoddJsonUtils;
import org.apache.shiro.web.util.WebUtils;
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
 * created by Wuwenbin on 2017/8/10 at 15:31
 */
public class FilterUtils {

    /**
     * 通用被拒绝时候的处理
     *
     * @param servletRequest
     * @param servletResponse
     * @param ajaxMessage
     * @param loginUrl
     * @throws IOException
     */
    public static void onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse, String ajaxMessage, String loginUrl) throws IOException {
        HttpServletRequest request = WebUtils.toHttp(servletRequest);
        HttpServletResponse response = WebUtils.toHttp(servletResponse);
        if (HttpUtils.isAjax(request)) {
            if (HttpUtils.isRouter(request)) {
                WebUtils.issueRedirect(servletRequest, servletResponse, CommonConsts.LOGIN_ROUTER);
            } else {
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                String json = JoddJsonUtils.serializer()
                        .include("code", "message")
                        .serialize(R.custom(301, ajaxMessage));
                out.println(json);
                out.flush();
                out.close();
            }
        } else {
            if (loginUrl == null || "".equals(loginUrl)) {
                loginUrl = CommonConsts.LOGIN_URL;
            }
            WebUtils.saveRequest(servletRequest);
            WebUtils.issueRedirect(request, response, loginUrl);
        }
    }
}
