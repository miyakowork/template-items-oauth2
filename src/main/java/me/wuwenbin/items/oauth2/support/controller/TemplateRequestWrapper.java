package me.wuwenbin.items.oauth2.support.controller;


import org.templateproject.lang.TP;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.util.HashMap;
import java.util.Map;

/**
 * 包装Wrapper，Xss过滤和SQL过滤
 * Created by Wuwenbin on 2017/7/12.
 */
public class TemplateRequestWrapper extends HttpServletRequestWrapper {
    /**
     * 过滤XSS脚本
     */
    private boolean filterXSS = true;

    /**
     * 过滤SQL注入
     */
    private boolean filterSQL = true;

    public TemplateRequestWrapper(HttpServletRequest request, boolean filterXSS, boolean filterSQL) {
        super(request);
        this.filterSQL = filterSQL;
        this.filterXSS = filterXSS;
    }

    public TemplateRequestWrapper(HttpServletRequest request) {
        this(request, true, true);
    }

    /**
     * 过滤参数字符串内容
     *
     * @param beforeFilter
     * @return
     */
    protected String filterParamStrings(String beforeFilter) {
        if (null == beforeFilter) return null;
        String afterFilter = beforeFilter;
        if (this.filterXSS)
            afterFilter = TP.webFireWall.stripSqlXSS(afterFilter);
        if (this.filterSQL)
            afterFilter = TP.webFireWall.stripSqlInjection(afterFilter);
        return afterFilter;
    }

    /**
     * 过滤数组内容
     *
     * @param rawValue
     * @return
     */
    protected String[] filterEntryString(String[] rawValue) {
        for (int i = 0; i < rawValue.length; i++) {
            rawValue[i] = filterParamStrings(rawValue[i]);
        }
        return rawValue;
    }

    /**
     * 过滤请求参数
     *
     * @param s
     * @return
     */
    @Override
    public String getParameter(String s) {
        return filterParamStrings(super.getParameter(s));
    }

    /**
     * 过滤请求头
     *
     * @param s
     * @return
     */
    @Override
    public String getHeader(String s) {
        return filterParamStrings(super.getHeader(s));
    }

    /**
     * 过滤Cookie内容
     *
     * @return
     */
    @Override
    public Cookie[] getCookies() {
        Cookie[] existingCookies = super.getCookies();
        if (existingCookies != null) {
            for (Cookie cookie : existingCookies) {
                cookie.setValue(filterParamStrings(cookie.getValue()));
            }
        }
        return existingCookies;
    }

    /**
     * 过滤请求参数数组内容
     *
     * @param parameter
     * @return
     */
    @Override
    public String[] getParameterValues(String parameter) {
        String[] values = super.getParameterValues(parameter);
        if (values == null) {
            return null;
        }
        int count = values.length;
        String[] encodedValues = new String[count];
        for (int i = 0; i < count; i++) {
            encodedValues[i] = filterParamStrings(values[i]);
        }
        return encodedValues;
    }

    /**
     * 过滤map内容
     *
     * @return
     */
    @Override
    public Map<String, String[]> getParameterMap() {
        Map<String, String[]> primary = super.getParameterMap();
        Map<String, String[]> result = new HashMap<>(primary.size());
        for (Map.Entry<String, String[]> entry : primary.entrySet()) {
            result.put(entry.getKey(), filterEntryString(entry.getValue()));
        }
        return result;
    }
}
