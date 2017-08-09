/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : templateitemsoauth2

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2017-08-09 10:26:58
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
-- Table structure for t_oauth_menu_module
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_menu_module`;
CREATE TABLE `t_oauth_menu_module` (
  `id`          INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '菜单模块主键id',
  `name`        VARCHAR(50)      NOT NULL
  COMMENT '名称',
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
  DEFAULT CHARSET = utf8;

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
  DEFAULT CHARSET = utf8;

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
  DEFAULT CHARSET = utf8;

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
  AUTO_INCREMENT = 8
  DEFAULT CHARSET = utf8;

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
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8;

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
  AUTO_INCREMENT = 8
  DEFAULT CHARSET = utf8;

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
