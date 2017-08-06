package org.templateproject.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.oauth2.aop.annotation.SQL;
import org.templateproject.oauth2.aop.support.SQLSeat;
import org.templateproject.oauth2.entity.OauthSystemModule;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.oauth2.support.pojo.bo.SystemModuleBo;
import org.templateproject.oauth2.support.pojo.vo.SystemModuleVO;
import org.templateproject.pojo.page.Page;

import java.util.List;

/**
 * Created by zhangteng on 2017/7/14.
 * 系统模块表 service
 */
@Service
@Transactional
@SqlMapper("systemModule")
public class SystemModuleService extends SimpleBaseCrudService<OauthSystemModule, Integer> {

        /**
         * 查询systemModule当前页面数据
         *
         * @param page           page
         * @param systemModuleBo 查询控件参数对象
         * @return page
         */
        @SQL
        public Page<SystemModuleVO> findSystemModulePage(SQLSeat sqlSeat, Page<SystemModuleVO> page, SystemModuleBo systemModuleBo) {
                return findPagination(page, SystemModuleVO.class, sqlSeat.getSql(), systemModuleBo);
        }

        /**
         * 表面上是删除其实是更新一个enabled字段为0
         *
         * @param ids ids
         * @throws Exception e
         */
        @SQL
        public void deleteModules(SQLSeat sqlSeat, String[] ids) throws Exception {
                executeBatch(sqlSeat.getSql(), "id", ids);
        }

        /**
         * @return 查找所有可用的系统模块
         */
        @SQL
        public List<OauthSystemModule> findAllEnabledSystemModules(SQLSeat sqlSeat) {
                return h2Dao.findListBeanByArray(sqlSeat.getSql(), OauthSystemModule.class);
        }


        /**
         * 查询是否已经有存在的system code
         *
         * @param systemCode 系统代码
         * @return 是否存在
         */
        @SQL
        public boolean isExistSystemCode(SQLSeat sqlSeat, String systemCode) {
                long cnt = h2Dao.queryNumberByArray(sqlSeat.getSql(), Long.class, systemCode);
                return cnt > 0;
        }

}
