package org.templateproject.oauth2.config.support.filter;

import org.apache.shiro.web.filter.authc.UserFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMethod;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.util.ShiroUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

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
                return false;
        }
}
