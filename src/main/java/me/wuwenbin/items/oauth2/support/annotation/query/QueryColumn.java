package me.wuwenbin.items.oauth2.support.annotation.query;

import me.wuwenbin.items.oauth2.support.enumerate.Operator;

import java.lang.annotation.*;

/**
 * Created by Wuwenbin on 2017/7/22.
 */
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface QueryColumn {


    /**
     * @return 数据库中对应的字段
     */
    String value() default "";

    /**
     * @return 该字段所在表，可为表名，亦可为表的别名
     */
    String table() default "";

    /**
     * @return 查询的时候匹配条件
     */
    Operator operation() default Operator.LIKE;
}
