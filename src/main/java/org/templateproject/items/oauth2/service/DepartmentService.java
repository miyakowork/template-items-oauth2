package org.templateproject.items.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.items.oauth2.entity.IDepartment;
import org.templateproject.items.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.items.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.items.oauth2.support.pojo.bo.DepartmentBO;
import org.templateproject.items.oauth2.support.pojo.bo.ZTreeBO;
import org.templateproject.items.oauth2.support.pojo.vo.DepartmentVO;
import org.templateproject.pojo.page.Page;

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
public class DepartmentService extends SimpleBaseCrudService<IDepartment, Integer> {

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
     * @return 部门的zTree
     */
    public List<ZTreeBO> department2ZTree(Collection<IDepartment> departments) {
        List<ZTreeBO> zTreeList = new LinkedList<>();
        for (IDepartment next : departments) {
            ZTreeBO zTree = new ZTreeBO();
            zTree.setId(next.getId().toString());
            zTree.setpId(next.getParentId().toString());
            zTree.setName(next.getName());
            zTree.setOpen(next.getParentId() == 0);
            zTree.setisParent(checkIsParent(next.getId()));  //根据是否有子节点设置isParent属性
            zTreeList.add(zTree);
        }
        return zTreeList;
    }


    /**
     * zTree形式的菜单列表
     * 根据父节点id生成一级子节点的zTree
     *
     * @return zTree树
     */
    public List<IDepartment> findEnabledDepartments(String depId) {
        List<IDepartment> departments = mysql.findListBeanByArray(sql(), IDepartment.class);
        if ("0".equalsIgnoreCase(depId))//如果需要显示部门根节点，则传递参数id=0即可
            departments.add(IDepartment.root());
        return departments;
    }


    /**
     * 根据节点id判断指定节点是否为父节点
     *
     * @param id 部门id
     * @return 是否有子节点
     */
    public boolean checkIsParent(int id) {
        long count = mysql.queryNumberByArray(sql(), Long.class, id);
        return count != 0;
    }

}
