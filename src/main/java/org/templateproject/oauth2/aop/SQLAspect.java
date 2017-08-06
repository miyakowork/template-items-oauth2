package org.templateproject.oauth2.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.templateproject.oauth2.aop.support.SQLSeat;
import org.templateproject.oauth2.support.pojo.SqlMap;

/**
 * 获取service方法对应xml中的sql，独立出来方便更改sql
 * 方法名必须和xml中的tag标签一致
 * 放入方法中参数类型为 SQLSeat
 * @see SQLSeat
 * created by Wuwenbin on 2017/8/5 at 17:13
 */
@Aspect
@Component
public class SQLAspect {

        private static final Logger LOGGER = LoggerFactory.getLogger(SQLAspect.class);
        private SqlMap sqlMap;

        @Autowired
        public void setSqlMap(SqlMap sqlMap) {
                this.sqlMap = sqlMap;
        }

        @Pointcut("@annotation(org.templateproject.oauth2.aop.annotation.SQL)")
        private void sql() {
        }

        @Around("sql()")
        public Object sqlStatement(ProceedingJoinPoint pjp) throws Throwable {
                Object[] args = pjp.getArgs();
                for (Object obj : args) {
                        if (obj instanceof SQLSeat) {
                                Class clazz = pjp.getTarget().getClass();
                                String sqlId = pjp.getSignature().getName();
                                LOGGER.info("className: [{}]，methodName: [{}]  ", clazz, sqlId);
                                //noinspection unchecked
                                String sql = sqlMap.findSqlById(sqlId, clazz);
                                ((SQLSeat) obj).setSql(sql);
                        }
                }
                return pjp.proceed(args);
        }
}
