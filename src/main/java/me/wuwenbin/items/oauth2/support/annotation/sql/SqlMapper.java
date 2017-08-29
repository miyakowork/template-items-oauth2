package me.wuwenbin.items.oauth2.support.annotation.sql;

import java.lang.annotation.*;

/**
 * 每个service对应的SQL mapper对应的路径文件名
 * 默认classpath:sql
 * created by Wuwenbin on 2017/8/5 at 14:09
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SqlMapper {

    String value();
}
