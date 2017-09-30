package me.wuwenbin.items.oauth2.config;

import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * created by Wuwenbin on 2017/9/27 at 11:30
 */
@Configuration
public class ShiroCacheConfig {

    @Bean
    public EhCacheManager shiroEhCacheManager() {
        EhCacheManager ehCacheManager = new EhCacheManager();
        ehCacheManager.setCacheManagerConfigFile("classpath:ehcache/ehcache.xml");
        return ehCacheManager;
    }
}
