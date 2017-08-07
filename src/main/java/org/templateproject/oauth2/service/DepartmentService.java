package org.templateproject.oauth2.service;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.lang.TP;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ServiceConsts;
import org.templateproject.oauth2.entity.OauthDepartment;
import org.templateproject.oauth2.page.department.ZTreeBO;
import org.templateproject.oauth2.service.base.AbstractBaseCrudService;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.pojo.bo.DepartmentBO;
import org.templateproject.oauth2.support.pojo.vo.DeptVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 部门管理service
 * Created by Liurongqi on 2017/7/12.
 */
@Service
@Transactional
public class DepartmentService extends SimpleBaseCrudService<OauthDepartment, Integer> {

    /**
     * 调用findPage()返回Page
     *
     * @param departmentBO 页面查询对象
     * @return 当前Page页
     */
    public Page<DeptVO> getDepartmentPage(DepartmentBO departmentBO, Page<DeptVO> page) {
        String sql = "SELECT tod.*, tod1.name as parent_name , tou1.username as create_name, tou2.username as update_name"+
                " FROM t_oauth_user tou1,t_oauth_user tou2 ,t_oauth_department tod"+
                " left join t_oauth_department tod1 on tod1.id = tod.parent_id"+
                " WHERE tod.create_user = tou1.id AND tod.update_user = tou2.id";
        String orderSQL = "";
        //先组装order部分
        if (StringUtils.isNotEmpty(page.getOrderField()) && StringUtils.isNotEmpty(page.getOrderDirection())) {
            orderSQL = TP.placeholder.format(" ORDER BY {} {}", page.getOrderField(), page.getOrderDirection());
        }

//        if (departmentBO.getEnabled()!=null){
//            sql += " AND tod.enabled = "+ departmentBO.getEnabled();
//        }

        //如果参数不为空
        if (departmentBO.getParentId() != null && StringUtils.isNotEmpty(departmentBO.getName())) {
            sql += " AND tod.name LIKE :name AND tod.parent_id = :pid" + orderSQL;
            Map<String, Object> pMap = new HashMap<>();
            pMap.put("name", "%" + departmentBO.getName() + "%");
            pMap.put("pid", departmentBO.getParentId());
            return findPage(page, DeptVO.class, sql, pMap);
        } else if (StringUtils.isNotEmpty(departmentBO.getName())) {
            sql += " AND tod.name LIKE :name" + orderSQL;
            Map<String, Object> pMap = new HashMap<>();
            pMap.put("name", "%" + departmentBO.getName() + "%");
            return findPage(page, DeptVO.class, sql, pMap);
        } else if (departmentBO.getParentId() != null) {
            sql += " AND tod.parent_id = ?" + orderSQL;
            return findPage(page, DeptVO.class, sql, departmentBO.getParentId());
        } else {
            sql += orderSQL;
            return findPage(page, DeptVO.class, sql);
        }
    }

    /**
     * 將department列表转为zTree树对象
     *
     * @param departments 部门集合对象
     * @return 部门的ztree
     */
    private List<ZTreeBO> departmentToZtree(Collection<OauthDepartment> departments) throws Exception{
        List<ZTreeBO> zTreeList = new LinkedList<>();
        for (OauthDepartment next : departments) {
            ZTreeBO ztree = new ZTreeBO();
            ztree.setId(next.getId().toString());
            ztree.setpId(next.getParentId().toString());
            ztree.setName(next.getName());
            ztree.setOpen(true);

            //根据是否有子节点设置isParent属性
            if (checkIsParent(next.getId())){
                ztree.setisParent(true);
            }else{
                ztree.setisParent(false);
            }
            zTreeList.add(ztree);
        }
        return zTreeList;
    }


    /**
     * 非异步加载时生成zTree
     * @return
     * @throws Exception
     */
    public List<ZTreeBO> findDepartmentTree() throws Exception{
        List<OauthDepartment> departments = (List<OauthDepartment>) findList(OauthDepartment.class);
        departments.add(OauthDepartment.root());
        return this.departmentToZtree(departments);

    }

    /**
     * zTree形式的菜单列表
     * 根据父节点id生成一级子节点的zTree
     * @return ztree树
     */
    public List<ZTreeBO> findDepartmentTree(Page<OauthDepartment> page, HttpServletRequest request)throws Exception {
        int pId = Integer.parseInt(request.getParameter("id") );
        List<OauthDepartment> departments = findChildList(pId);
        if (0 == pId){
            departments.add(OauthDepartment.root());
        }
        return this.departmentToZtree(departments);
    }

    /**
     * 获取指定节点的子节点
     * @param id
     * @return
     */
    public List<OauthDepartment> findChildList(int id){
        String sql = "SELECT * FROM t_oauth_department tod WHERE 1=1 AND tod.parent_id  = ?";
        return h2Dao.findListBeanByArray(sql,OauthDepartment.class,id);
    }

    /**
     * 根据节点id判断指定节点是否为父节点
     * @param id
     * @return
     * @throws Exception
     */
    public  boolean checkIsParent(int id) throws Exception{
        String sql = "SELECT COUNT(*) FROM t_oauth_department tod WHERE 1=1 AND tod.parent_id  = ?";
        long count = h2Dao.queryNumberByArray(sql,Long.class,id);
        return count!=0;
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
