package org.templateproject.oauth2.service;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.oauth2.entity.OauthUserLoginLog;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.pojo.bo.LogBO;
import org.templateproject.oauth2.support.pojo.vo.LoginLogVO;
import org.templateproject.pojo.page.Page;


/**
 * 用户登录日志
 * Created by Administrator on 2017/7/13/013.
 */
@Service
@Transactional
public class LogService extends SimpleBaseCrudService<OauthUserLoginLog, Integer> {

    /**
     * 查找分页信息
     *
     * @param page  分页信息
     * @param logBO 搜索对象
     * @return 分页对象信息结果
     */
    public Page<LoginLogVO> findPage(Page<LoginLogVO> page, LogBO logBO) {
        String sql = "SELECT toull.*,tou.username FROM T_OAUTH_USER_LOGIN_LOG toull LEFT JOIN T_OAUTH_USER tou ON tou.ID=toull.USER_ID";
        return findPagination(page, LoginLogVO.class, sql, logBO);
    }

    /**
     * 记录用户登录日志
     *
     * @param userId      用户id
     * @param lastLoginIp 用户登录ip
     * @return 日志条数
     * @throws Exception 插入登录日志时候的异常
     */
    public int traceLog(int userId, String lastLoginIp) throws Exception {
        String sql = "INSERT INTO T_OAUTH_USER_LOGIN_LOG(USER_ID,LAST_LOGIN_DATE,LAST_LOGIN_IP) VALUES(?,current_timestamp(),?)";
        return h2Dao.executeArray(sql, userId, lastLoginIp);
    }


}
