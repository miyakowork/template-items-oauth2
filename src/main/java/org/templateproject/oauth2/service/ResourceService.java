package org.templateproject.oauth2.service;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.lang.TP;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ServiceConsts;
import org.templateproject.oauth2.entity.OauthResource;
import org.templateproject.oauth2.service.base.AbstractBaseCrudService;
import org.templateproject.oauth2.support.pojo.bo.ResourceBO;
import org.templateproject.oauth2.support.pojo.vo.ResourceVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Liurongqi on 2017/7/13.
 */
@Service
@Transactional
public class ResourceService extends AbstractBaseCrudService<OauthResource, Integer> {

    /**
     * 根据权限标识查询数据
     * @param resourceBO
     * @param page
     * @return page<OauthResource>
     */
    public Page<ResourceVO> getResourcePage(ResourceBO resourceBO, Page<ResourceVO> page) {

        Map<String, Object> pMap = new HashMap<>();

        String sql = "SELECT tor.*,tou1.username as create_name, tou2.username as update_name" +
                " FROM t_oauth_resource tor ,t_oauth_user tou1,t_oauth_user tou2"+
                " WHERE tor.create_user = tou1.id AND tor.update_user = tou2.id";
        String orderSQL = "";
        //先组装order部分
        if (StringUtils.isNotEmpty(page.getOrderField()) && StringUtils.isNotEmpty(page.getOrderDirection())) {
            orderSQL = TP.placeholder.format(" ORDER BY {} {}", page.getOrderField(), page.getOrderDirection());
        }

        //判断enabled
        if (resourceBO.getEnabled()!=null){
            sql += " AND tor.enabled = "+ resourceBO.getEnabled();
        }

        //判断url
        if (StringUtils.isNotEmpty(resourceBO.getUrl())){
            sql += " AND tor.url LIKE :url";
            pMap.put("url", "%" + resourceBO.getUrl()+ "%");

        }

        //判断permissionMark
        if (StringUtils.isNotEmpty(resourceBO.getPermissionMark())){
            sql += " AND tor.permission_mark LIKE :permissionMark";
            pMap.put("permissionMark", "%" + resourceBO.getPermissionMark()+ "%");
        }

        //判断name
        if (StringUtils.isNotEmpty(resourceBO.getName())){
            sql +=" AND tor.name LIKE :name";
            pMap.put("name","%" + resourceBO.getName()+"%");
        }

        //判断systemCode
        if (StringUtils.isNotEmpty(resourceBO.getSystemCode())){
            sql += " AND tor.system_code LIKE :systemCode";
            pMap.put("systemCode","%" + resourceBO.getSystemCode()+"%");
        }

        sql += orderSQL;
        return findPage(page, ResourceVO.class, sql,pMap);

    }

    /**
     * 新增资源信息
     * @param oauthResource
     * @return
     * @throws Exception
     */
    public boolean save(OauthResource oauthResource) throws Exception{
        SQLBeanBuilder sqlBeanBuilder = SQLFactory.builder(OauthResource.class);
        String insertSQL = sqlBeanBuilder.insertRoutersWithoutPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.CREATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER
        );

        oauthResource.preInsert();
        return h2Dao.executeBean(insertSQL,oauthResource)>0;
    }

    /**
     * 编辑资源信息
     * @param oauthResource
     * @return
     * @throws Exception
     */
    public boolean edit(OauthResource oauthResource) throws Exception{
        SQLBeanBuilder sqlBeanBuilder = SQLFactory.builder(OauthResource.class);
        String updateSQL = sqlBeanBuilder.updateRoutersByPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER
        );
        oauthResource.preUpdate();
        return h2Dao.executeBean(updateSQL,oauthResource)>0;

    }

    /**
     * 删除指定资源
     * @param deleteIds
     * @return
     * @throws Exception
     */
    public void delete(String deleteIds)throws Exception {
        String[] ids = deleteIds.split(",");
        Integer[] integers = new Integer[ids.length];
        for (int i = 0; i < ids.length; i++) {
            int id = Integer.parseInt(ids[i]);
            integers[i] = id;
        }
        delete(integers, OauthResource.class);
    }
}
