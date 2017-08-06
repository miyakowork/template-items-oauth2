package org.templateproject.oauth2.service;

import jodd.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.lang.TP;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ServiceConsts;
import org.templateproject.oauth2.entity.OauthOperationPrivilegeType;
import org.templateproject.oauth2.service.base.AbstractBaseCrudService;
import org.templateproject.oauth2.support.pojo.bo.OperationPrivilegeTypeBo;
import org.templateproject.oauth2.support.pojo.vo.OperationPrivilegeTypeVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by zhangteng on 2017/7/12.
 * 操作级权限类型 service
 */
@Service
@Transactional
public class OperationPrivilegeTypeService extends AbstractBaseCrudService<OauthOperationPrivilegeType, Integer> {


    /*
    * 根据name模糊查询操作级权限类型
    * name为空 则返回所有记录
    * */
    public Page<OperationPrivilegeTypeVO> getPage(Page<OperationPrivilegeTypeVO> page, OperationPrivilegeTypeBo operationPrivilegeTypeBo) {

        String sql = "SELECT torm.*,tou1.username as createUserName,tou2.username as updateUserName   from T_OAUTH_OPERATION_PRIVILEGE_TYPE torm,t_oauth_user tou1,t_oauth_user tou2 where torm.create_user = tou1.id and  torm.update_user=tou2.id ";

        String orderSQL = "";
        if (StringUtil.isNotEmpty(page.getOrderField())) {
            orderSQL = TP.placeholder.format(" ORDER BY {} {} ", page.getOrderField(), page.getOrderDirection());
        }

        //如果参数不为空
        Map<String, Object> pMap = new HashMap<>();
        if (StringUtils.isNotEmpty(operationPrivilegeTypeBo.getName())) {
            sql += "AND torm.name LIKE :name  ";
            pMap.put("name", "%" + operationPrivilegeTypeBo.getName() + "%");
        }
        if (operationPrivilegeTypeBo.getEnabled() != null) {
            sql += "AND torm.ENABLED = :enabled1  ";
            pMap.put("enabled1", operationPrivilegeTypeBo.getEnabled());
        }
        return findPage(page, OperationPrivilegeTypeVO.class, sql + orderSQL, pMap);
    }


    /**
     * 添加操作级权限类型
     */
    public boolean save(OauthOperationPrivilegeType oauthOperationPrivilegeType) throws Exception {

        SQLBeanBuilder sqlBeanBuilder = SQLFactory.builder(OauthOperationPrivilegeType.class);
        String insertSQL = sqlBeanBuilder.insertRoutersWithoutPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.CREATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER
        );
        oauthOperationPrivilegeType.preInsert();
        return h2Dao.executeBean(insertSQL, oauthOperationPrivilegeType) > 0;

    }

    /**
     * 删除操作级权限类型
     */
    public boolean delete(String ids) throws Exception {
        String[] idss = ids.split(",");
        Integer[] integers = new Integer[idss.length];
        for (int i = 0; i < idss.length; i++) {
            int id = Integer.parseInt(idss[i]);
            integers[i] = id;
        }
        delete(integers, OauthOperationPrivilegeType.class);
        return true;
    }


    /**
     * 修改操作级权限类型
     */
    public boolean edit(OauthOperationPrivilegeType oauthOperationPrivilegeType) throws Exception {
        SQLBeanBuilder sbb = new SQLBeanBuilder(OauthOperationPrivilegeType.class);
        String updateSQL = sbb.updateRoutersByPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER);
        oauthOperationPrivilegeType.preUpdate();
        h2Dao.executeBatchByArrayBeans(updateSQL, oauthOperationPrivilegeType);
        return true;
    }

}
