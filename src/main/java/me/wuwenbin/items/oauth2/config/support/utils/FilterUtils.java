package me.wuwenbin.items.oauth2.config.support.utils;

import me.wuwenbin.json.JoddJsonUtils;
import org.templateproject.pojo.response.R;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * created by Wuwenbin on 2017/8/10 at 15:31
 */
public class FilterUtils {

    /**
     * 如果是ajax请求返回的处理信息
     *
     * @param response
     * @param ajaxMessage
     * @throws IOException
     */
    public static void ajaxControl(HttpServletResponse response, String ajaxMessage) throws IOException {
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String json = JoddJsonUtils.serializer().include("code", "message").serialize(R.custom(301, ajaxMessage));
        out.println(json);
        out.flush();
        out.close();
    }
}
