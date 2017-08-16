package org.templateproject.items.oauth2.util;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.templateproject.items.oauth2.constant.CacheConsts;


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
    public static <V> V get(String key) {
        return get(SYS_CACHE, key);
    }

    /**
     * 写入SYS_CACHE缓存
     *
     * @param key
     * @return
     */
    public static <V> void put(String key, V value) {
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
    public static <V> V get(String cacheName, String key) {
        Cache<String, V> cache = getCache(cacheName);
        return cache.get(key);
    }

    /**
     * 写入缓存
     *
     * @param cacheName
     * @param key
     * @param value
     */
    public static <V> void put(String cacheName, String key, V value) {
        Cache<String, V> cache = getCache(cacheName);
        cache.put(key, value);
    }

    /**
     * 从缓存中移除
     *
     * @param cacheName
     * @param key
     */
    public static void remove(String cacheName, String key) {
        getCache(cacheName).remove(key);
    }

    /**
     * 更新缓存
     *
     * @param cacheName
     * @param key
     * @param value
     * @param <V>
     */
    public static <V> void update(String cacheName, String key, V value) {
        Cache<String, V> cache = getCache(cacheName);
        cache.remove(key);
        cache.put(key, value);
    }

    /**
     * 获得一个Cache
     *
     * @param cacheName
     * @return
     */
    private static <K, V> Cache<K, V> getCache(String cacheName) {
        return cacheManager.getCache(cacheName);
    }

}
