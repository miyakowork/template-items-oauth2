package org.templateproject.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ServiceConsts;
import org.templateproject.oauth2.entity.OauthDepartment;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.oauth2.support.pojo.bo.DepartmentBO;
import org.templateproject.oauth2.support.pojo.bo.ZTreeBO;
import org.templateproject.oauth2.support.pojo.vo.DepartmentVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

/**
 * 部门管理service
 * Created by Wuwenbin on 2017/08/07.
 */
@Service
@Transactional
@SqlMapper("department")
public class DepartmentService extends SimpleBaseCrudService<OauthDepartment, Integer> {

    /**
     * 调用findPage()返回Page
     *
     * @param departmentBO 页面查询对象
     * @return 当前Page页
     */
    public Page<DepartmentVO> findDepartmentPage(DepartmentBO departmentBO, Page<DepartmentVO> page) {
        return findPagination(page, DepartmentVO.class, sql(), departmentBO);
    }

    /**
     * 將department列表转为zTree树对象
     *
     * @param departments 部门集合对象
     * @return 部门的ztree
     */
    private List<ZTreeBO> department2ZTree(Collection<OauthDepartment> departments) {
        List<ZTreeBO> zTreeList = new LinkedList<>();
        for (OauthDepartment next : departments) {
            ZTreeBO ztree = new ZTreeBO();
            ztree.setId(next.getId().toString());
            ztree.setpId(next.getParentId().toString());
            ztree.setName(next.getName());
            ztree.setOpen(true);

            //根据是否有子节点设置isParent属性
            if (checkIsParent(next.getId())) {
                ztree.setisParent(true);
            } else {
                ztree.setisParent(false);
            }
            zTreeList.add(ztree);
        }
        return zTreeList;
    }


    /**
     * zTree形式的菜单列表
     * 根据父节点id生成一级子节点的zTree
     *
     * @return ztree树
     */
    public List<ZTreeBO> findDepartmentTree() {
        String sql = "SELECT * FROM t_oauth_department tod WHERE tod.ENABLED = 1";
        List<OauthDepartment> departments = h2Dao.findListBeanByArray(sql, OauthDepartment.class);
        return this.department2ZTree(departments);
    }


    /**
     * 根据节点id判断指定节点是否为父节点
     *
     * @param id
     * @return
     * @throws Exception
     */
    public boolean checkIsParent(int id) {
        String sql = "SELECT COUNT(*) FROM t_oauth_department tod WHERE 1=1 AND tod.parent_id  = ?";
        long count = h2Dao.queryNumberByArray(sql, Long.class, id);
        return count != 0;
    }

    /**
     * 新增部门数据
     *
     * @param oauthDepartment 新增的bu部门对象
     * @return 新增是否成功
     * @throws Exception 保存异常
     */
    public boolean save(OauthDepartment oauthDepartment) throws Exception {
        SQLBeanBuilder sqlBeanBuilder = SQLFactory.builder(OauthDepartment.class);
        String insertSQL = sqlBeanBuilder.insertRoutersWithoutPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.CREATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER
        );
        oauthDepartment.preInsert();
        return h2Dao.executeBean(insertSQL, oauthDepartment) > 0;
    }

    /**
     * 编辑部门数据
     *
     * @param oauthDepartment 编辑对象
     * @return 编辑部门对象
     * @throws Exception 编辑过程中出现的异常
     */
    public boolean edit(OauthDepartment oauthDepartment) throws Exception {
        SQLBeanBuilder sqlBeanBuilder = SQLFactory.builder(OauthDepartment.class);
        String updateSQL = sqlBeanBuilder.updateRoutersByPk(
                ServiceConsts.DEFAULT_ROUTER,
                CommonConsts.UPDATE_ROUTER,
                CommonConsts.ENABLED_ROUTER,
                CommonConsts.ORDER_ROUTER,
                CommonConsts.REMARK_ROUTER
        );
        oauthDepartment.preUpdate();
        return h2Dao.executeBean(updateSQL, oauthDepartment) > 0;
    }
}
