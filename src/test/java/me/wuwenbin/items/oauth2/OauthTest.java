package me.wuwenbin.items.oauth2;

import org.templateproject.lang.TP;

import java.lang.reflect.InvocationTargetException;

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

        System.out.println(TP.webDate.string2Date("2017-11-01 09:00:00", "yyyy-MM-dd HH:mm:ss"));
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

}
