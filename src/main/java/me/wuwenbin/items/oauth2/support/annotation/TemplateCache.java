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
     * @return
     */
    String value() default "";
}
