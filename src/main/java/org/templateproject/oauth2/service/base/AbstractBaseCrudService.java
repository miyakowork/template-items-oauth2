package org.templateproject.oauth2.service.base;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.templateproject.dao.ancestor.AncestorDao;
import org.templateproject.dao.factory.DaoFactory;
import org.templateproject.oauth2.entity.base.BaseEntity;
import org.templateproject.pojo.page.Page;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;
import org.templateproject.sql.factory.SQLStrBuilder;

import java.util.*;

/**
 * 基类service
 * 提供基础的增删查改通用方法
 * Created by Wuwenbin on 2017/7/12.
 */
public abstract class AbstractBaseCrudService<T extends BaseEntity, ID> implements IBaseCrudService<T, ID> {

    private static final Logger LOGGER = LoggerFactory.getLogger(AbstractBaseCrudService.class);


    protected AncestorDao h2Dao;//数据层操作dao
    protected DataSourceTransactionManager txManager;//事物操作对象

    @Autowired
    public void setH2Dao(DaoFactory daoFactory) {
        this.h2Dao = daoFactory.dynamicDao;
    }

    @Autowired
    public void setTxManager(DataSourceTransactionManager txManager) {
        this.txManager = txManager;
    }

    @Override
    public long count(Class<T> clazz) {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        return h2Dao.queryNumberByArray(sbb.countAll(), Long.class);
    }

    @Override
    public boolean exists(ID id, Class<T> clazz) {
        return findOne(id, clazz) != null;
    }

    @Override
    public <S extends T> S findOne(ID id, Class<S> clazz) {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        return h2Dao.findBeanByArray(sbb.selectAllByPk(), clazz, id);
    }

    @Override
    public Collection<T> findAll(Collection<ID> ids, Class<T> clazz) {
        Collection<T> t = new ArrayList<>();
        for (ID id : ids) {
            t.add(findOne(id, clazz));
        }
        return t;
    }

    @Override
    public <S extends T> Collection<S> findList(Class<S> clazz) {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        String findSQL = sbb.selectAll();
        LOGGER.info("SQL:[{}]", findSQL);
        return h2Dao.findListBeanByArray(findSQL, clazz);
    }

    @Override
    public <S extends T> Page<S> findPage(Page<S> page, Class<S> clazz, String sql, Object... arrayParameters) {
        return h2Dao.findPageListBeanByArray(sql, clazz, page, arrayParameters);
    }

    @Override
    public <S extends T> Page<S> findPage(Page<S> page, Class<S> clazz, String sql, Map<String, Object> mapParameter) {
        return h2Dao.findPageListBeanByMap(sql, clazz, page, mapParameter);
    }

    @Override
    public <S extends T> Page<S> findPage(Page<S> page, Class<S> clazz, String sql, S beanParameter) {
        return h2Dao.findPageListBeanByBean(sql, clazz, page, beanParameter);
    }

    @Override
    public <S extends T> void delete(ID id, Class<S> clazz) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        SQLStrBuilder ssb = SQLFactory.builder();
        String deleteSQL = ssb.deleteByColumns(sbb.getTableName(), sbb.getPkField().getName());
        LOGGER.info("SQL:[{}]", deleteSQL);
        h2Dao.executeArray(deleteSQL, id);
    }

    @Override
    public <S extends T> void delete(S entity) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(entity.getClass());
        String deleteSQL = sbb.deleteByPk();
        LOGGER.info("SQL:[{}]", deleteSQL);
        h2Dao.executeBean(deleteSQL, entity);
    }

    @Override
    public <S extends T> int[] delete(ID[] ids, Class<S> clazz) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        String deleteSQL = sbb.deleteByPk();
        String pk = sbb.getPkField().getName();
        Collection<Map<String, Object>> maps = new ArrayList<>(ids.length);
        for (ID id : ids) {
            Map<String, Object> map = new HashMap<>();
            map.put(pk, id);
            maps.add(map);
        }
       return h2Dao.executeBatchByCollectionMaps(deleteSQL, maps);
    }

    @Override
    public <S extends T> void delete(Collection<ID> ids, Class<S> clazz) throws Exception {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setIsolationLevel(TransactionDefinition.ISOLATION_READ_COMMITTED);
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);// 事物隔离级别，开启新事务
        TransactionStatus status = txManager.getTransaction(def); // 获得事务状态
        try {
            for (ID id : ids) {
                delete(id, clazz);
            }
            txManager.commit(status);
        } catch (Exception e) {
            txManager.rollback(status);
            LOGGER.error("删除过程中发生错误: {}", e);
            throw new Exception("批量删除失败，回滚全部数据");
        }
    }

    @Override
    public <S extends T> S saveBean(S entity, Class<S> clazz) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        String saveSQL = sbb.insertAllWithoutPk();
        LOGGER.info("SQL:[{}]", saveSQL);
        entity.preInsert();
        return h2Dao.insertBeanAutoGenKeyOutBean(saveSQL, entity, clazz, sbb.getTableName());
    }

    @Override
    public <S extends T> Collection<S> save(Collection<S> entities, Class<S> clazz) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        String saveSQL = sbb.insertAllWithoutPk();
        LOGGER.info("SQL:[{}]", saveSQL);
        Collection<S> s = new ArrayList<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setIsolationLevel(TransactionDefinition.ISOLATION_READ_COMMITTED);
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);// 事物隔离级别，开启新事务
        TransactionStatus status = txManager.getTransaction(def); // 获得事务状态
        try {
            for (S next : entities) {
                next.preInsert();
                s.add(h2Dao.insertBeanAutoGenKeyOutBean(saveSQL, next, clazz, sbb.getTableName()));
            }
            txManager.commit(status);
            return s;
        } catch (Exception e) {
            txManager.rollback(status);
            LOGGER.error("插入集合发生错误: {}", e);
            throw new Exception("批量保存失败，回滚全部数据");
        }
    }

    @Override
    public <S extends T> boolean update(S entity, Class<S> clazz, int... routers) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        String updateSQL = sbb.updateRoutersByPk(routers);
        LOGGER.info("SQL:[{}]", updateSQL);
        entity.preUpdate();
        int affect = h2Dao.executeBean(updateSQL, entity);
        return affect == 1;
    }
}
