/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : templateitemsoauth2

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2017-08-11 00:05:35
*/

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_oauth_department
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_department`;
CREATE TABLE `t_oauth_department` (
  `id`          INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '部门主键id',
  `name`        VARCHAR(50)      NOT NULL
  COMMENT '名称',
  `parent_id`   INT(11)          NOT NULL
  COMMENT '父级id',
  `enabled`     TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '是否可用',
  `update_date` DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT '修改时间',
  `update_user` INT(11)          NOT NULL
  COMMENT '修改人',
  `create_date` DATETIME         NOT NULL
  COMMENT '创建时间',
  `create_user` INT(11)          NOT NULL
  COMMENT '创建人',
  `order_index` INT(11)          NOT NULL DEFAULT '0'
  COMMENT '排序',
  `remark`      VARCHAR(50)               DEFAULT NULL
  COMMENT '备注',
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 6
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_department
-- ----------------------------
INSERT INTO `t_oauth_department`
VALUES ('1', '江西财经大学', '0', '1', '2017-08-08 20:03:47', '1', '2017-08-08 20:03:47', '1', '0', '江西清华');
INSERT INTO `t_oauth_department`
VALUES ('2', '软件与通信工程学院', '1', '1', '2017-08-08 20:21:34', '1', '2017-08-08 20:21:34', '1', '0', '学院');
INSERT INTO `t_oauth_department`
VALUES ('3', '南昌大学', '0', '1', '2017-08-08 20:21:42', '1', '2017-08-08 20:21:42', '1', '0', '大学');
INSERT INTO `t_oauth_department`
VALUES ('4', '江西师范大学', '0', '1', '2017-08-08 20:21:52', '1', '2017-08-08 20:21:52', '1', '0', '大学');
INSERT INTO `t_oauth_department`
VALUES ('5', '古汉语文学', '3', '1', '2017-08-09 20:06:35', '1', '2017-08-08 20:22:02', '1', '0', '专业');

-- ----------------------------
-- Table structure for t_oauth_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_menu`;
CREATE TABLE `t_oauth_menu` (
  `id`             INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '菜单id',
  `name`           VARCHAR(50)      NOT NULL
  COMMENT '名称',
  `resource_id`    INT(11) UNSIGNED NOT NULL
  COMMENT '资源id',
  `system_code`    VARCHAR(20)      NOT NULL
  COMMENT '系统模块代码',
  `icon`           VARCHAR(50)               DEFAULT NULL
  COMMENT '菜单图标',
  `menu_type`      VARCHAR(10)      NOT NULL
  COMMENT '菜单类型(1:：权限菜单，2：外部url菜单，3：js事件)',
  `href`           VARCHAR(500)              DEFAULT NULL
  COMMENT '外部链接地址',
  `onclick`        TEXT COMMENT 'onclick事件',
  `target`         VARCHAR(16)               DEFAULT NULL
  COMMENT 'target属性',
  `role_id`        INT(11) UNSIGNED NOT NULL
  COMMENT '角色id',
  `menu_module_id` INT(11) UNSIGNED NOT NULL
  COMMENT '菜单模块id',
  `parent_id`      INT(11)          NOT NULL
  COMMENT '父级id',
  `enabled`        TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '是否可用',
  `update_date`    DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT '修改时间',
  `update_user`    INT(11)          NOT NULL
  COMMENT '修改人',
  `create_date`    DATETIME         NOT NULL
  COMMENT '创建时间',
  `create_user`    INT(11)          NOT NULL
  COMMENT '创建人',
  `order_index`    INT(11)          NOT NULL DEFAULT '0'
  COMMENT '排序',
  `remark`         VARCHAR(50)               DEFAULT NULL
  COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `menufk1` (`system_code`) USING BTREE,
  KEY `menufk2` (`resource_id`) USING BTREE,
  KEY `menu_fk3` (`role_id`),
  KEY `menu_fk4` (`menu_module_id`),
  CONSTRAINT `menu_fk1` FOREIGN KEY (`system_code`) REFERENCES `t_oauth_system_module` (`system_code`),
  CONSTRAINT `menu_fk2` FOREIGN KEY (`resource_id`) REFERENCES `t_oauth_resource` (`id`),
  CONSTRAINT `menu_fk3` FOREIGN KEY (`role_id`) REFERENCES `t_oauth_role` (`id`),
  CONSTRAINT `menu_fk4` FOREIGN KEY (`menu_module_id`) REFERENCES `t_oauth_menu_module` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_menu
-- ----------------------------

-- ----------------------------
-- Table structure for t_oauth_menu_module
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_menu_module`;
CREATE TABLE `t_oauth_menu_module` (
  `id`          INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '菜单模块主键id',
  `name`        VARCHAR(50)      NOT NULL
  COMMENT '名称',
  `icon_larger` VARCHAR(100)              DEFAULT NULL
  COMMENT '菜单模块大图标',
  `icon_mini`   VARCHAR(100)              DEFAULT NULL
  COMMENT '菜单模块小图标',
  `system_code` VARCHAR(20)      NOT NULL
  COMMENT '系统模块代码',
  `enabled`     TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '是否可用',
  `update_date` DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT '修改时间',
  `update_user` INT(11)          NOT NULL
  COMMENT '修改人',
  `create_date` DATETIME         NOT NULL
  COMMENT '创建时间',
  `create_user` INT(11)          NOT NULL
  COMMENT '创建人',
  `order_index` INT(11)          NOT NULL DEFAULT '0'
  COMMENT '排序',
  `remark`      VARCHAR(50)               DEFAULT NULL
  COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `menu_module_fk` (`system_code`),
  CONSTRAINT `menu_module_fk` FOREIGN KEY (`system_code`) REFERENCES `t_oauth_system_module` (`system_code`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_menu_module
-- ----------------------------
INSERT INTO `t_oauth_menu_module` VALUES
  ('1', '系统设置', NULL, NULL, 'SYS_BASE_PLATFORM', '1', '2017-08-10 23:04:34', '1', '2017-08-09 19:39:18', '1', '0', '');

-- ----------------------------
-- Table structure for t_oauth_operation_privilege_type
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_operation_privilege_type`;
CREATE TABLE `t_oauth_operation_privilege_type` (
  `id`          INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '操作级权限类型基础表Id',
  `name`        VARCHAR(50)      NOT NULL
  COMMENT '操作级权限类型名称',
  `enabled`     TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '是否可用',
  `update_date` DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT '修改时间',
  `update_user` INT(11)          NOT NULL
  COMMENT '修改人',
  `create_date` DATETIME         NOT NULL
  COMMENT ' 创建时间',
  `create_user` INT(11)          NOT NULL
  COMMENT '创建人',
  `order_index` INT(11)          NOT NULL DEFAULT '0'
  COMMENT '排序',
  `remark`      VARCHAR(50)               DEFAULT NULL
  COMMENT '备注',
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_operation_privilege_type
-- ----------------------------
INSERT INTO `t_oauth_operation_privilege_type`
VALUES ('1', '页面按钮', '1', '2017-08-10 23:04:49', '1', '2017-08-10 11:49:20', '1', '0', '');

-- ----------------------------
-- Table structure for t_oauth_privilege_operation
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_privilege_operation`;
CREATE TABLE `t_oauth_privilege_operation` (
  `id`                INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '操作级权限表Id',
  `operation_name`    VARCHAR(50)      NOT NULL
  COMMENT '操作名称',
  `resource_id`       INT(11) UNSIGNED NOT NULL
  COMMENT '资源id',
  `page_privilege_id` INT(11) UNSIGNED NOT NULL
  COMMENT '页面级权限id',
  `operation_type_id` INT(11) UNSIGNED NOT NULL
  COMMENT '操作类型id',
  `enabled`           TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '是否可用',
  `update_date`       DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT '修改日期',
  `update_user`       INT(11)          NOT NULL
  COMMENT '修改用户',
  `create_date`       DATETIME         NOT NULL
  COMMENT '创建日期',
  `create_user`       INT(11)          NOT NULL
  COMMENT '创建人',
  `order_index`       INT(11)          NOT NULL DEFAULT '0'
  COMMENT '排序',
  `remark`            VARCHAR(50)               DEFAULT NULL
  COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `privilege_operation_fk1` (`resource_id`),
  KEY `privilege_operation_fk2` (`page_privilege_id`),
  KEY `privilege_operation_fk3` (`operation_type_id`),
  CONSTRAINT `privilege_operation_fk1` FOREIGN KEY (`resource_id`) REFERENCES `t_oauth_resource` (`id`),
  CONSTRAINT `privilege_operation_fk2` FOREIGN KEY (`page_privilege_id`) REFERENCES `t_oauth_privilege_page` (`id`),
  CONSTRAINT `privilege_operation_fk3` FOREIGN KEY (`operation_type_id`) REFERENCES `t_oauth_operation_privilege_type` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_privilege_operation
-- ----------------------------

-- ----------------------------
-- Table structure for t_oauth_privilege_page
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_privilege_page`;
CREATE TABLE `t_oauth_privilege_page` (
  `id`                 INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '页面权限表id',
  `resource_id`        INT(11) UNSIGNED NOT NULL
  COMMENT '资源id',
  `resource_module_id` INT(11) UNSIGNED NOT NULL
  COMMENT '资源模块id',
  `enabled`            TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '是否可用',
  `update_date`        DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT '修改时间',
  `update_user`        INT(11)          NOT NULL
  COMMENT '修改用户',
  `create_date`        DATETIME         NOT NULL
  COMMENT '创建日期',
  `create_user`        INT(11)          NOT NULL
  COMMENT '创建用户',
  `order_index`        INT(11)          NOT NULL DEFAULT '0'
  COMMENT '排序',
  `remark`             VARCHAR(50)               DEFAULT NULL
  COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `privilege_page_fk1` (`resource_id`),
  KEY `privilege_page_fk2` (`resource_module_id`),
  CONSTRAINT `privilege_page_fk1` FOREIGN KEY (`resource_id`) REFERENCES `t_oauth_resource` (`id`),
  CONSTRAINT `privilege_page_fk2` FOREIGN KEY (`resource_module_id`) REFERENCES `t_oauth_resource_module` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_privilege_page
-- ----------------------------

-- ----------------------------
-- Table structure for t_oauth_resource
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_resource`;
CREATE TABLE `t_oauth_resource` (
  `id`              INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT 'id',
  `url`             VARCHAR(100)     NOT NULL
  COMMENT '资源路径',
  `name`            VARCHAR(50)      NOT NULL
  COMMENT '资源中文名称',
  `permission_mark` VARCHAR(16)      NOT NULL
  COMMENT '权限标识',
  `system_code`     VARCHAR(20)      NOT NULL
  COMMENT '系统模块代码',
  `enabled`         TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '是否可用',
  `update_date`     DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT '修改时间',
  `update_user`     INT(11)          NOT NULL
  COMMENT '修改人',
  `create_date`     DATETIME         NOT NULL
  COMMENT '创建日期',
  `create_user`     INT(11)          NOT NULL
  COMMENT '创建人',
  `order_index`     INT(11)          NOT NULL DEFAULT '0'
  COMMENT '排序',
  `remark`          VARCHAR(50)               DEFAULT NULL
  COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `resource_fk1` (`system_code`),
  CONSTRAINT `resource_fk1` FOREIGN KEY (`system_code`) REFERENCES `t_oauth_system_module` (`system_code`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_resource
-- ----------------------------

-- ----------------------------
-- Table structure for t_oauth_resource_module
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_resource_module`;
CREATE TABLE `t_oauth_resource_module` (
  `id`          INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '模块id',
  `name`        VARCHAR(50)               DEFAULT NULL
  COMMENT '名称',
  `system_code` VARCHAR(20)      NOT NULL
  COMMENT '系统模块代码',
  `enabled`     TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '是否可用',
  `update_date` DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT '更新日期',
  `update_user` INT(11)          NOT NULL
  COMMENT '更新人',
  `create_date` DATETIME         NOT NULL
  COMMENT '创建日期',
  `create_user` INT(11)          NOT NULL
  COMMENT '创建人',
  `order_index` INT(11)          NOT NULL DEFAULT '0'
  COMMENT '排序',
  `remark`      VARCHAR(50)               DEFAULT NULL
  COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `resource_module_fk1` (`system_code`),
  CONSTRAINT `resource_module_fk1` FOREIGN KEY (`system_code`) REFERENCES `t_oauth_system_module` (`system_code`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_resource_module
-- ----------------------------
INSERT INTO `t_oauth_resource_module`
VALUES ('1', '系统管理111', 'SYS_BASE_PLATFORM', '1', '2017-08-10 16:19:01', '1', '2017-08-09 19:41:26', '1', '0', '');

-- ----------------------------
-- Table structure for t_oauth_role
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_role`;
CREATE TABLE `t_oauth_role` (
  `id`          INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '主键ID',
  `name`        VARCHAR(50)      NOT NULL
  COMMENT '名称',
  `cn_name`     VARCHAR(50)      NOT NULL
  COMMENT '角色标识',
  `parent_id`   INT(11)          NOT NULL
  COMMENT '父级角色id',
  `system_code` VARCHAR(20)      NOT NULL
  COMMENT '系统模块代码',
  `create_date` DATETIME         NOT NULL
  COMMENT '创建时间',
  `create_user` INT(11)          NOT NULL
  COMMENT '创建人',
  `update_date` DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT '修改时间',
  `update_user` INT(11)          NOT NULL
  COMMENT '修改人',
  `order_index` INT(11)          NOT NULL
  COMMENT '排序',
  `remark`      VARCHAR(50)               DEFAULT NULL
  COMMENT '备注',
  `enabled`     TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '是否可用',
  PRIMARY KEY (`id`),
  KEY `role_fk1` (`system_code`),
  CONSTRAINT `role_fk1` FOREIGN KEY (`system_code`) REFERENCES `t_oauth_system_module` (`system_code`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 6
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_role
-- ----------------------------
INSERT INTO `t_oauth_role` VALUES
  ('1', 'ROLE_BASE_DEVELOPER', '开发人员', '0', 'SYS_BASE_PLATFORM', '2017-08-08 20:05:01', '1', '2017-08-08 20:05:01', '1',
        '0', '通用基础管理平台开发者', '1');
INSERT INTO `t_oauth_role` VALUES
  ('2', 'ROLE_BASE_SUPER_ADMIN', '超级管理员', '0', 'SYS_BASE_PLATFORM', '2017-08-08 20:21:16', '1', '2017-08-08 20:33:36',
        '1', '0', '基础平台超级管理员', '1');
INSERT INTO `t_oauth_role` VALUES
  ('3', 'ROLE_WECHAT_SUPER_ADMIN', '超级管理员', '0', 'SYS_WECHAT_PLATFORM', '2017-08-08 20:22:59', '1',
        '2017-08-08 20:23:34', '1', '0', '微信通用管理平台超级管理员', '1');
INSERT INTO `t_oauth_role` VALUES
  ('4', 'ROLE_WECHAT_ADMIN', '管理员', '3', 'SYS_WECHAT_PLATFORM', '2017-08-08 20:23:22', '1', '2017-08-08 20:23:22', '1',
        '0', '微信管理平台管理员', '1');
INSERT INTO `t_oauth_role` VALUES
  ('5', 'ROLE_WECHAT_DEVELOPER', '开发人员', '0', 'SYS_WECHAT_PLATFORM', '2017-08-08 20:23:58', '1', '2017-08-08 20:23:58',
        '1', '0', '微信通用管理平台开发人员', '1');

-- ----------------------------
-- Table structure for t_oauth_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_role_resource`;
CREATE TABLE `t_oauth_role_resource` (
  `role_id`     INT(11) UNSIGNED NOT NULL,
  `resource_id` INT(11) UNSIGNED NOT NULL,
  KEY `role_resource_fk1` (`role_id`),
  KEY `role_resource_fk2` (`resource_id`),
  CONSTRAINT `role_resource_fk1` FOREIGN KEY (`role_id`) REFERENCES `t_oauth_role` (`id`),
  CONSTRAINT `role_resource_fk2` FOREIGN KEY (`resource_id`) REFERENCES `t_oauth_resource` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_role_resource
-- ----------------------------

-- ----------------------------
-- Table structure for t_oauth_session
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_session`;
CREATE TABLE `t_oauth_session` (
  `id`               INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '会话持久化对象主键id',
  `username`         VARCHAR(50)      NOT NULL
  COMMENT '会话用户',
  `session_id`       VARCHAR(50)      NOT NULL
  COMMENT 'session id 唯一的',
  `session_base64`   TEXT             NOT NULL
  COMMENT 'session序列化字符串',
  `ip`               VARCHAR(20)      NOT NULL
  COMMENT '创建这个会话的访问ip地址',
  `first_visit_date` DATETIME                  DEFAULT NULL
  COMMENT '会话创建日期时间',
  `last_visit_date`  DATETIME                  DEFAULT NULL
  COMMENT '最后访问日期',
  `session_timeout`  INT(11)          NOT NULL
  COMMENT 'session失效时间',
  `create_url`       VARCHAR(100)     NOT NULL
  COMMENT '创建这个会话的url',
  `update_url`       VARCHAR(100)     NOT NULL
  COMMENT '更新这个会话的url',
  `user_agent`       VARCHAR(200)              DEFAULT NULL
  COMMENT 'userAgent',
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 149
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_session
-- ----------------------------

-- ----------------------------
-- Table structure for t_oauth_system_module
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_system_module`;
CREATE TABLE `t_oauth_system_module` (
  `id`          INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '主键id',
  `name`        VARCHAR(20)      NOT NULL
  COMMENT '系统模块名称',
  `system_code` VARCHAR(20)      NOT NULL
  COMMENT '系统模块代码',
  `enabled`     TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '是否可用',
  `update_date` DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT '更新时间',
  `update_user` INT(11)          NOT NULL
  COMMENT '更新人',
  `create_date` DATETIME         NOT NULL
  COMMENT '创建日期',
  `create_user` INT(11)          NOT NULL
  COMMENT '创建人',
  `order_index` INT(11)          NOT NULL DEFAULT '0'
  COMMENT '排序',
  `remark`      VARCHAR(50)               DEFAULT NULL
  COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `system_code` (`system_code`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_system_module
-- ----------------------------
INSERT INTO `t_oauth_system_module` VALUES
  ('1', '通用基础管理平台', 'SYS_BASE_PLATFORM', '1', '2017-08-08 20:02:21', '1', '2017-08-08 20:02:21', '1', '0',
   '管理系统的权限、菜单、角色、用户、系统参数等功能');
INSERT INTO `t_oauth_system_module` VALUES
  ('2', '微信通用管理平台', 'SYS_WECHAT_PLATFORM', '1', '2017-08-08 20:28:43', '1', '2017-08-08 20:22:32', '1', '0', '微信管理平台');

-- ----------------------------
-- Table structure for t_oauth_system_param
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_system_param`;
CREATE TABLE `t_oauth_system_param` (
  `id`          INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '系统参数表主键id',
  `name`        VARCHAR(50)      NOT NULL
  COMMENT '名称',
  `value`       VARCHAR(50)      NOT NULL
  COMMENT '参数值',
  `enabled`     TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '是否可用',
  `update_date` DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT '更新时间',
  `update_user` INT(11)          NOT NULL
  COMMENT '更新人',
  `create_date` DATETIME         NOT NULL
  COMMENT '创建日期',
  `create_user` INT(11)          NOT NULL
  COMMENT '创建人',
  `order_index` INT(11)          NOT NULL DEFAULT '0'
  COMMENT '排序',
  `remark`      VARCHAR(50)               DEFAULT NULL
  COMMENT '备注',
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_system_param
-- ----------------------------
INSERT INTO `t_oauth_system_param` VALUES
  ('1', 'open_security_control', '0', '1', '2017-08-08 22:44:38', '1', '2017-08-08 22:44:26', '1', '0',
   '是否打开系统权限控制，1打开，0不打开');

-- ----------------------------
-- Table structure for t_oauth_user
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_user`;
CREATE TABLE `t_oauth_user` (
  `id`              INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '主键ID',
  `username`        VARCHAR(50)      NOT NULL
  COMMENT '用户名',
  `password`        VARCHAR(50)      NOT NULL
  COMMENT '密码',
  `cname`           VARCHAR(50)      NOT NULL
  COMMENT '姓名',
  `dept_id`         INT(11) UNSIGNED NOT NULL
  COMMENT '部门id,多个用逗号隔开',
  `default_role_id` INT(11) UNSIGNED NOT NULL
  COMMENT '默认角色(父级)',
  `salt`            VARCHAR(50)      NOT NULL
  COMMENT '盐',
  `email`           VARCHAR(50)      NOT NULL
  COMMENT '邮箱',
  `qq`              VARCHAR(50)               DEFAULT NULL
  COMMENT 'qq',
  `wechat`          VARCHAR(50)               DEFAULT NULL
  COMMENT '微信',
  `mobile`          VARCHAR(20)               DEFAULT NULL
  COMMENT '手机号码',
  `enabled`         TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '是否可用',
  `update_date`     DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT '修改时间',
  `update_user`     INT(11)          NOT NULL
  COMMENT '修改人',
  `create_date`     DATETIME         NOT NULL
  COMMENT '创建时间',
  `create_user`     INT(11)          NOT NULL
  COMMENT '创建人',
  `order_index`     INT(11)          NOT NULL DEFAULT '0'
  COMMENT '排序',
  `remark`          VARCHAR(50)               DEFAULT NULL
  COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `user_fk_1` (`dept_id`),
  KEY `user_fk2` (`default_role_id`),
  CONSTRAINT `user_fk2` FOREIGN KEY (`default_role_id`) REFERENCES `t_oauth_role` (`id`),
  CONSTRAINT `user_fk_1` FOREIGN KEY (`dept_id`) REFERENCES `t_oauth_department` (`id`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_user
-- ----------------------------
INSERT INTO `t_oauth_user` VALUES
  ('1', 'sa', 'c0c382617df2d30b3cef427f1f11c92b', '超级管理员', '1', '1', 'f7fddb4bf0fdceb77e01ef1bbc6fd826',
        '765934806@qq.com', '765934806', NULL, '181xxxxxxxx', '1', '2017-08-08 20:05:42', '1', '2017-08-08 20:05:42',
   '1', '0', '伍文彬wwb');
INSERT INTO `t_oauth_user` VALUES
  ('2', 'wwb', 'c0c382617df2d30b3cef427f1f11c92b', '伍文彬', '1', '1', 'f7fddb4bf0fdceb77e01ef1bbc6fd826',
        '765934806@qq.com', '765934806', '', '181xxxxxxxx', '1', '2017-08-08 20:05:42', '1', '2017-08-08 20:05:42', '1',
   '0', '伍文彬wwb');

-- ----------------------------
-- Table structure for t_oauth_user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_user_login_log`;
CREATE TABLE `t_oauth_user_login_log` (
  `id`              INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '用户登录日志主键id',
  `user_id`         INT(11) UNSIGNED NOT NULL
  COMMENT '用户id',
  `last_login_date` DATETIME         NOT NULL
  COMMENT '登录时间',
  `last_login_ip`   VARCHAR(50)      NOT NULL
  COMMENT '登录ip',
  `enabled`         TINYINT(1)                DEFAULT '1'
  COMMENT '是否可用',
  `update_date`     DATETIME                  DEFAULT CURRENT_TIMESTAMP
  COMMENT '更新日期',
  `update_user`     INT(11)                   DEFAULT NULL
  COMMENT '更新人',
  `create_date`     DATETIME                  DEFAULT NULL
  COMMENT '创建时间',
  `create_user`     INT(11)                   DEFAULT NULL
  COMMENT '创建人',
  `order_index`     INT(11)                   DEFAULT '0'
  COMMENT '排序',
  `remark`          VARCHAR(50)               DEFAULT NULL
  COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `user_login_log_fk1` (`user_id`),
  CONSTRAINT `user_login_log_fk1` FOREIGN KEY (`user_id`) REFERENCES `t_oauth_user` (`id`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 69
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_user_login_log
-- ----------------------------
INSERT INTO `t_oauth_user_login_log`
VALUES ('1', '1', '2017-08-08 21:46:25', '127.0.0.1', '1', '2017-08-08 21:46:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('2', '1', '2017-08-08 22:29:39', '127.0.0.1', '1', '2017-08-08 22:29:39', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('3', '1', '2017-08-08 22:32:56', '127.0.0.1', '1', '2017-08-08 22:32:56', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('4', '1', '2017-08-08 22:40:56', '127.0.0.1', '1', '2017-08-08 22:40:56', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('5', '1', '2017-08-08 22:51:59', '127.0.0.1', '1', '2017-08-08 22:51:59', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('6', '1', '2017-08-08 23:28:35', '127.0.0.1', '1', '2017-08-08 23:28:35', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('7', '1', '2017-08-09 10:16:45', '127.0.0.1', '1', '2017-08-09 10:16:45', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('8', '1', '2017-08-09 10:29:05', '127.0.0.1', '1', '2017-08-09 10:29:05', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('9', '1', '2017-08-09 10:51:02', '127.0.0.1', '1', '2017-08-09 10:51:02', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('10', '1', '2017-08-09 19:32:08', '127.0.0.1', '1', '2017-08-09 19:32:08', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('11', '1', '2017-08-10 10:15:26', '127.0.0.1', '1', '2017-08-10 10:15:26', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('12', '1', '2017-08-10 11:19:45', '127.0.0.1', '1', '2017-08-10 11:19:45', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('13', '1', '2017-08-10 11:20:49', '127.0.0.1', '1', '2017-08-10 11:20:49', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('14', '1', '2017-08-10 11:48:48', '127.0.0.1', '1', '2017-08-10 11:48:48', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('15', '1', '2017-08-10 11:52:53', '127.0.0.1', '1', '2017-08-10 11:52:53', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('16', '1', '2017-08-10 12:46:23', '127.0.0.1', '1', '2017-08-10 12:46:23', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('17', '1', '2017-08-10 12:46:43', '127.0.0.1', '1', '2017-08-10 12:46:43', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('18', '1', '2017-08-10 12:46:58', '127.0.0.1', '1', '2017-08-10 12:46:58', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('19', '1', '2017-08-10 12:48:04', '127.0.0.1', '1', '2017-08-10 12:48:04', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('20', '1', '2017-08-10 13:00:20', '127.0.0.1', '1', '2017-08-10 13:00:20', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('21', '1', '2017-08-10 13:10:15', '127.0.0.1', '1', '2017-08-10 13:10:15', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('22', '1', '2017-08-10 13:11:14', '127.0.0.1', '1', '2017-08-10 13:11:14', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('23', '1', '2017-08-10 13:11:52', '127.0.0.1', '1', '2017-08-10 13:11:52', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('24', '1', '2017-08-10 13:13:20', '127.0.0.1', '1', '2017-08-10 13:13:20', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('25', '1', '2017-08-10 13:15:33', '127.0.0.1', '1', '2017-08-10 13:15:33', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('26', '1', '2017-08-10 14:21:01', '127.0.0.1', '1', '2017-08-10 14:21:01', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('27', '1', '2017-08-10 15:43:30', '127.0.0.1', '1', '2017-08-10 15:43:30', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('28', '1', '2017-08-10 15:43:58', '127.0.0.1', '1', '2017-08-10 15:43:58', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('29', '1', '2017-08-10 15:46:55', '127.0.0.1', '1', '2017-08-10 15:46:55', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('30', '1', '2017-08-10 15:48:16', '127.0.0.1', '1', '2017-08-10 15:48:16', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('31', '1', '2017-08-10 15:49:27', '127.0.0.1', '1', '2017-08-10 15:49:27', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('32', '1', '2017-08-10 15:51:13', '127.0.0.1', '1', '2017-08-10 15:51:13', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('33', '1', '2017-08-10 15:52:14', '127.0.0.1', '1', '2017-08-10 15:52:14', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('34', '1', '2017-08-10 15:55:44', '127.0.0.1', '1', '2017-08-10 15:55:44', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('35', '1', '2017-08-10 15:55:56', '127.0.0.1', '1', '2017-08-10 15:55:56', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('36', '1', '2017-08-10 15:57:43', '127.0.0.1', '1', '2017-08-10 15:57:43', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('37', '1', '2017-08-10 16:00:30', '127.0.0.1', '1', '2017-08-10 16:00:30', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('38', '1', '2017-08-10 16:00:48', '127.0.0.1', '1', '2017-08-10 16:00:48', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('39', '1', '2017-08-10 16:05:15', '127.0.0.1', '1', '2017-08-10 16:05:15', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('40', '1', '2017-08-10 16:18:42', '127.0.0.1', '1', '2017-08-10 16:18:42', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('41', '1', '2017-08-10 16:19:23', '127.0.0.1', '1', '2017-08-10 16:19:23', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('42', '1', '2017-08-10 16:23:18', '127.0.0.1', '1', '2017-08-10 16:23:18', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('43', '1', '2017-08-10 16:23:43', '127.0.0.1', '1', '2017-08-10 16:23:43', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('44', '1', '2017-08-10 16:24:12', '127.0.0.1', '1', '2017-08-10 16:24:12', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('45', '1', '2017-08-10 16:24:27', '127.0.0.1', '1', '2017-08-10 16:24:27', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('46', '1', '2017-08-10 16:26:44', '127.0.0.1', '1', '2017-08-10 16:26:44', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('47', '1', '2017-08-10 16:29:03', '127.0.0.1', '1', '2017-08-10 16:29:03', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('48', '1', '2017-08-10 16:29:53', '127.0.0.1', '1', '2017-08-10 16:29:53', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('49', '1', '2017-08-10 16:33:06', '127.0.0.1', '1', '2017-08-10 16:33:06', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('50', '1', '2017-08-10 16:34:18', '127.0.0.1', '1', '2017-08-10 16:34:18', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('51', '1', '2017-08-10 16:37:17', '127.0.0.1', '1', '2017-08-10 16:37:17', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('52', '1', '2017-08-10 16:37:55', '127.0.0.1', '1', '2017-08-10 16:37:55', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('53', '1', '2017-08-10 16:41:24', '127.0.0.1', '1', '2017-08-10 16:41:24', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('54', '1', '2017-08-10 16:42:37', '127.0.0.1', '1', '2017-08-10 16:42:37', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('55', '1', '2017-08-10 16:45:00', '127.0.0.1', '1', '2017-08-10 16:45:00', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('56', '1', '2017-08-10 17:59:32', '127.0.0.1', '1', '2017-08-10 17:59:32', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('57', '1', '2017-08-10 18:01:12', '127.0.0.1', '1', '2017-08-10 18:01:12', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('58', '1', '2017-08-10 18:01:42', '127.0.0.1', '1', '2017-08-10 18:01:42', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('59', '1', '2017-08-10 18:46:29', '127.0.0.1', '1', '2017-08-10 18:46:29', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('60', '1', '2017-08-10 18:46:57', '127.0.0.1', '1', '2017-08-10 18:46:57', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('61', '1', '2017-08-10 18:59:00', '127.0.0.1', '1', '2017-08-10 18:59:00', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('62', '1', '2017-08-10 23:03:03', '127.0.0.1', '1', '2017-08-10 23:03:03', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('63', '1', '2017-08-10 23:14:05', '127.0.0.1', '1', '2017-08-10 23:14:05', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('64', '1', '2017-08-10 23:27:02', '127.0.0.1', '1', '2017-08-10 23:27:02', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('65', '1', '2017-08-10 23:31:07', '127.0.0.1', '1', '2017-08-10 23:31:07', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('66', '1', '2017-08-10 23:47:23', '127.0.0.1', '1', '2017-08-10 23:47:23', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('67', '1', '2017-08-10 23:48:09', '127.0.0.1', '1', '2017-08-10 23:48:09', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('68', '1', '2017-08-10 23:55:44', '127.0.0.1', '1', '2017-08-10 23:55:44', NULL, NULL, NULL, '0', NULL);

-- ----------------------------
-- Table structure for t_oauth_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_user_role`;
CREATE TABLE `t_oauth_user_role` (
  `user_id` INT(11) UNSIGNED NOT NULL
  COMMENT '用户id',
  `role_id` INT(11) UNSIGNED NOT NULL
  COMMENT '角色id',
  KEY `user_role_fk1` (`user_id`),
  KEY `user_role_fk2` (`role_id`),
  CONSTRAINT `user_role_fk1` FOREIGN KEY (`user_id`) REFERENCES `t_oauth_user` (`id`),
  CONSTRAINT `user_role_fk2` FOREIGN KEY (`role_id`) REFERENCES `t_oauth_role` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_user_role
-- ----------------------------
DROP TRIGGER IF EXISTS `menu_module_tg1`;
DELIMITER ;;
CREATE TRIGGER `menu_module_tg1`
AFTER UPDATE ON `t_oauth_menu_module`
FOR EACH ROW
  BEGIN
    UPDATE t_oauth_menu
    SET enabled = new.enabled
    WHERE menu_module_id = old.id;
  END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `operation_privilege_type_tg1`;
DELIMITER ;;
CREATE TRIGGER `operation_privilege_type_tg1`
AFTER UPDATE ON `t_oauth_operation_privilege_type`
FOR EACH ROW
  BEGIN
    UPDATE t_oauth_privilege_operation
    SET enabled = new.enabled
    WHERE operation_type_id = old.id;
  END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `system_module_tg1`;
DELIMITER ;;
CREATE TRIGGER `system_module_tg1`
AFTER UPDATE ON `t_oauth_system_module`
FOR EACH ROW
  BEGIN
    UPDATE t_oauth_menu_module
    SET ENABLED = new.enabled
    WHERE system_code = old.system_code;
    UPDATE t_oauth_menu
    SET ENABLED = new.enabled
    WHERE system_code = old.system_code;
    UPDATE t_oauth_resource_module
    SET ENABLED = new.enabled
    WHERE system_code = old.system_code;
    UPDATE t_oauth_resource
    SET ENABLED = new.enabled
    WHERE system_code = old.system_code;
    UPDATE t_oauth_role
    SET ENABLED = new.enabled
    WHERE system_code = old.system_code;
  END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `user_tg1`;
DELIMITER ;;
CREATE TRIGGER `user_tg1`
AFTER UPDATE ON `t_oauth_user`
FOR EACH ROW
  BEGIN
    UPDATE t_oauth_user_login_log
    SET enabled = new.enabled
    WHERE user_id = old.id;
  END
;;
DELIMITER ;
