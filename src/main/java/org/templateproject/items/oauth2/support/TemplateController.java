package org.templateproject.items.oauth2.support;

import org.templateproject.items.oauth2.support.controller.MethodBootController;
import org.templateproject.items.oauth2.support.pojo.bo.SelectBO;

import java.util.*;

/**
 * 基础控制类
 * Created by Wuwenbin on 2017/7/12.
 */
public class TemplateController extends MethodBootController {

    /**
     * 在没有勾选框checkbox多选的情况下，可以将{@code Map<String,String[]>}转为{@code Map<String,String>}
     *
     * @param requestWebMap 请求的web map
     * @return 普通java map
     */
    public HashMap arrayMapToStringMap(Map<String, String[]> requestWebMap) {
        Iterator<Map.Entry<String, String[]>> iterator = requestWebMap.entrySet().iterator();
        HashMap map;
        String key;
        String val;
        for (map = new HashMap(); iterator.hasNext(); //noinspection unchecked
             map.put(key, val)) {
            Map.Entry entry = iterator.next();
            key = entry.getKey().toString();
            Object value = entry.getValue();
            if (value instanceof String[]) {
                String[] strings = ((String[]) value);
                val = strings[0];
            } else {
                val = value.toString();
            }
        }
        return map;
    }

    /**
     * 转化为前端的select下拉框选择的对象
     *
     * @param selectBOS
     * @return
     */
    protected Map<Object, Object> searchSelect(List<SelectBO> selectBOS) {
        Map<Object, Object> map = new LinkedHashMap<>();
        for (SelectBO selectBO : selectBOS) {
            map.put(selectBO.getValue(), selectBO.getText());
        }
        return map;
    }
}
