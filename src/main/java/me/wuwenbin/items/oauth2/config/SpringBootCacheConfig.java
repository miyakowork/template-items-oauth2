package me.wuwenbin.items.oauth2.config;

import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.ehcache.EhCacheCacheManager;
import org.springframework.cache.ehcache.EhCacheManagerFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

/**
 * spring-cache.xml缓存的java方式配置
 * Created by wuwenbin on 2017/5/22.
 */
@Configuration
@EnableCaching
public class SpringBootCacheConfig {


    @Bean
    public EhCacheCacheManager cacheManager(EhCacheManagerFactoryBean factoryBean) {
        return new EhCacheCacheManager(factoryBean.getObject());
    }

    @Bean
    public EhCacheManagerFactoryBean cacheManagerFactory() {
        EhCacheManagerFactoryBean ehCacheManagerFactoryBean = new EhCacheManagerFactoryBean();
        ehCacheManagerFactoryBean.setConfigLocation(new ClassPathResource("ehcache/ehcache.xml"));
        ehCacheManagerFactoryBean.setShared(true);
        return ehCacheManagerFactoryBean;
    }

}

