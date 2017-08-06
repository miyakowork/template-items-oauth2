package org.templateproject.oauth2.support.annotation.query;

import java.lang.annotation.*;

/**
 * 数据库中查询对应的表的名称
 * Created by Wuwenbin on 2017/7/22.
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface QueryTable {

    /**
     * @return sql语句中表名的别名，如果未定义别名，则填入表名即可
     */
    String value() default "";

}
