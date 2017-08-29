package me.wuwenbin.items.oauth2.util;

import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * created by Wuwenbin on 2017/8/10 at 14:32
 */
public class HttpUtils {

    /**
     * 获取IP地址
     * <p>
     * 使用nginx等反向代理软件， 则不能通过request.getRemoteAddr()获取IP地址
     * 如果使用了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP地址，X-Forwarded-For中第一个非unknown的有效IP字符串，则为真实IP地址
     *
     * @return
     */
    public static String getRemoteAddr(HttpServletRequest request) {
        String remoteAddress;
        try {
            remoteAddress = request.getHeader("x-forwarded-for");
            if (StringUtils.isEmpty(remoteAddress) || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = request.getHeader("Proxy-Client-IP");
            }
            if (StringUtils.isEmpty(remoteAddress) || remoteAddress.length() == 0 || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = request.getHeader("WL-Proxy-Client-IP");
            }
            if (StringUtils.isEmpty(remoteAddress) || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = request.getHeader("HTTP_CLIENT_IP");
            }
            if (StringUtils.isEmpty(remoteAddress) || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = request.getHeader("HTTP_X_FORWARDED_FOR");
            }
            if (StringUtils.isEmpty(remoteAddress) || "unknown".equalsIgnoreCase(remoteAddress)) {
                remoteAddress = request.getRemoteAddr();
            }
        } catch (Exception e) {
            remoteAddress = request.getRemoteAddr();
        }
        return remoteAddress;
    }

    public static boolean isAjax(HttpServletRequest request) {
        String header = request.getHeader("X-Requested-With");
        return "XMLHttpRequest".equalsIgnoreCase(header);
    }

    public static boolean isJson(HttpServletRequest request) {
        String headerAccept = request.getHeader("Accept");
        return !StringUtils.isEmpty(headerAccept) && headerAccept.contains("application/json");
    }

    public static boolean isRouter(HttpServletRequest request) {
        String headerAccept = request.getHeader("Accept");
        return !StringUtils.isEmpty(headerAccept) && headerAccept.contains("text/html") && !isJson(request) && isAjax(request) && isGet(request);
    }

    public static boolean isGet(HttpServletRequest request) {
        String method = request.getMethod();
        return StringUtils.equalsIgnoreCase("GET", method);
    }
}
