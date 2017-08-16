package org.templateproject.items.oauth2.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.items.oauth2.entity.IPrivilegePage;
import org.templateproject.items.oauth2.entity.IResourceModule;
import org.templateproject.items.oauth2.entity.ISystemModule;
import org.templateproject.items.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.items.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.items.oauth2.support.pojo.bo.PrivilegePageBo;
import org.templateproject.items.oauth2.support.pojo.bo.ZTreeBO;
import org.templateproject.items.oauth2.support.pojo.vo.PrivilegePageVO;
import org.templateproject.pojo.page.Page;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by zhangteng on 2017/7/19.
 * 页面资源表 service
 */
@Service
@Transactional
@SqlMapper("privilege_page")
public class PrivilegePageService extends SimpleBaseCrudService<IPrivilegePage, Integer> {

    private ResModuleService resModuleService;

    @Autowired
    public void setResModuleService(ResModuleService resModuleService) {
        this.resModuleService = resModuleService;
    }


    /**
     * 根据菜单模块查询此模块下对应的所有页面级权限
     *
     * @param page
     * @param privilegePageBo
     * @return
     * @throws Exception
     */
    public Page<PrivilegePageVO> findPrivilegePagePage(Page<PrivilegePageVO> page, PrivilegePageBo privilegePageBo) throws Exception {
        return findPagination(page, PrivilegePageVO.class, sql(), privilegePageBo);
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
        List<ISystemModule> iSystemModules = selectSystemCode();
        List<ZTreeBO> zTreeList = new LinkedList<>();
        for (ISystemModule next : iSystemModules) {
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
        Collection<IResourceModule> iResourceModules = resModuleService.findListBean(IResourceModule.class);
        List<ZTreeBO> zTreeList = new LinkedList<>();
        for (IResourceModule next :
                iResourceModules) {
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
    public List<ISystemModule> selectSystemCode() {

        String sql = "Select distinct (torm.SYSTEM_CODE),tosm.name  from " +
                "T_OAUTH_RESOURCE_MODULE torm " + "LEFT JOIN T_OAUTH_SYSTEM_MODULE tosm ON   " + "torm.SYSTEM_CODE=tosm.SYSTEM_CODE ";

        List<ISystemModule> li =
                mysql.findListBeanByArray(sql, ISystemModule.class);

        return li;
    }


}
