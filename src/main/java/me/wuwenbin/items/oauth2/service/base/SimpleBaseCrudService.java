package me.wuwenbin.items.oauth2.service.base;

import me.wuwenbin.items.oauth2.constant.CommonConsts;
import me.wuwenbin.items.oauth2.constant.ServiceConsts;
import me.wuwenbin.items.oauth2.entity.base.BaseEntity;
import me.wuwenbin.modules.pagination.Pagination;
import me.wuwenbin.modules.pagination.query.TableQuery;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.pojo.page.Page;
import org.templateproject.tools.sqlgen.entrance.SQLFactory;
import org.templateproject.tools.sqlgen.factory.SQLBeanBuilder;
import org.templateproject.tools.sqlgen.factory.SQLStrBuilder;

import java.util.*;

/**
 * 丰富接口/抽象类的实现类，提供一下额额外的操作方法（接口中未包含的方法）
 *
 * @see AbstractBaseCrudService
 * Created by Wuwenbin on 2017/7/17.
 */
@Service
@Transactional
public class SimpleBaseCrudService<Model extends BaseEntity, ID> extends AbstractBaseCrudService {

    private static final Logger LOGGER = LoggerFactory.getLogger(SimpleBaseCrudService.class);

    /**
     * 保存一条记录，id自动数据库生成
     *
     * @param model 对象
     * @param clazz 对象类型
     * @return 是否插入成功
     * @throws Exception 插入时生成的异常
     */
    public boolean simpleSave(Model model, Class<Model> clazz) throws Exception {
        model.preInsert();
        return super.save(model, clazz) != null;
    }

    /**
     * 编辑一条记录
     *
     * @param model 编辑对象
     * @param clazz 编辑对象的类型
     * @return 编辑是否成功
     * @throws Exception 编辑时发生的异常
     */
    public boolean simpleEdit(Model model, Class<Model> clazz) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        String updateSQL = sbb.updateRoutersByPk(ServiceConsts.DEFAULT_ROUTER, CommonConsts.UPDATE_ROUTER,
                CommonConsts.ENABLED_ROUTER, CommonConsts.ORDER_ROUTER, CommonConsts.REMARK_ROUTER);
        model.preUpdate();
        return mysql.executeBean(updateSQL, model) == 1;

    }

    /**
     * 执行删除的的批量操作,此方法仅适用于条件为主键id的
     *
     * @param ids 需要执行删除的值
     * @throws Exception 执行删除过程中发生的异常
     */
    public void simpleDeletes(Class<Model> clazz, Object[] ids) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        Collection<Map<String, Object>> maps = new ArrayList<>(ids.length);
        for (Object id : ids) {
            Map<String, Object> map = new HashMap<>();
            map.put(sbb.getPkField().getName(), id);//是通过id主键来约束的，即 where pk = :id
            maps.add(map);
        }
        String sql = sbb.deleteByPk();
        mysql.executeBatchByCollectionMaps(sql, maps);
    }

    /**
     * 有时候执行条件并不一定为id，而是其他字段则需要指定
     * 此方法为执行增删改的批量语句的方法
     * 此方法只能在service中使用，即需要在此类的子类中使用，因为此方法包含sql，在control层中操作不规范
     * 注：此方法只适用于sql中只包含一个参数的情况（所以大部分情况是delete语句）,切参数形式为冒号，而不是问号
     * 例如：update table set flag = true where constraintName = :constraintValue
     *
     * @param sql              sql
     * @param constraintName   约束列名字
     * @param constraintValues 约束列对象ids
     * @throws Exception e
     */
    protected void simpleExecutes(String sql, String constraintName, Object[] constraintValues) throws Exception {
        Collection<Map<String, Object>> maps = new ArrayList<>(constraintValues.length);
        for (Object constraintValue : constraintValues) {
            Map<String, Object> map = new HashMap<>();
            map.put(constraintName, constraintValue);//是通过id主键来约束的，即 where pk = :id
            maps.add(map);
        }
        mysql.executeBatchByCollectionMaps(sql, maps);
    }

    /**
     * 批量启用/禁用（适用于enabled字段），并且条件为主键（主键字段名为id）
     *
     * @param ids
     * @param clazz
     * @throws Exception
     */
    public <T extends Model> void simpleToggle(Object[] ids, Class<T> clazz) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        SQLStrBuilder ssb = SQLFactory.builder();
        String sql = ssb.updateColumnsByColumnArray(sbb.getTableName(), new String[]{"enabled"}, new String[]{"id"});
        simpleExecutes(sql, "id", ids);
    }

    /**
     * 查询所有可用的记录
     *
     * @param clazz
     * @param <T>
     * @return
     */
    public <T extends Model> List<T> findEnabledListBean(Class<T> clazz) {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        SQLStrBuilder ssb = SQLFactory.builder();
        String sql = ssb.selectAllByColumns(sbb.getTableName(), "enabled");
        return mysql.findListBeanByArray(sql, clazz, 1);
    }

    /**
     * 根据ID查找一个可用的对象
     *
     * @param clazz
     * @param id
     * @param <T>
     * @return
     */
    public <T extends Model> T findEnabledBean(Class<T> clazz, ID id) {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        SQLStrBuilder ssb = SQLFactory.builder();
        String sql = ssb.selectAllByColumns(sbb.getTableName(), "enabled", "id");
        return mysql.findBeanByArray(sql, clazz, 1, id);
    }

    /**
     * 查询分页
     *
     * @param page        分页的page对象,{@link org.templateproject.pojo.page.Page}
     * @param sql         执行查询的sql语句不带where部分
     * @param <PageModel> 当前页面中数据集合的泛型类型
     * @return 包含当前查询对象类型的的List的当前页面内容的Page
     */
    public <PageModel extends BaseEntity> Page<PageModel> findPagination(Page<PageModel> page, Class<PageModel> pageModelClass, String sql, TableQuery tableQuery) {

        String finalSQL = Pagination.getSql(sql, tableQuery);
        Map<String, Object> paramsMap = Pagination.getParamsMap(tableQuery);

        //因为此处的Page中的排序OrderDirection和OrderField与前台BootstrapTable中所传的参数(sort,order)不一致
        //所以此处需要从QueryBO中拿取(sort和order)来设置到page中，以及分页大小和所要查询的页码
        page.setPageNo(Pagination.getPageNo(tableQuery));
        page.setPageSize(Pagination.getPageSize(tableQuery));

        return mysql.findPageListBeanByMap(finalSQL, pageModelClass, page, paramsMap);
    }

}
