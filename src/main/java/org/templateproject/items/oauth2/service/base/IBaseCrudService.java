package org.templateproject.items.oauth2.service.base;

import org.templateproject.pojo.page.Page;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * 基础类service通用接口
 * Created by Wuwenbin on 2017/7/12.
 */
public interface IBaseCrudService {

//=====================增======================

    /**
     * 保存给定的实体。
     * 使用返回的实例进行进一步操作，因为保存操作可能会完全更改实体实例。
     * 如果需要S和T的字段都插入到数据库，那么T类中字段修饰符请使用protected或者public
     *
     * @param entity 插入的实体
     * @param <T>    实体类型对象
     * @param clazz  实体类型
     * @return 已保存的实体
     */
    <T> T save(T entity, Class<T> clazz) throws Exception;

    //=====================删======================

    /**
     * 根据所给的id删除对应的实体
     *
     * @param id
     * @param clazz
     * @param <T>
     * @param <ID>
     * @throws Exception
     */
    <T, ID> boolean delete(ID id, Class<T> clazz) throws Exception;


    /**
     * 通过id删除对象
     *
     * @param ids
     * @param clazz
     * @param <T>
     * @param <ID>
     * @return
     * @throws Exception
     */
    <T, ID> void delete(ID[] ids, Class<T> clazz) throws Exception;

    //=====================查======================

    /**
     * 统计数量
     *
     * @param entityClass
     * @param <T>
     * @return 实体在数据库表中出现的记录数
     */
    <T> long count(Class<T> entityClass);


    /**
     * 根据id判断返回是否存
     *
     * @param id
     * @param clazz
     * @param <T>
     * @param <ID>
     * @return 如果存在，返回true,否则false
     */
    <T, ID> boolean exists(ID id, Class<T> clazz);

    /**
     * 通过id查找一个对象
     *
     * @param id
     * @param clazz
     * @param <T>
     * @param <ID>
     * @return
     */
    <T, ID> T findBean(ID id, Class<T> clazz);

    /**
     * 根据所给的id集合返回对应的所有实体集合
     *
     * @param ids 查找条件中的id集合对象
     * @return 查找的对象结果结合
     */
    <T, ID> List<T> findListBean(Collection<ID> ids, Class<T> clazz);


    /**
     * 查找该对象的集合
     *
     * @param clazz
     * @param <T>
     * @return
     */
    <T> List<T> findListBean(Class<T> clazz);

    /**
     * 查找页面对象信息
     *
     * @param page            当前页面对象
     * @param sql             sql语句，不包含limit部分
     * @param arrayParameters 数组形式的参数
     * @param <T>
     * @return 页面所有信息
     */
    <T> Page findPage(Page<T> page, Class<T> clazz, String sql, Object... arrayParameters);

    /**
     * 查找页面对象信息
     *
     * @param page         当前页面对象
     * @param sql          sql语句，不包含limit部分
     * @param mapParameter map形式的参数
     * @param <T>
     * @return 页面所有信息
     */
    <T> Page findPage(Page<T> page, Class<T> clazz, String sql, Map<String, Object> mapParameter);

    /**
     * 查找页面对象信息
     *
     * @param page          当前页面对象
     * @param sql           sql语句，不包含limit部分
     * @param beanParameter 对象形式的参数
     * @param <T>           对象的泛型
     * @return 页面所有信息
     */
    <T> Page findPage(Page<T> page, Class<T> clazz, String sql, T beanParameter);

//=====================改======================

    /**
     * 根据id修改实体
     *
     * @param entity        修改的实体
     * @param clazz
     * @param <T>
     * @param updateRouters 需要更新的字段
     * @return 修改后的实体对象
     * @throws Exception
     */
    <T> boolean update(T entity, Class<T> clazz, int... updateRouters) throws Exception;

    /**
     * 根据id批量更新实体
     *
     * @param entities      需要更新的记录所对应的更新实体
     * @param clazz
     * @param updateRouters
     * @param <T>
     * @throws Exception
     */
    <T> void update(Collection<T> entities, Class<T> clazz, int... updateRouters) throws Exception;
}
