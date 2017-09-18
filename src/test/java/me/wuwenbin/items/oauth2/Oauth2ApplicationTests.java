package me.wuwenbin.items.oauth2;

import me.wuwenbin.items.oauth2.config.support.password.PasswordHelper;
import me.wuwenbin.items.oauth2.constant.CommonConsts;
import me.wuwenbin.items.oauth2.constant.ServiceConsts;
import me.wuwenbin.items.oauth2.entity.*;
import me.wuwenbin.items.oauth2.service.ResourceService;
import me.wuwenbin.items.oauth2.service.base.AbstractBaseCrudService;
import me.wuwenbin.items.oauth2.service.shiro.ShiroUserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.test.context.junit4.SpringRunner;
import org.templateproject.dao.ancestor.AncestorDao;
import org.templateproject.dao.factory.DaoFactory;
import org.templateproject.tools.sqlgen.entrance.SQLFactory;
import org.templateproject.tools.sqlgen.factory.SQLBeanBuilder;
import org.templateproject.tools.sqlgen.factory.SQLStrBuilder;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RunWith(SpringRunner.class)
@SpringBootTest
public class Oauth2ApplicationTests extends AbstractBaseCrudService {

    public static void main(String[] args) {
        SQLBeanBuilder sbb = SQLFactory.builder(IUser.class);
        System.out.println(sbb.insertAllWithoutPk());
    }

    private AncestorDao dao;

    @Autowired
    private ResourceService resourceService;

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
        String sql = SQLFactory.builder(IMenu.class).insertAllWithPk();
        System.out.println(sql);
    }

    //更新测试
    @Test
    public void testUpdate() throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(IMenuModule.class);
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
//        IMenuModule omm = new IMenuModule();
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
        String sql = "SELECT * FROM t_oauth_resource_module WHERE name LIKE :aname ";
        Map<String, Object> map = new HashMap<>();
        map.put("aname", "%ada%");
        map.put("field", "id");
        map.put("direction", "desc");
        List<IResourceModule> list = dao.getNamedParameterJdbcTemplateObj().query(sql, map, BeanPropertyRowMapper.newInstance(IResourceModule.class));
        System.out.println(list.get(0).toString());
//        daoFactory.dynamicDao.findListBeanByMap(sql, IResourceModule.class, map);
    }

    @Test
    public void addTestUser() throws Exception {
        IUser user = new IUser();
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
        shiroUserService.addNewUser(user);
    }

    @Test
    public void addTestResource() throws Exception {
        for (int i = 4; i < 100; i++) {
            IResource resource = new IResource();
            resource.setUrl("/management/atest" + i);
            resource.setName("A测试" + i);
            resource.setPermissionMark("sys:atest" + i + ":list");
            resource.setSystemCode("SYS_BASE_PLATFORM");
            resource.setEnabled(true);
            resource.setOrderIndex(i);
            resource.preInsert();
            resourceService.simpleSave(resource, IResource.class);
        }

        for (int i = 1; i < 100; i++) {
            IResource resource = new IResource();
            resource.setUrl("/management/btest" + i);
            resource.setName("B测试" + i);
            resource.setPermissionMark("sys:btest" + i + ":list");
            resource.setSystemCode("SYS_WECHAT_PLATFORM");
            resource.setEnabled(true);
            resource.setOrderIndex(i);
            resource.preInsert();
            resourceService.simpleSave(resource, IResource.class);
        }
    }
}
