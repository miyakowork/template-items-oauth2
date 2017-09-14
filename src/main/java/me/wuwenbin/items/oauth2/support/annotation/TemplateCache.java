package me.wuwenbin.items.oauth2.support.annotation;

import java.lang.annotation.*;

/**
 * created by Wuwenbin on 2017/9/12 at 17:48
 */
@Inherited
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface TemplateCache {

    /**
     * 缓存ket的前缀
     *
     * @return
     */
    String value() default "";

    /**
     * 放入缓存的缓存名称key
     *
     * @return
     */
    String cacheName();
}
