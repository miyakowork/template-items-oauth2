package me.wuwenbin.items.oauth2.util;

import me.wuwenbin.items.oauth2.constant.CacheConsts;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;


/**
 * Cache工具类
 */
public class CacheUtils implements CacheConsts {

    private static CacheManager cacheManager = SpringUtils.getBean("cacheManager");

    /**
     * 获取SYS_CACHE缓存
     *
     * @param key
     * @return
     */
    public static Object get(String key) {
        return get(SYS_CACHE, key);
    }

    /**
     * 写入SYS_CACHE缓存
     *
     * @param key
     * @return
     */
    public static void put(String key, Object value) {
        put(SYS_CACHE, key, value);
    }

    /**
     * 从SYS_CACHE缓存中移除
     *
     * @param key
     * @return
     */
    public static void remove(String key) {
        remove(SYS_CACHE, key);
    }

    /**
     * 获取缓存
     *
     * @param cacheName
     * @param key
     * @return
     */
    public static Object get(String cacheName, String key) {
        Cache cache = getCache(cacheName);
        return cache.get(key);
    }

    /**
     * 写入缓存
     *
     * @param cacheName
     * @param key
     * @param value
     */
    public static void put(String cacheName, String key, Object value) {
        Cache cache = getCache(cacheName);
        cache.put(key, value);
    }

    /**
     * 从缓存中移除
     *
     * @param cacheName
     * @param key
     */
    public static void remove(String cacheName, String key) {
        getCache(cacheName).evict(key);
    }

    /**
     * 更新缓存
     *
     * @param cacheName
     * @param key
     * @param value
     */
    public static void update(String cacheName, String key, Object value) {
        Cache cache = getCache(cacheName);
        cache.evict(key);
        cache.put(key, value);
    }

    /**
     * 获得一个Cache
     *
     * @param cacheName
     * @return
     */
    private static Cache getCache(String cacheName) {
        return cacheManager.getCache(cacheName);
    }

}
