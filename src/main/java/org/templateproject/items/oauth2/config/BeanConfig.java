package org.templateproject.items.oauth2.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.templateproject.items.oauth2.support.pojo.SqlMap;

/**
 * created by Wuwenbin on 2017/8/5 at 14:15
 */
@Configuration
public class BeanConfig {

    @Bean
    public SqlMap sqlMapper() {
        SqlMap sqlMap = new SqlMap();
        sqlMap.setMapperPath("classpath:mappers");
        return sqlMap;
    }

}
