package org.templateproject.oauth2.page.department;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.entity.OauthDepartment;
import org.templateproject.oauth2.service.DepartmentService;
import org.templateproject.oauth2.support.BaseRestController;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.oauth2.support.pojo.bo.DepartmentBO;
import org.templateproject.oauth2.support.pojo.vo.DepartmentVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * 部门REST控制层
 * Created by Liurongqi on 2017/7/12.
 */
@RestController
@RequestMapping("/department/api")
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
        if (StringUtils.isNotEmpty(id)) {
            return departmentService.findDepartmentTree(Integer.parseInt(id));
        } else {
            return departmentService.findDepartmentTree(Integer.MIN_VALUE + 1);
        }
    }


    @RequestMapping("add")
    public R add(OauthDepartment oauthDepartment) throws Exception {
        if (departmentService.save(oauthDepartment))
            return R.ok("添加成功");
        else return R.error("添加失败");
    }

    @RequestMapping("edit")
    public R edit(OauthDepartment oauthDepartment) throws Exception {
        if (departmentService.edit(oauthDepartment))
            return R.ok("编辑成功");
        else return R.error("编辑失败");

    }


}
