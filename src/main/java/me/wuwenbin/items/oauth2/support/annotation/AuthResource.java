package me.wuwenbin.items.oauth2.support.annotation;

import java.lang.annotation.*;

/**
 * created by Wuwenbin on 2017/9/7 at 22:14
 */
@Inherited
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface AuthResource {

    String name() default "";

    boolean enabled() default true;

    int orderIndex() default 0;

    String remark() default "";

    String systemCode() default "";


}
