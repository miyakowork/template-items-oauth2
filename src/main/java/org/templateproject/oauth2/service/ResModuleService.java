package org.templateproject.oauth2.service;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.lang.TP;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ServiceConsts;
import org.templateproject.oauth2.entity.OauthResourceModule;
import org.templateproject.oauth2.service.base.AbstractBaseCrudService;
import org.templateproject.oauth2.support.pojo.bo.ResModuleBo;
import org.templateproject.oauth2.support.pojo.bo.ZTreeBO;
import org.templateproject.oauth2.support.pojo.vo.ResourceModuleVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;

import java.util.*;

/**
 * 继承AbstractBaseCrudService
 * Created by tuchen on 2017/7/12.
 */
@Service
@Transactional
public class ResModuleService extends AbstractBaseCrudService<OauthResourceModule, Integer> {


    /**
     * 通过名称模糊 查询Page
     *
     * @param page
     * @param resModuleBo
     * @return
     */
    public Page<ResourceModuleVO> findPageByName(Page<ResourceModuleVO> page, ResModuleBo resModuleBo) {
        //pMap 用来精确查询传值
        Map<String, Object> pMap = new HashMap<>();
        //查询
        String sql = "SELECT torm.*,tou1.username as create_user_name ,tou2.username as update_user_name FROM " +
                " t_oauth_resource_module torm ,t_oauth_user tou1,t_oauth_user tou2 " +
                " where torm.CREATE_USER=tou1.id and torm.update_user =tou2.id ";
        String orderSQL = "";

        //先组装order部分
        if (StringUtils.isNotEmpty(page.getOrderField()) && StringUtils.isNotEmpty(page.getOrderDirection())) {
            orderSQL = TP.placeholder.format(" ORDER BY {} {}", page.getOrderField(), page.getOrderDirection());
        }
        //判断是否可用
        if (resModuleBo.getSelectEnabled() != null) {
            sql += " AND torm.enabled =" + resModuleBo.getSelectEnabled() + " ";
        }
        //如果Name不为空 模糊查询
        if (StringUtils.isNotEmpty(resModuleBo.getName())) {
            sql += "AND torm.name LIKE :name ";
            pMap.put("name", "%" + resModuleBo.getName() + "%");
        }
        //如果sysTemCode不为空 模糊查询
        if (StringUtils.isNotEmpty(resModuleBo.getSystemCode())) {
            sql += "AND torm.SYSTEM_CODE LIKE :SYSTEM_CODE ";
            pMap.put("SYSTEM_CODE", "%" + resModuleBo.getSystemCode() + "%");
        }

        sql += orderSQL;
        return findPage(page, ResourceModuleVO.class, sql, pMap);


    }

    /**
     * 添加对象
     *
     * @param oauthResourceModule
     * @return
     * @throws Exception
     */

    public boolean save(OauthResourceModule oauthResourceModule) throws Exception {
        //构建SQL工厂
        SQLBeanBuilder builder = SQLFactory.builder(OauthResourceModule.class);
        //插入语句
        String sql = builder.insertRoutersWithoutPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.CREATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER);
        //执行语句
        oauthResourceModule.preInsert();
        return h2Dao.executeBean(sql, oauthResourceModule) == 1;
    }

    /**
     * 编辑对象
     *
     * @param oauthResourceModule
     * @return
     * @throws Exception
     */
    public boolean edit(OauthResourceModule oauthResourceModule) throws Exception {
        //构建SQL工厂
        SQLBeanBuilder builder = SQLFactory.builder(OauthResourceModule.class);
        //通过主键 更新所传递的参数
        String sql = builder.updateRoutersByPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER);
        //执行语句

        oauthResourceModule.preUpdate();
        return h2Dao.executeBean(sql, oauthResourceModule) == 1;
    }

    /**
     * 根据前台传递来的 字符串数组(id)执行删除语句
     *
     * @param _ids
     * @return
     * @throws Exception
     */
    public void del(String _ids) throws Exception {
        String[] ids = _ids.split(",");
        Collection<Integer> idIntegers = new ArrayList<>(ids.length);
        for (String id : ids) {
            idIntegers.add(Integer.valueOf(id));
        }

        delete(idIntegers, OauthResourceModule.class);
    }


    /**
     * 查询ResModuleTree
     * @return
     * @throws Exception
     */
    public List<ZTreeBO> findResModuleTree(String roleId,String resModuleId) throws Exception {
        //获取id
        int role_Id = Integer.parseInt(roleId);
        List<ZTreeBO> zTreeBO;

        //返回资源模块表
        Collection<OauthResourceModule> list = findList(OauthResourceModule.class);

        //将资源模块转为ZTree
        zTreeBO = resModuleToZtree(list);
        return zTreeBO;
    }



    /**
     *  將resModule列表转为zTree树对象
     * @param oauthResourceModules
     * @return
     * @throws Exception
     */
    private List<ZTreeBO> resModuleToZtree(Collection<OauthResourceModule> oauthResourceModules) throws Exception {
        List<ZTreeBO> zTreeList = new LinkedList<>();
        //将角色转换成zTree
        for (OauthResourceModule resModule : oauthResourceModules) {
            ZTreeBO ztree = new ZTreeBO();
            ztree.setId(resModule.getId().toString());
            ztree.setpId("0");
            ztree.setisParent(true);
            ztree.setName(resModule.getName());
            ztree.setOpen(true);
            //增加ztree
            zTreeList.add(ztree);
        }
        return zTreeList;
    }




}
