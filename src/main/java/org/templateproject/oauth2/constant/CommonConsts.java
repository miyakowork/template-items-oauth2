package org.templateproject.oauth2.constant;

/**
 * 全局公用静态常量
 * Created by wuwenbin on 2017/5/31.
 */
public interface CommonConsts {


    /**
     * 所有树最顶级的id
     */
    int ROOT_ID = -1;

    /**
     * 顶级菜单pid
     */
    int ROOT_MENU_ID = -2;

    /**
     * 顶级部门pid
     */
    int ROOT_DEPARTMENT_ID = -3;

    /**
     * 顶级角色pid
     */
    int ROOT_ROLE_ID = -4;


    /**
     * 静态资源起始URI
     */
    String STATIC_RESOURCE_URI = "/static/";

    /**
     * 登录URL页面地址
     */
    String LOGIN_URL = "/login";

    /**
     * 登录路由地址
     */
    String LOGIN_ROUTER = "/login/router";

    /**
     * favicon
     */
    String FAVICON = "/favicon.ico";

    /**
     * 基础实体类中使用的SQLColumn的update字段的router
     */
    int UPDATE_ROUTER = 16099311;

    /**
     * 基础实体类中使用的SQLColumn的create字段的router
     */
    int CREATE_ROUTER = 16099312;

    /**
     * enable字段的router值
     */
    int ENABLED_ROUTER = 1609932;

    /**
     * order字段的router值
     */
    int ORDER_ROUTER = 1609933;

    /**
     * remark字段的router值
     */
    int REMARK_ROUTER = 1609934;
}
