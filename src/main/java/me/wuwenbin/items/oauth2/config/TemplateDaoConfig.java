package me.wuwenbin.items.oauth2.config;

import com.alibaba.druid.pool.DruidDataSource;
import me.wuwenbin.items.oauth2.constant.ConfigConsts;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.templateproject.dao.factory.DaoFactory;
import org.templateproject.dao.factory.business.DataSourceX;
import org.templateproject.dao.factory.business.DbType;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * dao类模块配置类
 * Created by Wuwenbin on 2017/7/11.
 */
@Configuration
public class TemplateDaoConfig implements ConfigConsts {

    @Bean
    public DataSourceX dataSourceX(DruidDataSource dataSource) {
        DataSourceX dataSourceX = new DataSourceX();
        dataSourceX.setDataSource(dataSource);
        dataSourceX.setInitDbType(DbType.Mysql);
        return dataSourceX;
    }

    @Bean
    public DaoFactory daoFactory(DataSourceX dataSourceX) {
        DaoFactory daoFactory = new DaoFactory();
        Map<String, DataSourceX> multiDao = new ConcurrentHashMap<>();
        multiDao.put(DEFAULT_DAO, dataSourceX);
        daoFactory.setDataSourceMap(multiDao);
        daoFactory.setDefaultDao(dataSourceX);
        return daoFactory;
    }


}
