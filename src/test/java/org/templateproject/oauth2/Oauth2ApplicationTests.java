package org.templateproject.oauth2;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.test.context.junit4.SpringRunner;
import org.templateproject.dao.ancestor.AncestorDao;
import org.templateproject.dao.factory.DaoFactory;
import org.templateproject.oauth2.config.support.password.PasswordHelper;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ServiceConsts;
import org.templateproject.oauth2.entity.OauthMenuModule;
import org.templateproject.oauth2.entity.OauthResourceModule;
import org.templateproject.oauth2.entity.OauthUser;
import org.templateproject.oauth2.service.base.AbstractBaseCrudService;
import org.templateproject.oauth2.service.shiro.ShiroUserService;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;
import org.templateproject.sql.factory.SQLStrBuilder;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RunWith(SpringRunner.class)
@SpringBootTest
public class Oauth2ApplicationTests extends AbstractBaseCrudService<OauthMenuModule, Integer> {

    public static void main(String[] args) {
        SQLBeanBuilder sbb = SQLFactory.builder(OauthUser.class);
        System.out.println(sbb.insertAllWithoutPk());
    }

    private AncestorDao dao;

    @Autowired
    private PasswordHelper passwordHelper;

    @Autowired
    private ShiroUserService shiroUserService;

    @Autowired
    public void setDao(DaoFactory daoFactory) {
        this.dao = daoFactory.dynamicDao;
    }

    @Test
    public void contextLoads() {
    }

    //更新测试
    @Test
    public void testUpdate() throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(OauthMenuModule.class);
        String updateSQL = sbb.updateRoutersByPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER);

        SQLStrBuilder ssb = SQLFactory.builder();
        String sql = ssb.deleteByColumns("table", "id", "name");
        System.err.println(sql);

//        String insertSQL=sbb.insertAllWithoutPk();
//        String sql="INSERT INTO t_oauth_menu_module VALUES(1,:name, :enabled, current_date(), 1, current_date(), 1, 2, 'sss')";
//        OauthMenuModule omm = new OauthMenuModule();
//        omm.setId(1);
//        omm.setName("测试模块");
//        omm.preInsert();
//        System.out.println(omm);
//
//        omm.preUpdate();
//
//        omm.preInsert();
//        dao.executeBean(sql, omm);
    }

    @Test
    public void testLike() {
        String sql = "select * from t_oauth_resource_module where name LIKE :aname ";
        Map<String, Object> map = new HashMap<>();
        map.put("aname", "%ada%");
        map.put("field", "id");
        map.put("direction", "desc");
        List<OauthResourceModule> list = dao.getNamedParameterJdbcTemplateObj().query(sql, map, BeanPropertyRowMapper.newInstance(OauthResourceModule.class));
        System.out.println(list.get(0).toString());
//        daoFactory.dynamicDao.findListBeanByMap(sql, OauthResourceModule.class, map);
    }

    @Test
    public void addTestUser() throws Exception {
        OauthUser user = new OauthUser();
        user.setUsername("sa");
        user.setPassword("123456");
        user.setCname("伍文彬");
        user.setDefaultRoleId(1);
        user.setEmail("765934806@qq.com");
        user.setMobile("181xxxxxxxx");
        user.setQq("765934806");
        user.setOrderIndex(0);
        user.setEnabled(true);
        user.setRemark("伍文彬wwb");
        user.setDeptId(1);
        passwordHelper.encryptPassword(user);
        user.preInsert();
        int i = shiroUserService.addNewUser(user);
    }
}
