package me.wuwenbin.items.oauth2.support.aop;

import me.wuwenbin.items.oauth2.support.annotation.TemplateCache;
import me.wuwenbin.items.oauth2.util.CacheUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.util.concurrent.atomic.AtomicReference;

/**
 * created by Wuwenbin on 2017/9/12 at 23:53
 */
@Aspect
@Component
public class TemplateCacheAspect {

    @Pointcut("@annotation(me.wuwenbin.items.oauth2.support.annotation.TemplateCache)")
    public void templateCache() {
    }

    @Around("templateCache()")
    public Object cacheOrDatabase(ProceedingJoinPoint joinPoint) throws Throwable {
        Class clazz = joinPoint.getTarget().getClass();
        String methodName = joinPoint.getSignature().getName();
        Class[] argClass = ((MethodSignature) joinPoint.getSignature()).getParameterTypes();
        //noinspection unchecked
        Method method = clazz.getMethod(methodName, argClass);
        String preKey = method.getAnnotation(TemplateCache.class).value();
        AtomicReference<StringBuilder> cacheKey = new AtomicReference<>(new StringBuilder(preKey.concat("::")));
        for (int i = 0; i < joinPoint.getArgs().length; i++) {
            cacheKey.get().append(joinPoint.getArgs()[i]).append(":");
        }
        String cachedKey = cacheKey.toString().substring(0, cacheKey.toString().length() - 1);
        String cacheName = method.getAnnotation(TemplateCache.class).cacheName();
        Object cachedObject = CacheUtils.get(cacheName, cachedKey);
        if (cachedObject != null) {
            return cachedObject;
        } else {
            Object rvt;
//                if (joinPoint.getArgs().length > 0)
            rvt = joinPoint.proceed(joinPoint.getArgs());
//                else
//                    rvt = joinPoint.proceed();
            CacheUtils.put(cacheName, cachedKey, rvt);
            return rvt;
        }
    }

}
