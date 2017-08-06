package org.templateproject.oauth2.config;

import com.alibaba.druid.pool.DruidDataSource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import javax.sql.DataSource;

/**
 * druid数据源配置
 * Created by Wuwenbin on 2017/7/11.
 */
@Configuration
@PropertySource("classpath:h2.properties")
@ConfigurationProperties(prefix = "spring.datasource.h2")
public class DruidConfig {

        private String driverClassName;
        private String url;
        private String username;
        private String password;
        private int initialSize;
        private int minIdle;
        private int maxActive;
        private long maxWait;
        private long timeBetweenEvictionRunsMillis;
        private long minEvictableIdleTimeMillis;
        private String validationQuery;
        private boolean testWhileIdle;
        private boolean testOnBorrow;
        private boolean testOnReturn;
        private boolean poolPreparedStatements;
        private int maxPoolPreparedStatementPerConnectionSize;
        private String filters;
        private String connectionProperties;
        private boolean useGlobalDataSourceStat;


        @Bean(initMethod = "init", destroyMethod = "close")
        public DruidDataSource dataSource() throws Exception {
                DruidDataSource dds = new DruidDataSource();
                dds.setUrl(url);
                dds.setDriverClassName(driverClassName);
                dds.setUsername(username);
                dds.setPassword(password);
                dds.setInitialSize(initialSize);
                dds.setMinIdle(minIdle);
                dds.setMaxActive(maxActive);
                dds.setMaxWait(maxWait);
                dds.setTimeBetweenEvictionRunsMillis(timeBetweenEvictionRunsMillis);
                dds.setMinEvictableIdleTimeMillis(minEvictableIdleTimeMillis);
                dds.setValidationQuery(validationQuery);
                dds.setTestWhileIdle(testWhileIdle);
                dds.setTestOnBorrow(testOnBorrow);
                dds.setTestOnReturn(testOnReturn);
                dds.setPoolPreparedStatements(poolPreparedStatements);
                dds.setMaxPoolPreparedStatementPerConnectionSize(maxPoolPreparedStatementPerConnectionSize);
                dds.setFilters(filters);
                dds.setConnectionProperties(connectionProperties);
                dds.setUseGlobalDataSourceStat(useGlobalDataSourceStat);
                return dds;
        }


        public String getDriverClassName() {
                return driverClassName;
        }

        public void setDriverClassName(String driverClassName) {
                this.driverClassName = driverClassName;
        }

        public String getUrl() {
                return url;
        }

        public void setUrl(String url) {
                this.url = url;
        }

        public String getUsername() {
                return username;
        }

        public void setUsername(String username) {
                this.username = username;
        }

        public String getPassword() {
                return password;
        }

        public void setPassword(String password) {
                this.password = password;
        }

        public int getInitialSize() {
                return initialSize;
        }

        public void setInitialSize(int initialSize) {
                this.initialSize = initialSize;
        }

        public int getMinIdle() {
                return minIdle;
        }

        public void setMinIdle(int minIdle) {
                this.minIdle = minIdle;
        }

        public int getMaxActive() {
                return maxActive;
        }

        public void setMaxActive(int maxActive) {
                this.maxActive = maxActive;
        }

        public long getMaxWait() {
                return maxWait;
        }

        public void setMaxWait(long maxWait) {
                this.maxWait = maxWait;
        }

        public long getTimeBetweenEvictionRunsMillis() {
                return timeBetweenEvictionRunsMillis;
        }

        public void setTimeBetweenEvictionRunsMillis(long timeBetweenEvictionRunsMillis) {
                this.timeBetweenEvictionRunsMillis = timeBetweenEvictionRunsMillis;
        }

        public long getMinEvictableIdleTimeMillis() {
                return minEvictableIdleTimeMillis;
        }

        public void setMinEvictableIdleTimeMillis(long minEvictableIdleTimeMillis) {
                this.minEvictableIdleTimeMillis = minEvictableIdleTimeMillis;
        }

        public String getValidationQuery() {
                return validationQuery;
        }

        public void setValidationQuery(String validationQuery) {
                this.validationQuery = validationQuery;
        }

        public boolean isTestWhileIdle() {
                return testWhileIdle;
        }

        public void setTestWhileIdle(boolean testWhileIdle) {
                this.testWhileIdle = testWhileIdle;
        }

        public boolean isTestOnBorrow() {
                return testOnBorrow;
        }

        public void setTestOnBorrow(boolean testOnBorrow) {
                this.testOnBorrow = testOnBorrow;
        }

        public boolean isTestOnReturn() {
                return testOnReturn;
        }

        public void setTestOnReturn(boolean testOnReturn) {
                this.testOnReturn = testOnReturn;
        }

        public boolean isPoolPreparedStatements() {
                return poolPreparedStatements;
        }

        public void setPoolPreparedStatements(boolean poolPreparedStatements) {
                this.poolPreparedStatements = poolPreparedStatements;
        }

        public int getMaxPoolPreparedStatementPerConnectionSize() {
                return maxPoolPreparedStatementPerConnectionSize;
        }

        public void setMaxPoolPreparedStatementPerConnectionSize(int maxPoolPreparedStatementPerConnectionSize) {
                this.maxPoolPreparedStatementPerConnectionSize = maxPoolPreparedStatementPerConnectionSize;
        }

        public String getFilters() {
                return filters;
        }

        public void setFilters(String filters) {
                this.filters = filters;
        }

        public String getConnectionProperties() {
                return connectionProperties;
        }

        public void setConnectionProperties(String connectionProperties) {
                this.connectionProperties = connectionProperties;
        }

        public boolean isUseGlobalDataSourceStat() {
                return useGlobalDataSourceStat;
        }

        public void setUseGlobalDataSourceStat(boolean useGlobalDataSourceStat) {
                this.useGlobalDataSourceStat = useGlobalDataSourceStat;
        }
}
