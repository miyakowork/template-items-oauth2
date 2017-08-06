package org.templateproject.oauth2.page;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.support.BaseRestController;
import org.templateproject.oauth2.support.TemplateController;
import org.templateproject.oauth2.support.pojo.bo.SelectBO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by Wuwenbin on 2017/8/1.
 */
@RestController
public class SupportRestController extends TemplateController {

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
}
