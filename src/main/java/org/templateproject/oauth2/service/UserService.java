package org.templateproject.oauth2.service;

import jodd.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.lang.TP;
import org.templateproject.oauth2.config.support.password.PasswordHelper;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ServiceConsts;
import org.templateproject.oauth2.entity.*;
import org.templateproject.oauth2.service.base.AbstractBaseCrudService;
import org.templateproject.oauth2.service.shiro.ShiroUserService;
import org.templateproject.oauth2.support.pojo.bo.UserBO;
import org.templateproject.oauth2.support.pojo.vo.UserVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;

import java.util.*;

/**
 * Created by yuanqi on 2017/7/19/019.
 */

@Service
@Transactional
public class UserService extends AbstractBaseCrudService {


    @Autowired
    private PasswordHelper passwordHelper;

    @Autowired
    private ShiroUserService shiroUserService;

    /**
     * 获得page
     */
    public Page<UserVO> getPage(Page<UserVO> page, UserBO userBO) {

        String sql = "SELECT tou.*, tod.name as departmentName,tor.cn_name as roleName " +
                " from T_OAUTH_USER tou left join T_OAUTH_DEPARTMENT tod on tou.dept_id = tod.id left join T_OAUTH_ROLE tor" +
                "  on tou.default_role_id=tor.id";
        String orderSQL = "";
        //先组装order部分
        if (StringUtils.isNotEmpty(page.getOrderField()) && StringUtils.isNotEmpty(page.getOrderDirection())) {
            orderSQL = TP.placeholder.format(" ORDER BY {} {}", page.getOrderField(), page.getOrderDirection());
        }
        //判断参数是否为空
        Map<String, Object> pMap = new HashMap<>();
        if(StringUtil.isNotEmpty(userBO.getUsername())){
            sql += " WHERE username LIKE :username1";
            pMap.put("username1", "%" + userBO.getUsername() + "%");
        }
        if(StringUtil.isNotEmpty(userBO.getCname())){
            sql += " WHERE cname  LIKE  :cname1";
            pMap.put("cname1", "%" + userBO.getCname() + "%");
        }
        if(userBO.getEnabled()!=null){
            sql += " WHERE  tou.enabled  =  :enabled1";
            pMap.put("enabled1", userBO.getEnabled());
        }
        return findPage(page, UserVO.class, sql+orderSQL, pMap);
    }

    /**
     * 增加数据
     */
    public boolean save1(OauthUser oauthUser) throws Exception {
        SQLBeanBuilder sqlBeanBuilder = SQLFactory.builder(OauthUser.class);
        String insertSQL = sqlBeanBuilder.insertRoutersWithoutPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.CREATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER
        );
        oauthUser.preInsert();
        passwordHelper.encryptPassword(oauthUser);
        return h2Dao.executeBean(insertSQL, oauthUser) > 0;
    }

    /**
     * 修改数据
     */
    public boolean edit1(OauthUser oauthUser) throws Exception {
        SQLBeanBuilder sbb = new SQLBeanBuilder(OauthUser.class);
        String updateSQL = sbb.updateRoutersByPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER);
        //    shiroUserService.changePasswordByUser(oauthUser,oauthUser.getPassword());
        passwordHelper.encryptPassword(oauthUser);
        oauthUser.preInsert();
        return h2Dao.executeBatchByArrayBeans(updateSQL, oauthUser) != null;
    }
    /**
     * 删除数据
     */

    /**
     * 获取角色表的所有值，用以获得用户管理添加页面的下拉菜单角色的值
     */
    public List<OauthRole> getRole1() {
        String sql = "SELECT * FROM  T_OAUTH_ROLE";
        return h2Dao.findListBeanByArray(sql, OauthRole.class);
    }


    public void delete(String ids) throws Exception {
        String[] idss = ids.split(",");

        List lists = new ArrayList<Integer>();

        for (int i = 0; i < idss.length; i++) {
            int id = Integer.parseInt(idss[i]);

            lists.add(id);
            String sql = "UPDATE T_OAUTH_USER SET ENABLED  = 0 WHERE id =?";
            h2Dao.executeArray(sql, id);
        }

    }
}
