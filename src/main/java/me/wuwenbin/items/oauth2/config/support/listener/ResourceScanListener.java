package me.wuwenbin.items.oauth2.config.support.listener;

import me.wuwenbin.items.oauth2.config.OauthConfig;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.aop.framework.AopProxyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.dao.ancestor.AncestorDao;
import org.templateproject.dao.factory.DaoFactory;

import java.lang.reflect.Method;
import java.util.Map;

/**
 * 扫描资源不需要手工去添加，自动执行扫描添加至数据库
 * created by Wuwenbin on 2017/9/7 at 22:04
 */
@Component
public class ResourceScanListener implements ApplicationListener<ContextRefreshedEvent> {

    private final OauthConfig oauthConfig;
    private final AncestorDao dao;

    @Autowired
    public ResourceScanListener(OauthConfig oauthConfig, DaoFactory daoFactory) {
        this.oauthConfig = oauthConfig;
        this.dao = daoFactory.defaultDao;
    }

    /**
     * Handle an application event.
     *
     * @param event the event to respond to
     */
    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        if (oauthConfig.getInit() == 1) {
            String init = "DELETE FROM t_oauth_resource WHERE system_code = ?";
            try {
                dao.executeArray(init, oauthConfig.getSystemModuleCode());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (oauthConfig.getScan() == 1) {
            if (event.getApplicationContext().getParent() == null) {
                Map<String, Object> beans = event.getApplicationContext().getBeansWithAnnotation(Controller.class);
                beans.putAll(event.getApplicationContext().getBeansWithAnnotation(RestController.class));
                for (Object bean : beans.values()) {
                    //此处的ultimateTargetClass方法是用来获取被spring的cglib代理类的原始类，这样才能获取到类上面的 注解（因为cglib代理类的原理是继承原始的类成成一个子类来操作）
                    if (AopProxyUtils.ultimateTargetClass(bean).isAnnotationPresent(RestController.class) || AopProxyUtils.ultimateTargetClass(bean).isAnnotationPresent(Controller.class)) {
                        String[] prefixes;
                        if (AopProxyUtils.ultimateTargetClass(bean).isAnnotationPresent(RequestMapping.class)) {
                            prefixes = AopProxyUtils.ultimateTargetClass(bean).getAnnotation(RequestMapping.class).value();
                        } else {
                            prefixes = new String[]{""};
                        }
                        prefixes = prefixes.length == 0 ? new String[]{""} : prefixes;
                        for (String prefix : prefixes) {
                            Method[] methods = AopProxyUtils.ultimateTargetClass(bean).getDeclaredMethods();
                            for (Method method : methods) {
                                String[] lasts;
                                if (method.isAnnotationPresent(RequestMapping.class)) {
                                    lasts = method.getAnnotation(RequestMapping.class).value();
                                } else {
                                    lasts = new String[]{""};
                                }
                                lasts = lasts.length == 0 ? new String[]{""} : lasts;
                                for (String last : lasts) {
                                    last = last.startsWith("/") ? last : "/".concat(last);
                                    String url = (prefix.startsWith("/") ? prefix : "/".concat(prefix)).concat(last.equals("/") ? "" : last);
                                    if (method.isAnnotationPresent(AuthResource.class)) {
                                        String name = method.getAnnotation(AuthResource.class).name();
                                        boolean enabled = method.getAnnotation(AuthResource.class).enabled();
                                        int orderIndex = method.getAnnotation(AuthResource.class).orderIndex();
                                        String systemCode = method.getAnnotation(AuthResource.class).systemCode();
                                        systemCode = StringUtils.isEmpty(systemCode) ? oauthConfig.getSystemModuleCode() : systemCode;
                                        String remark = method.getAnnotation(AuthResource.class).remark();

                                        if (method.isAnnotationPresent(RequiresPermissions.class)) {
                                            String[] permissionMarks = method.getAnnotation(RequiresPermissions.class).value();
                                            for (String permissionMark : permissionMarks) {
                                                String exist = "SELECT count(0) FROM t_oauth_resource WHERE url = ?";
                                                long cnt = dao.queryNumberByArray(exist, Long.class, url);
                                                if (cnt == 0) {
                                                    String sql = "INSERT INTO t_oauth_resource(name,url,permission_mark,enabled,order_index,system_code,remark) VALUES (?,?,?,?,?,?,?)";
                                                    try {
                                                        dao.executeArray(sql, name, url, permissionMark, enabled, orderIndex, systemCode, remark);
                                                    } catch (Exception e) {
                                                        e.printStackTrace();
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
