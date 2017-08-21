package org.templateproject.items.oauth2.page;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.items.oauth2.entity.ISystemModule;
import org.templateproject.items.oauth2.service.SystemModuleService;
import org.templateproject.items.oauth2.support.TemplateController;
import org.templateproject.items.oauth2.support.pojo.bo.SelectBO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by Wuwenbin on 2017/8/1.
 */
@RestController
@RequestMapping("oauth2")
public class SupportRestController extends TemplateController {

    private SystemModuleService systemModuleService;

    @Autowired
    public void setSystemModuleService(SystemModuleService systemModuleService) {
        this.systemModuleService = systemModuleService;
    }

    /**
     * 公共的下拉框搜索对象的值
     *
     * @return map
     */
    @RequestMapping("/common/select")
    public Map<Object, Object> searchSelect() {
        List<SelectBO> selectBOs = new ArrayList<>();
        SelectBO selectBO1 = SelectBO.create("1", "可用");
        selectBOs.add(selectBO1);
        SelectBO selectBO2 = SelectBO.create("0", "不可用");
        selectBOs.add(selectBO2);
        return searchSelect(selectBOs);
    }

    /**
     * 表格中使用系统模块查询的下拉框操作
     *
     * @return 下拉框对象
     */
    @RequestMapping("/systemModule/select")
    public Map<Object, Object> systemModuleSelect() {
        List<SelectBO> selectBOs = new ArrayList<>();
        List<ISystemModule> systemModules = systemModuleService.findEnabledListBean(ISystemModule.class);
        for (ISystemModule systemModule : systemModules) {
            SelectBO selectBO = SelectBO.create(systemModule.getSystemCode(), systemModule.getName());
            selectBOs.add(selectBO);
        }
        return searchSelect(selectBOs);
    }
}
