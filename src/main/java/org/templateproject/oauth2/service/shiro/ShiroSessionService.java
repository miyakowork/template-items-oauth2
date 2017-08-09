package org.templateproject.oauth2.service.shiro;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.oauth2.constant.ServiceConsts;
import org.templateproject.oauth2.entity.shiro.ShiroSession;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.pojo.bo.SessionBO;
import org.templateproject.pojo.page.Page;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;


/**
 * shiroSession服务处理类
 * Created by Wuwenbin on 2017/7/19.
 */
@Service
@Transactional
public class ShiroSessionService extends SimpleBaseCrudService<ShiroSession, Integer> {

    /**
     * 根据用户名查找session
     *
     * @param page      page对象
     * @param sessionBO 搜索对象
     * @return 查询的页面结果信息
     */
    public Page<ShiroSession> findPage(Page<ShiroSession> page, SessionBO sessionBO) {
        String sql = "SELECT * FROM T_OAUTH_SESSION";
        return findPagination(page, ShiroSession.class, sql, sessionBO);
    }

    /**
     * 通过id查找session
     *
     * @param sessionId session id
     * @return session对象
     */
    public ShiroSession fetchSessionById(String sessionId) {
        String sql = "SELECT * FROM T_OAUTH_SESSION WHERE SESSION_ID = ?";
        return h2Dao.findBeanByArray(sql, ShiroSession.class, sessionId);
    }

    /**
     * 更新session
     *
     * @param shiroSession session对象
     * @return 更新影响条数
     * @throws Exception 更新时出现的异常
     */
    public int updateShiroSession(ShiroSession shiroSession) throws Exception {
        String sql = "UPDATE T_OAUTH_SESSION SET SESSION_BASE64 = :sessionBase64,last_visit_date = :lastVisitDate,IP = :ip," +
                "UPDATE_URL = :updateUrl WHERE SESSION_ID = :sessionId";
        return h2Dao.executeBean(sql, shiroSession);
    }

    /**
     * 删除session对象
     *
     * @param sessionId session id
     * @return 删除的影响条数
     * @throws Exception 删除中出现的异常
     */
    public int deleteShiroSession(String sessionId) throws Exception {
        String sql = "DELETE FROM T_OAUTH_SESSION WHERE SESSION_ID = ?";
        return h2Dao.executeArray(sql, sessionId);
    }

    /**
     * 插入一条session记录
     *
     * @param shiroSession session对象
     * @return 插入条数
     * @throws Exception 插入发生的异常
     */
    public void insertShiroSession(ShiroSession shiroSession) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(ShiroSession.class);
        String sql = sbb.insertRoutersWithoutPk(ServiceConsts.DEFAULT_ROUTER);
        h2Dao.executeBean(sql, shiroSession);
    }


}
