package org.templateproject.items.oauth2.support.controller;

import org.springframework.util.NumberUtils;
import org.springframework.util.StringUtils;

/**
 * web相关方法
 * Created by Wuwenbin on 2017/7/12.
 */
public class MethodBootController extends FieldBootController {

    /**
     * 获取IP地址
     * <p>
     * 使用nginx等反向代理软件， 则不能通过request.getRemoteAddr()获取IP地址
     * 如果使用了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP地址，X-Forwarded-For中第一个非unknown的有效IP字符串，则为真实IP地址
     *
     * @return
     */
    protected String getRemoteAddr() {
        String remoteAddress = null;
        try {
            remoteAddress = getRequest().getHeader("x-forwarded-for");
            if (StringUtils.isEmpty(remoteAddress) || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = getRequest().getHeader("Proxy-Client-IP");
            }
            if (StringUtils.isEmpty(remoteAddress) || remoteAddress.length() == 0 || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = getRequest().getHeader("WL-Proxy-Client-IP");
            }
            if (StringUtils.isEmpty(remoteAddress) || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = getRequest().getHeader("HTTP_CLIENT_IP");
            }
            if (StringUtils.isEmpty(remoteAddress) || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = getRequest().getHeader("HTTP_X_FORWARDED_FOR");
            }
            if (StringUtils.isEmpty(remoteAddress) || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = getRequest().getRemoteAddr();
            }
        } catch (Exception e) {
            LOGGER.error("获取IP地址失败 ", e);
        }
        return remoteAddress;
    }

    /**
     * 是否为ajax请求
     *
     * @return
     */
    protected boolean isAjax() {
        String header = getRequest().getHeader("X-Requested-With");
        return "XMLHttpRequest".equalsIgnoreCase(header);
    }

    /**
     * 是否为json请求
     *
     * @return
     */
    protected boolean isJson() {
        String headerAccept = getRequest().getHeader("Accept");
        return !StringUtils.isEmpty(headerAccept) && headerAccept.contains("application/json");
    }

    /**
     * 是否为路由请求
     *
     * @return
     */
    protected boolean isRouter() {
        String headerAccept = getRequest().getHeader("Accept");
        return !StringUtils.isEmpty(headerAccept) && headerAccept.contains("text/html") && !isJson() && isAjax() && isGet();
    }

    /**
     * 是否为post请求
     *
     * @return
     */
    protected boolean isPost() {
        String method = getRequest().getMethod();
        return "POST".equalsIgnoreCase(method);
    }

    /**
     * 是否为GET请求
     *
     * @return
     */
    protected boolean isGet() {
        String method = getRequest().getMethod();
        return "GET".equalsIgnoreCase(method);
    }

    /**
     * 获取网站路径-Context
     *
     * @return
     */
    protected String getContextPath() {
        return getRequest().getContextPath();
    }


    /**
     * 获取String参数
     *
     * @param name
     * @return
     */
    protected String getParameter(String name) {
        return getRequest().getParameter(name);
    }

    /**
     * 获取String参数，带默认值
     *
     * @param name
     * @param defaultValue
     * @return
     */
    protected String getParameter(String name, String defaultValue) {
        String value = getRequest().getParameter(name);
        if (value == null) return defaultValue;
        else return defaultValue;
    }

    /**
     * 获取Number型参数
     *
     * @param name
     * @param defaultValue
     * @return
     */
    protected <T extends Number> T getParameter(Class<T> targetNumberClass, String name, T defaultValue) {
        Object value = getRequest().getParameter(name);
        if (value == null)
            return defaultValue;
        else
            return NumberUtils.parseNumber(value.toString(), targetNumberClass);
    }

    /**
     * 获取Number型参数
     *
     * @param name
     * @return
     */
    protected <T extends Number> T getParameter(Class<T> targetNumberClass, String name) {
        return getParameter(targetNumberClass, name, null);
    }


    /**
     * 传参至页面
     *
     * @param key
     * @param value
     */
    protected void setAttribute(String key, Object value) {
        getRequest().setAttribute(key, value);
    }


    /**
     * 设置session值
     *
     * @param key
     * @param value
     */
    protected void setSessionAttribute(String key, Object value) {
        getRequest().getSession().setAttribute(key, value);
    }

    /**
     * 获取session中的值
     *
     * @param key
     * @return
     */
    protected Object getSessionAttribute(String key) {
        return getRequest().getSession().getAttribute(key);
    }
}
