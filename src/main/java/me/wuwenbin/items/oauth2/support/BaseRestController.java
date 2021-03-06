package me.wuwenbin.items.oauth2.support;


import me.wuwenbin.items.oauth2.entity.IUser;
import me.wuwenbin.items.oauth2.entity.base.BaseEntity;
import me.wuwenbin.items.oauth2.service.base.SimpleBaseCrudService;
import me.wuwenbin.items.oauth2.util.UserUtils;
import me.wuwenbin.modules.pagination.model.bootstrap.BootstrapTable;
import me.wuwenbin.modules.pagination.model.layui.LayTable;
import org.templateproject.lang.TP;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

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

    /**
     * 后台返回的怕个参数返回LayTable的数据模型
     *
     * @param page
     * @param <Entity>
     * @return
     */
    protected <Entity extends BaseEntity> LayTable<Entity> layTable(Page<Entity> page) {
        List<Entity> result = page.getTResult();
        return new LayTable<>(page.getTotalCount(), result);
    }

    /**
     * 通用添加控制
     *
     * @param moduleMessage
     * @param service
     * @param entity
     * @param clazz
     * @param <Entity>
     * @param <ID>
     * @param <CrudService>
     * @return
     */
    protected <Entity extends BaseEntity, ID, CrudService extends SimpleBaseCrudService<Entity, ID>> R ajaxDoneAdd(String moduleMessage, CrudService service, Entity entity, Class<Entity> clazz) {
        try {
            if (service.simpleSave(entity, clazz)) {
                moduleMessage = TP.placeholder.format("添加{}成功！", moduleMessage);
                return R.ok(moduleMessage);
            } else {
                moduleMessage = TP.placeholder.format("添加{}失败！", moduleMessage);
                return R.error(moduleMessage);
            }
        } catch (Exception e) {
            moduleMessage = TP.placeholder.format("添加{}异常，异常信息：" + e.getMessage(), moduleMessage);
            LOGGER.error("添加{}异常，异常原因：{}", e);
            return R.error(moduleMessage);
        }
    }

    /**
     * 通用编辑控制
     *
     * @param moduleMessage
     * @param service
     * @param entity
     * @param clazz
     * @param <Entity>
     * @param <ID>
     * @param <CrudService>
     * @return
     */
    protected <Entity extends BaseEntity, ID, CrudService extends SimpleBaseCrudService<Entity, ID>> R ajaxDoneEdit(String moduleMessage, CrudService service, Entity entity, Class<Entity> clazz) {
        try {
            if (service.simpleEdit(entity, clazz)) {
                moduleMessage = TP.placeholder.format("修改{}成功！", moduleMessage);
                return R.ok(moduleMessage);
            } else {
                moduleMessage = TP.placeholder.format("修改{}失败！", moduleMessage);
                return R.error(moduleMessage);
            }
        } catch (Exception e) {
            moduleMessage = TP.placeholder.format("修改{}异常，异常信息：" + e.getMessage(), moduleMessage);
            LOGGER.error("修改{}异常，异常原因：{}", e);
            return R.error(moduleMessage);
        }
    }

    /**
     * 通用批量禁用操作
     *
     * @param moduleMessage
     * @param ids
     * @param service
     * @param clazz
     * @param <Entity>
     * @param <ID>
     * @param <CrudService>
     * @return
     */
    protected <Entity extends BaseEntity, ID, CrudService extends SimpleBaseCrudService<Entity, ID>> R ajaxDoneToggle(String moduleMessage, Object[] ids, CrudService service, Class<Entity> clazz) {
        try {
            service.simpleToggle(ids, clazz);
            moduleMessage = TP.placeholder.format("禁用{}成功！", moduleMessage);
            return R.ok(moduleMessage);
        } catch (Exception e) {
            moduleMessage = TP.placeholder.format("禁用{}异常，异常信息：" + e.getMessage(), moduleMessage);
            LOGGER.error("禁用{}异常，异常原因：{}", e);
            return R.ok(moduleMessage);
        }
    }

    /**
     * 通用批量删除操作
     *
     * @param moduleMessage
     * @param ids
     * @param service
     * @param clazz
     * @param <Entity>
     * @param <ID>
     * @param <CrudService>
     * @return
     */
    protected <Entity extends BaseEntity, ID, CrudService extends SimpleBaseCrudService<Entity, ID>> R ajaxDoneDelete(String moduleMessage, Object[] ids, CrudService service, Class<Entity> clazz) {
        try {
            service.simpleDeletes(clazz, ids);
            moduleMessage = TP.placeholder.format("删除{}成功！", moduleMessage);
            return R.ok(moduleMessage);
        } catch (Exception e) {
            moduleMessage = TP.placeholder.format("删除{}异常，异常信息：" + e.getMessage(), moduleMessage);
            LOGGER.error("删除{}异常，异常原因：{}", e);
            return R.error(moduleMessage);
        }
    }

    protected IUser getUser() {
        return UserUtils.getLoginUser();
    }

    protected Integer getUserId() {
        return getUser().getId();
    }

    protected Integer getDefaultId() {
        return getUser().getDefaultRoleId();
    }

    protected Integer getDeptId() {
        return getUser().getDeptId();
    }

}
