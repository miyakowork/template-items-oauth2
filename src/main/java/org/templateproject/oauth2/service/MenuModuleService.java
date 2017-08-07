package org.templateproject.oauth2.service;

import jodd.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.lang.TP;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ServiceConsts;
import org.templateproject.oauth2.entity.OauthMenuModule;
import org.templateproject.oauth2.service.base.AbstractBaseCrudService;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.pojo.bo.MenuModuleBO;
import org.templateproject.oauth2.support.pojo.vo.MenuModuleVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yuanqi on 2017/7/12/012.
 */
@Service
@Transactional
public class MenuModuleService extends SimpleBaseCrudService<OauthMenuModule,Integer> {
    /**
     * 获得页面
     *
     * @param page
     * @param menuModuleBO
     * @return
     */
    public Page<MenuModuleVO> getPage(Page<MenuModuleVO> page, MenuModuleBO menuModuleBO) {

        String sql = "SELECT tomm.*,tou1.username as createUsername,tou2.username as updateUsername " +
                "from T_OAUTH_MENU_MODULE tomm,t_oauth_user tou1,t_oauth_user tou2 " +
                "WHERE tomm.create_user = tou1.id and  tomm.update_user=tou2.id  ";
        String orderSQL = "";
        //先组装order部分
        if (StringUtils.isNotEmpty(page.getOrderField()) && StringUtils.isNotEmpty(page.getOrderDirection())) {
            orderSQL = TP.placeholder.format(" ORDER BY {} {}",page.getOrderField(), page.getOrderDirection());
        }
        //判断参数是否为空
        Map<String, Object> pMap = new HashMap<>();
        if(StringUtil.isNotEmpty(menuModuleBO.getName())){
            sql += " AND name LIKE :name";
            pMap.put("name", "%" + menuModuleBO.getName() + "%");
        }
        if(StringUtil.isNotEmpty(menuModuleBO.getSystemCodeName())){
            sql += " AND System_Code  LIKE  :systemcode";
            pMap.put("systemcode", "%" + menuModuleBO.getSystemCodeName() + "%");
        }
        if(menuModuleBO.getEnabled()!=null){
            sql += " AND  tomm.enabled  =  :enabled";
            pMap.put("enabled", menuModuleBO.getEnabled());
        }
        return    findPage(page, MenuModuleVO.class, sql+orderSQL, pMap);
    }

    /**
     *插入数据
     */
    public boolean save(OauthMenuModule oauthMenuModule) throws Exception {

        SQLBeanBuilder sqlBeanBuilder = SQLFactory.builder(OauthMenuModule.class);
        String insertSQL = sqlBeanBuilder.insertRoutersWithoutPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.CREATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER
        );
        oauthMenuModule.preInsert();
        return h2Dao.executeBean(insertSQL, oauthMenuModule) > 0;

    }

    /**
     *删除数据
     */

    public void delete(String ids) throws  Exception{

        String [] idss=ids.split(",");

        List lists=new ArrayList<Integer>();

        for(int i=0;i<idss.length;i++){

            int id=Integer.parseInt(idss[i]);

            lists.add(id);
            String sql="delete from t_oauth_menu_module where id = ?";
            h2Dao.executeArray(sql,id);
        }

         //delete(lists,OauthOperationPrivilegeType.class);

    }

    /**
     * 修改数据
     */
    public boolean edit(OauthMenuModule oauthMenuModule) throws Exception{
        SQLBeanBuilder sbb=new SQLBeanBuilder(OauthMenuModule.class);
        String updateSQL = sbb.updateRoutersByPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER);
        oauthMenuModule.preInsert();
       return  h2Dao.executeBatchByArrayBeans(updateSQL,oauthMenuModule)!=null;


    }


}
