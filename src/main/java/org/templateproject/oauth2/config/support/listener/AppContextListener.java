package org.templateproject.oauth2.config.support.listener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.templateproject.dao.ancestor.AncestorDao;
import org.templateproject.dao.factory.DaoFactory;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Created by Wuwenbin on 2017/7/25.
 */
@Component
public class AppContextListener implements ServletContextListener {

    private static final Logger LOGGER = LoggerFactory.getLogger(AppContextListener.class);
    private AncestorDao dao;

    @Autowired
    public void setDao(DaoFactory daoFactory) {
        this.dao = daoFactory.dynamicDao;
    }

    /**
     * 本项目启动时候做的一些操作，此处做一些初始化数据的一些操作
     * 同时重要的是把所有的session会话给删掉
     *
     * @param servletContextEvent servletContextEvent
     */
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        LOGGER.info("------ 项目启动 ------");
        String sql = "DELETE FROM T_OAUTH_SESSION";
        try {
            int n = dao.executeArray(sql);
            LOGGER.info("---  删除所有数据库无效session会话，删除session会话[{}]条 ---", n);
        } catch (Exception e) {
            LOGGER.error("--- 删除无效session会话过程中出现异常，异常信息：{} ---" + e.getMessage());
        }
        LOGGER.info("------ 启动即将完成 ------");
    }

    /**
     * 当然，此处就是做一些项目销毁时，一些的操作，
     * 注意：此处的销毁指的是程序的正常停止，而不是杀进程等之类的强制性操作
     *
     * @param servletContextEvent servletContextEvent
     */
    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        LOGGER.info("------ 项目销毁中 ------");
        String sql = "DELETE FROM T_OAUTH_SESSION";
        try {
            int n = dao.executeArray(sql);
            LOGGER.info("---  删除所有数据库无效session会话，删除session会话[{}]条 ---", n);
        } catch (Exception e) {
            LOGGER.error("--- 删除无效session会话过程中出现异常，异常信息：{} ---" + e.getMessage());
        }
        LOGGER.info("------ 项目已销毁 ------");
    }
}
