package org.templateproject.oauth2.service.base;

import org.templateproject.oauth2.entity.base.BaseEntity;
import org.templateproject.pojo.page.Page;

import java.util.Collection;
import java.util.Map;

/**
 * 基础类service通用接口
 * Created by Wuwenbin on 2017/7/12.
 */
public interface IBaseCrudService<T extends BaseEntity, ID> {

    /**
     * 查找实体个数
     *
     * @return 个数
     */
    long count(Class<T> clazz);


    /**
     * 根据id判断返回是否存在这个实体
     *
     * @param id 不能为 {@literal null}.
     * @return 如果所给id能找到对应集合返回true，否则false
     * @throws IllegalArgumentException 如果 {@code id} 为 {@literal null}
     */
    boolean exists(ID id, Class<T> clazz);

    /**
     * 通过id查找一个对象
     *
     * @param id    查询条件id
     * @param clazz 子对象class类型
     * @param <S>   子对象泛型
     * @return 返回该对象或者是该对象的子对象
     */
    <S extends T> S findOne(ID id, Class<S> clazz);

    /**
     * 根据所给的id集合返回对应的所有实体集合
     *
     * @param ids 查找条件中的id集合对象
     * @return 查找的对象结果结合
     */
    Collection<T> findAll(Collection<ID> ids, Class<T> clazz);

    /**
     * 查找对象集合
     *
     * @param clazz 对象类型
     * @param <S>   对象的泛型
     * @return 返回该对象或该对象的子对象的集合
     */
    <S extends T> Collection<S> findList(Class<S> clazz);

    /**
     * 查找页面对象信息
     *
     * @param page            当前页面对象
     * @param sql             sql语句，不包含limit部分
     * @param arrayParameters 数组形式的参数
     * @param <S>             对象的泛型
     * @return 页面所有信息
     */
    <S extends T> Page findPage(Page<S> page, Class<S> clazz, String sql, Object... arrayParameters);

    /**
     * 查找页面对象信息
     *
     * @param page         当前页面对象
     * @param sql          sql语句，不包含limit部分
     * @param mapParameter map形式的参数
     * @param <S>          对象的泛型
     * @return 页面所有信息
     */
    <S extends T> Page findPage(Page<S> page, Class<S> clazz, String sql, Map<String, Object> mapParameter);

    /**
     * 查找页面对象信息
     *
     * @param page          当前页面对象
     * @param sql           sql语句，不包含limit部分
     * @param beanParameter 对象形式的参数
     * @param <S>           对象的泛型
     * @return 页面所有信息
     */
    <S extends T> Page findPage(Page<S> page, Class<S> clazz, String sql, S beanParameter);

    /**
     * 根据所给的id删除对应的实体
     *
     * @param id 不能为 {@literal null}.
     * @throws IllegalArgumentException 如果 {@code id} 为 {@literal null}
     */
    <S extends T> void delete(ID id, Class<S> clazz) throws Exception;

    /**
     * 删除所给的参数实体
     *
     * @param entity 删除的实体
     * @throws IllegalArgumentException 如果所给参数实体为 {@literal null}.
     */
    <S extends T> void delete(S entity) throws Exception;

    /**
     * 通过id删除对象
     *
     * @param ids 删除对象的数组形式的id
     * @throws Exception 删除抛出异常
     */
    <S extends T> int[] delete(ID[] ids, Class<S> clazz) throws Exception;

    /**
     * 根据所给的id集合删除对应的实体
     *
     * @param ids 删除id的集合
     */
    <S extends T> void delete(Collection<ID> ids, Class<S> clazz) throws Exception;

    /**
     * 保存给定的实体。
     * 使用返回的实例进行进一步操作，因为保存操作可能会完全更改实体实例。
     * 如果需要S和T的字段都插入到数据库，那么T类中字段修饰符请使用protected或者public
     *
     * @param entity 插入的实体
     * @param <S>    实体类型对象
     * @param clazz  实体类型
     * @return 已保存的实体
     */
    <S extends T> S saveBean(S entity, Class<S> clazz) throws Exception;

    /**
     * 保存给的所有实体
     *
     * @param entities 插入的实体集合
     * @param clazz    实体类型
     * @return 保存的实体集合
     * @throws IllegalArgumentException 路给所给的实体参数集合为 {@literal null}.
     */
    <S extends T> Collection<S> save(Collection<S> entities, Class<S> clazz) throws Exception;

    /**
     * 修改所给的实体
     *
     * @param entity  修改的实体
     * @param clazz   实体类型
     * @param <S>     实体泛型
     * @param routers 更新的字段
     * @return 修改后的实体对象
     * @throws Exception
     */
    <S extends T> boolean update(S entity, Class<S> clazz, int... routers) throws Exception;
}
