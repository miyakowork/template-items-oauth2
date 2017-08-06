package org.templateproject.oauth2.service;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.lang.TP;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ServiceConsts;
import org.templateproject.oauth2.entity.OauthSystemParam;
import org.templateproject.oauth2.service.base.AbstractBaseCrudService;
import org.templateproject.oauth2.support.pojo.bo.SysParamBo;
import org.templateproject.oauth2.support.pojo.vo.SystemParamVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;


@Service
@Transactional
public class SystemParamService extends AbstractBaseCrudService<OauthSystemParam, Integer> {

    /**
     * 模糊查询
     *
     * @param page
     * @param sysParamBo
     * @return
     */
    public Page<SystemParamVO> findPageByName(Page<SystemParamVO> page, SysParamBo sysParamBo) {
        //pMap 用来精确查询传值
        Map<String, Object> pMap = new HashMap<>();
        //查询
        String sql = "SELECT tosp.*,tou1.username as create_user_name ,tou2.username as update_user_name FROM " +
                " T_OAUTH_SYSTEM_PARAM tosp ,t_oauth_user tou1,t_oauth_user tou2 " +
                " where tosp.CREATE_USER=tou1.id and tosp.update_user =tou2.id ";
        String orderSQL = "";
        //先组装order部分
        if (StringUtils.isNotEmpty(page.getOrderField()) && StringUtils.isNotEmpty(page.getOrderDirection())) {
            orderSQL = TP.placeholder.format(" ORDER BY {} {}", page.getOrderField(), page.getOrderDirection());
        }
        //判断是否可用
        if (sysParamBo.getSelectEnabled() != null) {
            sql += " AND tosp.enabled =" + sysParamBo.getSelectEnabled() + " ";
        }
        //如果Name不为空 模糊查询
        if (StringUtils.isNotEmpty(sysParamBo.getName())) {
            sql += "AND tosp.name LIKE :name ";
            pMap.put("name", "%" + sysParamBo.getName() + "%");
        }
        //如果值不为空 模糊查询
        if (StringUtils.isNotEmpty(sysParamBo.getValue())) {
            sql += "AND tosp.value LIKE :value ";
            pMap.put("value", "%" + sysParamBo.getValue() + "%");
        }
        sql += orderSQL;

        return findPage(page, SystemParamVO.class, sql, pMap);
    }

    /**
     * 添加对象
     *
     * @param oauthSystemParam
     * @return
     * @throws Exception
     */
    public boolean save(OauthSystemParam oauthSystemParam) throws Exception {

        SQLBeanBuilder builder = SQLFactory.builder(OauthSystemParam.class);
        //插入语句
        String sql = builder.insertRoutersWithoutPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.CREATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER);
        //执行语句

        oauthSystemParam.preInsert();

        return h2Dao.executeBean(sql, oauthSystemParam) == 1;

    }

    /**
     * 编辑对象
     *
     * @param oauthSystemParam
     * @return
     * @throws Exception
     */
    public boolean edit(OauthSystemParam oauthSystemParam) throws Exception {
        //构建SQL工厂
        SQLBeanBuilder builder = SQLFactory.builder(OauthSystemParam.class);
        //通过主键 更新所传递的参数
        String sql = builder.updateRoutersByPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER);
        //执行语句
        oauthSystemParam.preUpdate();
        return h2Dao.executeBean(sql, oauthSystemParam) == 1;
    }

    /**
     * 根据前台传递来的 字符串数组(id)执行删除语句
     *
     * @param _ids
     * @return
     * @throws Exception
     */
    public void del(String _ids) throws Exception {
        String[] ids = _ids.split(",");
        Collection<Integer> idIntegers = new ArrayList<>(ids.length);
        for (String id : ids) {
            idIntegers.add(Integer.valueOf(id));
        }
        delete(idIntegers, OauthSystemParam.class);
    }
}
