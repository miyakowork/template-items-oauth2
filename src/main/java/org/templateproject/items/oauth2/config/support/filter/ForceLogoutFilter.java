package org.templateproject.items.oauth2.config.support.filter;

import org.apache.shiro.session.Session;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.templateproject.items.oauth2.constant.ShiroConsts;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.util.UUID;

/**
 * 强制退出拦截器
 * Created by wuwenbin on 2017/8/9.
 */
@Component
public class ForceLogoutFilter extends AccessControlFilter implements TemplateFilter {

    private static Logger LOG = LoggerFactory.getLogger(ForceLogoutFilter.class);

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
        HttpServletRequest req = WebUtils.toHttp(request);
        String URI = req.getRequestURI();
        String method = req.getMethod();
        LOG.info("--SessionTimeoutFilter，访问URI:[{}]，请求方式:[{}]", URI, method);

        //保存登录之前的url，以供登录成功之后跳转
        if (req.getQueryString() != null)
            URI = URI.concat("?").concat(req.getQueryString());
        if (!isLoginOrFavicon(URI))
            req.getSession().setAttribute(ShiroConsts.BEGORE_LOGIN_SUCCESS_URL, URI);

        Session session = getSubject(request, response).getSession(false);
        if (session != null) {
            Object forceLogoutFlag = session.getAttribute(ShiroConsts.SESSION_FORCE_LOGOUT_KEY);
            return forceLogoutFlag == null;
        }
        return false;
    }

    /**
     * 访问拒绝就停职拦截器链的执行，停止执行下一个拦截器，到此为止
     *
     * @param servletRequest
     * @param servletResponse
     * @return
     * @throws Exception
     */
    @Override
    protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
        HttpServletRequest request = WebUtils.toHttp(servletRequest);
        //如果shiro session不为空，则强制退出
        if (getSubject(servletRequest, servletResponse).getSession(false) != null) {
            try {
                getSubject(servletRequest, servletResponse).logout();//强制退出
            } catch (Exception e) {/*ignore exception*/}
        }

        //退出之后开始确定登录url
        String loginUrl = getLoginUrl();
        String message = "请重新登录！";
        //如果不为空，则确定是被强制退出的，loginUrl加上forceLogout参数
        if (request.getSession().getAttribute(ShiroConsts.SESSION_FORCE_LOGOUT_KEY) != null) {
            loginUrl += (getLoginUrl().contains("?") ? "&" : "?") + "forceLogout=" + UUID.randomUUID().toString().replace("-", "");
            message = "您已被强制退出，请重新登录！";
        }
        return denyControl(servletRequest, servletResponse, message, loginUrl);
    }
}
