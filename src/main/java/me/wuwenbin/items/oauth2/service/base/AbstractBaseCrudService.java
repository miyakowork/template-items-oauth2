package me.wuwenbin.items.oauth2.service.base;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.templateproject.dao.ancestor.AncestorDao;
import org.templateproject.dao.factory.DaoFactory;
import org.templateproject.pojo.page.Page;
import org.templateproject.tools.sqlgen.entrance.SQLFactory;
import org.templateproject.tools.sqlgen.factory.SQLBeanBuilder;
import org.templateproject.tools.sqlgen.factory.SQLStrBuilder;

import java.util.*;

/**
 * 基类抽象service
 * 提供匹配sql的方法和实现接口的方法
 * Created by Wuwenbin on 2017/7/12.
 */
public abstract class AbstractBaseCrudService implements IBaseCrudService {

    private static final Logger LOGGER = LoggerFactory.getLogger(AbstractBaseCrudService.class);

    protected AncestorDao mysql;//数据层操作dao

    @Autowired
    public void setMysql(DaoFactory daoFactory) {
        this.mysql = daoFactory.dynamicDao;
    }


    @Override
    public <T> T save(T entity, Class<T> clazz) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        String saveSQL = sbb.insertAllWithoutPk();
        LOGGER.info("SQL:[{}]", saveSQL);
        return mysql.insertBeanAutoGenKeyOutBean(saveSQL, entity, clazz, sbb.getTableName());
    }

    @Override
    public <T, ID> boolean delete(ID id, Class<T> clazz) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        SQLStrBuilder ssb = SQLFactory.builder();
        String deleteSQL = ssb.deleteByColumns(sbb.getTableName(), sbb.getPkField().getName());
        LOGGER.info("SQL:[{}]", deleteSQL);
        return mysql.executeArray(deleteSQL, id) == 1;
    }

    @Override
    public <T, ID> void delete(ID[] ids, Class<T> clazz) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        String deleteSQL = sbb.deleteByPk();
        String pk = sbb.getPkField().getName();
        Collection<Map<String, Object>> maps = new ArrayList<>(ids.length);
        for (ID id : ids) {
            Map<String, Object> map = new HashMap<>();
            map.put(pk, id);
            maps.add(map);
        }
        mysql.executeBatchByCollectionMaps(deleteSQL, maps);
    }

    @Override
    public <T> long count(Class<T> entityClass) {
        SQLBeanBuilder sbb = SQLFactory.builder(entityClass);
        return mysql.queryNumberByArray(sbb.countAll(), Long.class);
    }

    @Override
    public <T, ID> boolean exists(ID id, Class<T> clazz) {
        return findBean(id, clazz) != null;
    }

    @Override
    public <T, ID> T findBean(ID id, Class<T> clazz) {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        return mysql.findBeanByArray(sbb.selectAllByPk(), clazz, id);
    }

    @Override
    public <T, ID> List<T> findListBean(Collection<ID> ids, Class<T> clazz) {
        List<T> t = new ArrayList<>(ids.size());
        for (ID id : ids) {
            t.add(findBean(id, clazz));
        }
        return t;
    }

    @Override
    public <T> List<T> findListBean(Class<T> clazz) {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        String findSQL = sbb.selectAll();
        LOGGER.info("SQL:[{}]", findSQL);
        return mysql.findListBeanByArray(findSQL, clazz);
    }

    @Override
    public <T> Page findPage(Page<T> page, Class<T> clazz, String sql, Object... arrayParameters) {
        return mysql.findPageListBeanByArray(sql, clazz, page, arrayParameters);
    }

    @Override
    public <T> Page findPage(Page<T> page, Class<T> clazz, String sql, Map<String, Object> mapParameter) {
        return mysql.findPageListBeanByMap(sql, clazz, page, mapParameter);
    }

    @Override
    public <T> Page findPage(Page<T> page, Class<T> clazz, String sql, T beanParameter) {
        return mysql.findPageListBeanByBean(sql, clazz, page, beanParameter);
    }

    @Override
    public <T> boolean update(T entity, Class<T> clazz, int... updateRouters) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        String updateSQL = sbb.updateRoutersByPk(updateRouters);
        LOGGER.info("SQL:[{}]", updateSQL);
        return mysql.executeBean(updateSQL, entity) == 1;
    }

    @Override
    public <T> void update(Collection<T> entities, Class<T> clazz, int... updateRouters) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        String updateSQL = sbb.updateRoutersByPk(updateRouters);
        LOGGER.info("SQL:[{}]", updateSQL);
        mysql.executeBatchByCollectionBeans(updateSQL, entities);
    }


}
