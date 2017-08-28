package org.templateproject.items.oauth2.service.base;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.templateproject.items.oauth2.constant.CommonConsts;
import org.templateproject.items.oauth2.constant.ServiceConsts;
import org.templateproject.items.oauth2.entity.base.BaseEntity;
import org.templateproject.items.oauth2.support.annotation.query.QueryColumn;
import org.templateproject.items.oauth2.support.annotation.query.QueryTable;
import org.templateproject.items.oauth2.support.enumerate.Operator;
import org.templateproject.items.oauth2.support.pojo.BootstrapTableQuery;
import org.templateproject.items.oauth2.support.pojo.MultiSort;
import org.templateproject.lang.TP;
import org.templateproject.pojo.page.Page;
import org.templateproject.tools.sqlgen.entrance.SQLFactory;
import org.templateproject.tools.sqlgen.factory.SQLBeanBuilder;
import org.templateproject.tools.sqlgen.factory.SQLStrBuilder;
import org.templateproject.tools.sqlgen.util.SQLDefineUtils;

import java.lang.reflect.Field;
import java.util.*;

/**
 * 丰富接口的实现类，提供一下额额外的操作方法（接口中未包含的方法）
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
    public boolean save(Model model, Class<Model> clazz) throws Exception {
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
    public boolean edit(Model model, Class<Model> clazz) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        String updateSQL = sbb.updateRoutersByPk(ServiceConsts.DEFAULT_ROUTER, CommonConsts.UPDATE_ROUTER,
                CommonConsts.ENABLED_ROUTER, CommonConsts.ORDER_ROUTER, CommonConsts.REMARK_ROUTER);
        model.preUpdate();
        return mysql.executeBean(updateSQL, model) == 1;

    }

    /**
     * 执行删除的的批量操作
     *
     * @param ids 需要执行删除的值
     * @throws Exception 执行删除过程中发生的异常
     */
    public void deleteBatch(Class<Model> clazz, String[] ids) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        Collection<Map<String, Object>> maps = new ArrayList<>(ids.length);
        for (String id : ids) {
            Map<String, Object> map = new HashMap<>();
            map.put(sbb.getPkField().getName(), id);//是通过id主键来约束的，即 where pk = :id
            maps.add(map);
        }
        String sql = sbb.deleteByPk();
        mysql.executeBatchByCollectionMaps(sql, maps);
    }

    /**
     * 有时候删除并不是一定根据id来删，
     * 也有可能是根据其他唯一性的字段来删除，
     * 这个方法就是根据指定的列来删除某条记录
     *
     * @param columnName  列明
     * @param columnValue 列值
     * @param clazz       记录类型
     * @return 删除条数
     * @throws Exception 删除过程中的异常
     */
    public void delete(String columnName, Object columnValue, Class<? extends BaseEntity> clazz) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        SQLStrBuilder ssb = SQLFactory.builder();
        String sql = ssb.deleteByColumns(sbb.getTableName(), columnName);
        mysql.executeArray(sql, columnValue);
    }


    /**
     * 执行增删改的批量语句的方法
     *
     * @param sql            sql
     * @param constraintName 约束列名字
     * @param ids            删除对象ids
     * @throws Exception e
     */
    public void executeBatch(String sql, String constraintName, String[] ids) throws Exception {
        Collection<Map<String, Object>> maps = new ArrayList<>(ids.length);
        for (String id : ids) {
            Map<String, Object> map = new HashMap<>();
            map.put(constraintName, id);//是通过id主键来约束的，即 where pk = :id
            maps.add(map);
        }
        mysql.executeBatchByCollectionMaps(sql, maps);
    }

    /**
     * 批量禁用（逻辑删除）
     *
     * @param ids
     * @param clazz
     * @param <T>
     * @throws Exception
     */
    public <T extends Model> void disabledBatch(String[] ids, Class<T> clazz) throws Exception {
        SQLBeanBuilder sbb = SQLFactory.builder(clazz);
        SQLStrBuilder ssb = SQLFactory.builder();
        String sql = ssb.updateColumnsByColumnArray(sbb.getTableName(), new String[]{"enabled"}, new String[]{"id"});
        executeBatch(sql, "id", ids);
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
     * 查询分页
     *
     * @param page         分页的page对象,{@link org.templateproject.pojo.page.Page}
     * @param sql          执行查询的sql语句不带where部分
     * @param queryParam   搜索对象，包含多个搜索字段
     * @param <PageModel>  当前页面中数据集合的泛型类型
     * @param <QueryParam> 页面搜索的所有字段的对象，继承于{@link BootstrapTableQuery}
     * @return 包含当前查询对象类型的的List的当前页面内容的Page
     */
    public <PageModel extends BaseEntity, QueryParam extends BootstrapTableQuery> Page<PageModel> findPagination(Page<PageModel> page, Class<PageModel> pageModelClass, String sql, QueryParam queryParam) {

        final String datePickerSplit = "~";

        //默认SQL运算比较对象符为LIKE,如果需要指定其他(如=、!=、>等)则需要使用@QueryColumn中的Operation字段来指定
        final Operator DEFAULT_OPERATE_TYPE = Operator.LIKE;

        // 创建一个存储查询对象参数以及该参数对应值的map
        Map<String, Object> params2Value = new LinkedHashMap<>();
        //创建一个存储查询对象属性值在数据库中对应的表中列中的字段名称的map
        Map<String, String> params2Column = new LinkedHashMap<>();
        //创建一个存储查询对象在SQL语句中的运算符类型默认是LIKE
        Map<String, Operator> params2Operator = new LinkedHashMap<>();

        //因为此处的Page中的排序OrderDirection和OrderField与前台BootstrapTable中所传的参数(sort,order)不一致
        //所以此处需要从QueryBO中拿取(sort和order)来设置到page中，以及分页大小和所要查询的页码
        page.setPageNo(queryParam.pageNo());
        page.setPageSize(queryParam.getLimit());
        page.setOrderDirection(queryParam.getOrder());
        page.setOrderField(queryParam.getSort());

        //获取查询table的表名或者说别名，如果不为空加上sql的转义符(防止关键词冲突)
        String queryTableAliasName = "";
        if (queryParam.getClass().isAnnotationPresent(QueryTable.class)) {
            queryTableAliasName = queryParam.getClass().getAnnotation(QueryTable.class).value();
        }

        //通过Java的反射机制，获取QueryBO中的属性，同时把属性中不为空的值放到查询的param中
        //如果发生异常，则直接返回一个仅仅带有页面基本信息(不包含list结果集)的Page对象
        try {
            Field[] fields = queryParam.getClass().getDeclaredFields();
            for (Field field : fields) {
                String tableNameOrAliasName = queryTableAliasName;
                //设置为true以获取属性的值
                field.setAccessible(true);
                if (!StringUtils.isEmpty(field.get(queryParam))) {
                    String fieldName = field.getName();
                    String columnName = fieldName;
                    Operator operator = DEFAULT_OPERATE_TYPE;

                    //放入搜索的这个字段在数据库中对应的列名称以及比较级别(默认LIKE)，如果和类中属性名一致，则可以不写@QueryColumn
                    if (field.isAnnotationPresent(QueryColumn.class)) {
                        columnName = SQLDefineUtils.java2SQL(field.getAnnotation(QueryColumn.class).value(), field.getName());
                        operator = field.getAnnotation(QueryColumn.class).operation();

                        //上面已经获取了 QueryTable 中的value，即就是表名，代表是下面所有字段都是在这个表中，
                        //如果没写，则代表是sql中默认的那张表
                        //如果类上面定义了@QueryTable并且类中属性上也定义了@QueryColumn，且table有值，优先使用@QueryColumn中的table值
                        String tableNameInColumn = field.getAnnotation(QueryColumn.class).table();
                        if (TP.stringhelper.isNotEmpty(tableNameInColumn)) {
                            tableNameOrAliasName = TP.placeholder.format("`{}`.", tableNameInColumn);
                        } else if (TP.stringhelper.isNotEmpty(tableNameOrAliasName)) {
                            tableNameOrAliasName = TP.placeholder.format("`{}`.", tableNameOrAliasName);
                        }
                    } else {
                        if (TP.stringhelper.isNotEmpty(tableNameOrAliasName))
                            tableNameOrAliasName = TP.placeholder.format("`{}`.", tableNameOrAliasName);
                    }
                    Object filedValue = field.get(queryParam);
                    if (operator.equals(Operator.LIKE)) {
                        filedValue = TP.placeholder.format("%{}%", filedValue);
                    }

                    params2Value.put(fieldName, filedValue);
                    params2Column.put(fieldName, TP.placeholder.format("{}`{}`", tableNameOrAliasName, columnName));
                    params2Operator.put(fieldName, operator);
                }
            }
        } catch (IllegalAccessException e) {
            LOGGER.error("获取查询参数对象失败，反射字段失败，原因：{}", e.getMessage());
            return page;
        }

        //开始拼装SQL语句，先组织WHERE的开始部分
        StringBuilder sqlBuilder = new StringBuilder(sql);
        if (!sql.contains("WHERE") && !sql.contains("where"))
            sqlBuilder = sqlBuilder.append(" WHERE 1=1");

        //先定义一个装查询日期参数的map，循环完之后添加到params2Value这个map中作为最终的查询map
        Map<String, Object> dateMap = new LinkedHashMap<>();

        //随后开始组装where的主体
        for (String key : params2Value.keySet()) {
            String columnName = params2Column.get(key);
            Operator operator = params2Operator.get(key);
            //组装主体where中的匹配等式(LIKE :name 或 = :id)等部分
            String sqlPartWhere = TP.placeholder.format(" AND {} {} :{}", columnName, operator.value(), key);
            if (operator.equals(Operator.BETWEEN)) {
                //因为如果是between and的条件则从前天传过来的值是一个包含逗号的字符串，有2个值
                String keyStart = key.concat("Start");
                String keyEnd = key.concat("End");

                //分别算出对应的值，添加到值Map中
                String valueStartEnd = params2Value.get(key).toString();
                String valueStart = TP.stringhelper.trimEnd(valueStartEnd.split(datePickerSplit)[0]);
                String valueEnd = TP.stringhelper.trimStart(valueStartEnd.split(datePickerSplit)[1]);
                dateMap.put(keyStart, valueStart);
                dateMap.put(keyEnd, valueEnd);

                sqlPartWhere = TP.placeholder.format(" AND ({} BETWEEN :{} AND :{})", columnName, keyStart, keyEnd);
            }
            sqlBuilder.append(sqlPartWhere);
        }

        //添加到最终查询的params2Value的map中
        params2Value.putAll(dateMap);

        //拼装Order部分的SQL语句
        //先查下多列的一起排序的是否有，有就按照这个来
        if (queryParam.getMultiSorts() != null && !queryParam.getMultiSorts().isEmpty()) {
            sqlBuilder.append(" ORDER BY");
            for (MultiSort multiSort : queryParam.getMultiSorts()) {
                sqlBuilder.append(TP.placeholder.format(" `{}` {}", multiSort.getSortName(), multiSort.getSortOrder())).append(",");
            }
        }
        //然后查下只有单列排序的是否存在，没有多列的话就按照单列的排序来
        else if (TP.stringhelper.isNotEmpty(page.getOrderField())) {
            String orderDirection = TP.stringhelper.isNotEmpty(page.getOrderDirection()) ? page.getOrderDirection() : "asc";
            sqlBuilder.append(TP.placeholder.format(" ORDER BY `{}` {}", page.getOrderField(), orderDirection));
        }


        //最后处理一下sql，去除多余的符号
        String finalSQL = sqlBuilder.toString();
        if (finalSQL.endsWith(","))
            finalSQL = finalSQL.substring(0, finalSQL.length() - 1);

        return mysql.findPageListBeanByMap(finalSQL, pageModelClass, page, params2Value);
    }

}
