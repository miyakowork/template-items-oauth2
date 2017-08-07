package org.templateproject.oauth2.service;

import jodd.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.lang.TP;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ServiceConsts;
import org.templateproject.oauth2.entity.OauthPrivilegePage;
import org.templateproject.oauth2.entity.OauthResourceModule;
import org.templateproject.oauth2.entity.OauthSystemModule;
import org.templateproject.oauth2.page.privilegepage.ZTreeBO;
import org.templateproject.oauth2.service.base.AbstractBaseCrudService;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.pojo.bo.PrivilegePageBo;
import org.templateproject.oauth2.support.pojo.vo.PrivilegePageVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;

import java.util.*;

/**
 * Created by zhangteng on 2017/7/19.
 * 页面资源表 service
 */
@Service
@Transactional
public class PrivilegePageService extends SimpleBaseCrudService<OauthPrivilegePage,Integer> {

    private ResModuleService resModuleService;


    @Autowired
    public void setResModuleService(ResModuleService resModuleService) {
        this.resModuleService = resModuleService;
    }



    /*
    * 根据条件获取页面权限表中的记录
    * */
    public Page<PrivilegePageVO> list(Page<PrivilegePageVO> page, PrivilegePageBo privilegePageBo) throws Exception {

        String sql = "select topp.*,torm.name,tor.name as resourceName from T_OAUTH_PRIVILEGE_PAGE topp LEFT JOIN T_OAUTH_RESOURCE_MODULE torm ON topp.RESOURCE_MODULE_ID=torm.id LEFT JOIN T_OAUTH_RESOURCE tor ON topp.RESOURCE_ID=tor.id  WHERE 1=1 ";

        //判断排序是否为空
        String orderSQL = "";
        if (StringUtil.isNotEmpty(page.getOrderField())) {
            orderSQL = TP.placeholder.format(" ORDER BY {} {} ", page.getOrderField(), page.getOrderDirection());
        }

        //如果参数不为空
        Map<String, Object> pMap = new HashMap<>();
        if (StringUtils.isNotEmpty(privilegePageBo.getModuleId())) {
            sql += " AND  RESOURCE_MODULE_ID=:moduleId";
            pMap.put("moduleId", privilegePageBo.getModuleId());
        }

        if (StringUtils.isNotEmpty(privilegePageBo.getName())) {
            sql += " AND  torm.name like :name";
            pMap.put("name", "%" + privilegePageBo.getName() + "%");
        }

        if (privilegePageBo.getEnabled() != null) {
            sql += " AND topp.ENABLED = :enabled1  ";
            pMap.put("enabled1", privilegePageBo.getEnabled());
        }

        if(StringUtils.isNotEmpty(privilegePageBo.getResourceName())){
            sql += " AND tor.name like :resourceName  ";
            pMap.put("resourceName","%"+privilegePageBo.getResourceName()+"%");
        }

        return findPage(page, PrivilegePageVO.class, sql + orderSQL, pMap);
    }

    /*
    * 添加页面权限
    * */

    public boolean save(OauthPrivilegePage oauthPrivilegePage) throws Exception {

        SQLBeanBuilder sqlBeanBuilder = SQLFactory.builder(OauthPrivilegePage.class);
        String insertSQL = sqlBeanBuilder.insertRoutersWithoutPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.CREATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER
        );
        oauthPrivilegePage.preInsert();
        return h2Dao.executeBean(insertSQL, oauthPrivilegePage) > 0;

    }


    /*
    * 修改页面权限
    * */
    public boolean edit(OauthPrivilegePage oauthPrivilegePage) throws Exception {
        SQLBeanBuilder sbb = new SQLBeanBuilder(OauthPrivilegePage.class);
        String updateSQL = sbb.updateRoutersByPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER);
        oauthPrivilegePage.preUpdate();

        h2Dao.executeBatchByArrayBeans(updateSQL, oauthPrivilegePage);
        return true;
    }

    /**
     * zTree形式的菜单列表
     * 根据父节点id生成一级子节点的zTree
     *
     * @return ztree树
     */
    public List<ZTreeBO> findResourceModulTree() throws Exception {

        List<ZTreeBO> list = privilegepageSystemCodeToZtree();

        list.addAll(privilegepageToZtree());

        return list;
    }

    /*
       * 将数据库系统编码插入树
       * */
    private List<ZTreeBO> privilegepageSystemCodeToZtree()
            throws Exception {
        List<OauthSystemModule> oauthSystemModules = selectSystemCode();
        List<ZTreeBO> zTreeList = new LinkedList<>();
        for (OauthSystemModule next : oauthSystemModules) {
            ZTreeBO ztree = new ZTreeBO();
            ztree.setId(next.getSystemCode());
            ztree.setpId("0");
            ztree.setName(next.getName());
            ztree.setOpen(true);
            ztree.setNocheck(true);
            zTreeList.add(ztree);
        }
        return zTreeList;
    }


    /*
    * 将数据库表的记录根据系统编码的属性输入到树
    * */
    private List<ZTreeBO> privilegepageToZtree() throws
            Exception {
        Collection<OauthResourceModule> oauthResourceModules = resModuleService.findList(OauthResourceModule.class);
        List<ZTreeBO> zTreeList = new LinkedList<>();
        for (OauthResourceModule next :
                oauthResourceModules) {
            ZTreeBO ztree = new ZTreeBO();
            ztree.setId(next.getId() + "");
            ztree.setpId(next.getSystemCode());
            ztree.setName(next.getName());
            ztree.setOpen(true);
            zTreeList.add(ztree);
        }
        return zTreeList;
    }

    /*
    *
    * 消除重复查询表中所有的系统编码的类型，为获取树
    * */
    public List<OauthSystemModule> selectSystemCode() {

        String sql = "Select distinct (torm.SYSTEM_CODE),tosm.name  from " +
        "T_OAUTH_RESOURCE_MODULE torm " + "LEFT JOIN T_OAUTH_SYSTEM_MODULE tosm ON   " + "torm.SYSTEM_CODE=tosm.SYSTEM_CODE ";

        List<OauthSystemModule> li =
                h2Dao.findListBeanByArray(sql, OauthSystemModule.class);

        return li;
    }


}
