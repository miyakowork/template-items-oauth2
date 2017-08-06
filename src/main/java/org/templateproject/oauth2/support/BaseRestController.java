package org.templateproject.oauth2.support;


import org.templateproject.oauth2.entity.base.BaseEntity;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.pojo.page.Page;

import java.util.List;

/**
 * 一些基本的操作交互控制层
 * 包含页面数据list显示以及查询、添加、删除、修改/编辑操作
 * Created by Wuwenbin on 2017/7/31.
 */
public class BaseRestController extends TemplateController {

        /**
         * 后台返回的page参数返回为BootstrapTable的数据模型
         *
         * @param page     page
         * @param <Entity> Entity
         * @return BootstrapTable
         */
        protected <Entity extends BaseEntity> BootstrapTable<Entity> bootstrapTable(Page<Entity> page) {
                List<Entity> result = page.getTResult();
                return new BootstrapTable<>(page.getTotalCount(), result);
        }

}
