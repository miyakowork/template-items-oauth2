package org.templateproject.oauth2.page.department;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.entity.OauthDepartment;
import org.templateproject.oauth2.service.DepartmentService;
import org.templateproject.oauth2.support.BaseRestController;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.oauth2.support.pojo.bo.DepartmentBO;
import org.templateproject.oauth2.support.pojo.bo.ZTreeBO;
import org.templateproject.oauth2.support.pojo.vo.DepartmentVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * 部门REST控制层
 * Created by Liurongqi on 2017/7/12.
 */
@RestController
@RequestMapping("oauth2/department/api")
public class DepartmentRestController extends BaseRestController {

    private DepartmentService departmentService;

    @Autowired
    public void setDepartmentService(DepartmentService departmentService) {
        this.departmentService = departmentService;
    }


    /**
     * 部门页面数据
     *
     * @param page         page
     * @param departmentBo 部门查询字段
     * @return page
     */
    @RequestMapping("list")
    public BootstrapTable<DepartmentVO> departments(Page<DepartmentVO> page, DepartmentBO departmentBo) {
        page = departmentService.findDepartmentPage(departmentBo, queryParam2Page(departmentBo, page));
        return bootstrapTable(page);
    }

    /**
     * 生成根节点对应一级zTree
     *
     * @return json R
     */
    @RequestMapping("selectDepartment")
    public List<ZTreeBO> selectDepartment(String id) {
        return departmentService.department2ZTree(departmentService.findEnabledDepartments(id));
    }

    /**
     * 添加新的部门
     *
     * @param oauthDepartment 新部门对象信息
     * @return R
     * @throws Exception e
     */
    @RequestMapping("add")
    public R add(OauthDepartment oauthDepartment) throws Exception {
        if (departmentService.save(oauthDepartment, OauthDepartment.class))
            return R.ok("添加成功");
        else return R.error("添加失败");
    }

    /**
     * 编辑部门信息
     *
     * @param oauthDepartment 编辑的部门对象
     * @return R
     * @throws Exception e
     */
    @RequestMapping("edit")
    public R edit(OauthDepartment oauthDepartment) throws Exception {
        if (departmentService.edit(oauthDepartment, OauthDepartment.class))
            return R.ok("编辑成功");
        else return R.error("编辑失败");

    }


}
