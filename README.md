>1、可作为快速开发框架进行二次开发使用
---
>2、亦可作为单独的基础管理平台使用（token方式）

## 项目说明
+ JDK8以上、Mysql5.5以上、Maven3
+ 项目采用SpringBoot构建，以「Shiro」、「Ehcache」、「template-modules-jpa」和「template-modules-pagination」等为辅开发的一套权限管理认证中心，上手即用。
+ 集成并且合并了「BootstrapTable」、「LayTable」两个强大的table操控界面的前后台数据交互逻辑。只需简单单几行api操作，即可完成对一张表的操作。
+ 其中「BootstrapTable」之中同时集成了表格列的文字模糊搜索、下拉框搜索、以及日期搜索（包括日期范围，使用layDate插件），以上搜索都为服务器同步。
+ 前端表格的html和js大部分已使用Vue封装成组件形式，开发者只需传入参数使用vue组件即可完成页面的编写。

## 项目特点
+ 支持多个系统的操作，即多个用户和多个系统使用此一套系统即可完成。
+ 系统权限以及细化为url，每一个请求即都是权限操作（可配置），页面权限最细精度为按钮以及表格列。除业务权限之外，可以满足所有需求。
+ 灵活的权限控制，资源与权限自定义组，菜单也可，同时支持自定义，非其他普通权限管理系统的与url绑定的，用户完全可自定义一套菜单（在已有权限资源的基础上），可完全自定义。、
+ 有SQL防注入功能、HTML字符过滤，以及XSS防范等处理。

## 技术支持/选型
+ 基础构建：SpringBoot 1.5.8.RELEASE
+ 权限框架：Shiro 1.3.2
+ 持久层：[template-modules-jpa](https://github.com/miyakowork/template-boot-modules/tree/master/template-modules-jpa)（NamedParameterJdbcTemplate的高级处理封装）
+ UI：SmartAdmin(Ajax) + Vue2 + Jquery
+ 日志管理：SLF4J 1.7、Log4j
+ 数据库连接池：[]druid-spring-boot-starter](https://github.com/alibaba/druid/tree/master/druid-spring-boot-starter)

## 系统正在进一步完善中
+ 2017年8月28日：目前已完成第一版本开发，可以作为可以使用的版本，后续将继续完善跟进，文档也将一并放出

## 系统预览图
+ dashboard首页
![dashboard首页](https://github.com/miyakowork/template-items-oauth2/blob/master/images/dashboard.png)

