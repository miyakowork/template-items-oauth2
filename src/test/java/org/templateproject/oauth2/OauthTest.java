package org.templateproject.oauth2;

import org.templateproject.lang.TP;
import org.templateproject.oauth2.support.pojo.PageQueryBO;
import org.templateproject.pojo.page.Page;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Created by Wuwenbin on 2017/7/22.
 */
public class OauthTest {

    public static void main(String[] args) throws IllegalAccessException, NoSuchMethodException, InvocationTargetException {
//        OauthTest ttEst = new OauthTest();
//        SessionBO sessionBO = new SessionBO();
//        sessionBO.setIp("111.23.45.6");
//        sessionBO.setUsername("wwb");
//        sessionBO.setLimit(11);
//        sessionBO.setOffset(22);
//        sessionBO.setOrder("order");
//        sessionBO.setSort("asc");
//        Page<ShiroSession> page = new Page<>();
//        ttEst.ss(page, sessionBO);
//        Map<String, String> filterChainDefinitionMap = new HashMap<>();
//        filterChainDefinitionMap.put("/static/**", "anon");
//        filterChainDefinitionMap.put("/login/router", "anon");
//        filterChainDefinitionMap.put("/login", "anon");
//        filterChainDefinitionMap.put("/log", "authc");
//        filterChainDefinitionMap.put("/**", "forceLogout,sto,user");
//        System.out.println(getKeyByValue(filterChainDefinitionMap, "anon"));


    }
//
//    private static String getKeyByValue(Map<String, String> map, String value) {
//        String key = "";
//        Iterator it = map.entrySet().iterator();
//        while (it.hasNext()) {
//            Map.Entry entry = (Map.Entry) it.next();
//            Object obj = entry.getValue();
//            if (obj != null && obj.equals(value)) {
//                key += entry.getKey() + ",";
//            }
//        }
//        return key.substring(0, key.length() - 1);
//    }

    private <S extends PageQueryBO, T> void ss(Page<T> page, S queryBO) throws IllegalAccessException {
        Map<String, Object> params = new LinkedHashMap<>();
        Field[] fields = queryBO.getClass().getDeclaredFields();
//        System.out.println("limit:" + queryBO.getLimit());
//        System.out.println("order:" + queryBO.getOrder());
//        System.out.println("sort:" + queryBO.getSort());
//        System.out.println("offset:" + queryBO.getOffset());

        for (Field field : fields) {
            field.setAccessible(true);
            System.out.println(field.getName() + ":" + field.get(queryBO));
            if (field.get(queryBO) != null) {
                params.put(field.getName(), field.get(queryBO));
            }
//            String firstLetter = field.getName().substring(0, 1).toUpperCase(); //获得字段第一个字母大写
//            String getMethodName = "get" + firstLetter + field.getName().substring(1); //转换成字段的get方法
        }
//        System.out.println("params:" + params);
        page.setPageNo(queryBO.pageNo());
        page.setPageSize(queryBO.getLimit());
        page.setOrderDirection(queryBO.getSort());
        page.setOrderField(queryBO.getOrder());

        StringBuilder sql = new StringBuilder("SELECT * FROM T_OAUTH_USER WHERE 1=1");

        for (String key : params.keySet()) {
            sql.append(" AND `".concat(key).concat("` LIKE :").concat(key));
        }

        if (TP.stringhelper.isNotEmpty(page.getOrderField())) {
            String orderDirection = TP.stringhelper.isNotEmpty(page.getOrderDirection()) ? page.getOrderDirection() : "asc";
            sql.append(TP.placeholder.format(" ORDER BY `{}` {}", page.getOrderField(), orderDirection));
        }

        params.forEach((key, value) -> System.out.println(key + ":" + value));
        System.out.println(sql);


    }
}
