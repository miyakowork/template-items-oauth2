package org.templateproject.oauth2.page.department;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.entity.OauthDepartment;
import org.templateproject.oauth2.service.DepartmentService;
import org.templateproject.oauth2.support.TemplateController;
import org.templateproject.oauth2.support.pojo.bo.DepartmentBO;
import org.templateproject.oauth2.support.pojo.vo.DeptVO;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 部门REST控制层
 * Created by Liurongqi on 2017/7/12.
 */
@RestController
@RequestMapping("/department/api")
public class DepartmentRestController extends TemplateController {

        private DepartmentService departmentService;

        @Autowired
        public void setDepartmentService(DepartmentService departmentService) {
                this.departmentService = departmentService;
        }

        @RequestMapping("list")
        public BootstrapTable<DeptVO> departments(Page<DeptVO> page, DepartmentBO departmentBo) {
                page = departmentService.getDepartmentPage(departmentBo, queryParam2Page(departmentBo, page));
                List<DeptVO> result = page.getTResult();
                return new BootstrapTable<>(page.getTotalCount(), result);
        }

        /**
         * 生成根节点对应一级zTree
         *
         * @return json R
         */
        @RequestMapping("selectDepartment")
        public R selectDepartment(Page<OauthDepartment> page, HttpServletRequest request) {
                try {
                        return R.ok(departmentService.findDepartmentTree(page, request));
                } catch (Exception e) {
                        return R.error("获取数据异常");
                }
        }


        @RequestMapping("selectDepartmentTree")
        public R selectDepartmentTree() {
                try {
                        return R.ok(departmentService.findDepartmentTree());
                } catch (Exception e) {
                        return R.error("获取数据异常");
                }
        }

        /**
         * 生成指定节点的下级zTree
         *
         * @param page
         * @param request
         * @return
         */
        @RequestMapping("selectPartDepartment")
        public List<ZTreeBO> selectPartDepartment(Page<OauthDepartment> page, HttpServletRequest request) {
                try {
                        return departmentService.findDepartmentTree(page, request);
                } catch (Exception e) {
                        return null;
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
