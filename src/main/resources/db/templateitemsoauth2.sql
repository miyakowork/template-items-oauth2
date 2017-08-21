/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : templateitemsoauth2

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2017-08-18 15:20:03
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
  AUTO_INCREMENT = 7
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_department
-- ----------------------------
INSERT INTO `t_oauth_department`
VALUES ('1', '江西财经大学', '0', '1', '2017-08-08 20:03:47', '1', '2017-08-08 20:03:47', '1', '0', '江西清华');
INSERT INTO `t_oauth_department`
VALUES ('2', '软件与通信工程学院', '1', '1', '2017-08-08 20:21:34', '1', '2017-08-08 20:21:34', '1', '0', '学院');
INSERT INTO `t_oauth_department`
VALUES ('3', '南昌大学', '0', '1', '2017-08-16 21:36:05', '1', '2017-08-08 20:21:42', '1', '0', '大学');
INSERT INTO `t_oauth_department`
VALUES ('4', '江西师范大学', '0', '1', '2017-08-08 20:21:52', '1', '2017-08-08 20:21:52', '1', '0', '大学');
INSERT INTO `t_oauth_department`
VALUES ('5', '古汉语文学', '3', '1', '2017-08-09 20:06:35', '1', '2017-08-08 20:22:02', '1', '0', '专业');
INSERT INTO `t_oauth_department` VALUES
  ('6', '中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国', '0', '1', '2017-08-18 11:04:57', '1', '2017-08-18 11:04:57', '1', '0', '');

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
  `icon_larger`    VARCHAR(50)               DEFAULT NULL
  COMMENT '菜单大图标',
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
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_operation_privilege_type
-- ----------------------------
INSERT INTO `t_oauth_operation_privilege_type`
VALUES ('1', '页面按钮', '1', '2017-08-11 00:25:52', '1', '2017-08-10 11:49:20', '1', '0', '页面上的按钮、表单等url');
INSERT INTO `t_oauth_operation_privilege_type`
VALUES ('2', '表格列', '1', '2017-08-11 00:26:58', '1', '2017-08-11 00:26:58', '1', '0', '表格的列按照角色权限来显示');

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
  `name`               VARCHAR(50)      NOT NULL
  COMMENT '页面级权限名称，默认为资源名称如果不填写',
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
  AUTO_INCREMENT = 199
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_resource
-- ----------------------------
INSERT INTO `t_oauth_resource` VALUES
  ('1', '/management/atest1', 'A测试1', 'sys:atest1:list', 'SYS_BASE_PLATFORM', '1', '2017-08-14 13:55:57', '1',
        '2017-08-14 13:54:25', '1', '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('2', '/management/atest2', 'A测试2', 'sys:atest2:list', 'SYS_BASE_PLATFORM', '1', '2017-08-14 13:56:10', '1',
        '2017-08-14 13:54:46', '1', '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('3', '/management/atest3', 'A测试3', 'sys:atest3:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-14 13:56:20', '1',
        '2017-08-14 13:55:13', '1', '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('4', '/management/atest4', 'A测试4', 'sys:atest4:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
        '2017-08-15 13:56:37', '1', '4', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('5', '/management/atest5', 'A测试5', 'sys:atest5:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
        '2017-08-15 13:56:37', '1', '5', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('6', '/management/atest6', 'A测试6', 'sys:atest6:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
        '2017-08-15 13:56:37', '1', '6', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('7', '/management/atest7', 'A测试7', 'sys:atest7:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
        '2017-08-15 13:56:37', '1', '7', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('8', '/management/atest8', 'A测试8', 'sys:atest8:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
        '2017-08-15 13:56:37', '1', '8', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('9', '/management/atest9', 'A测试9', 'sys:atest9:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
        '2017-08-15 13:56:37', '1', '9', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('10', '/management/atest10', 'A测试10', 'sys:atest10:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '10', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('11', '/management/atest11', 'A测试11', 'sys:atest11:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '11', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('12', '/management/atest12', 'A测试12', 'sys:atest12:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '12', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('13', '/management/atest13', 'A测试13', 'sys:atest13:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '13', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('14', '/management/atest14', 'A测试14', 'sys:atest14:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '14', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('15', '/management/atest15', 'A测试15', 'sys:atest15:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '15', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('16', '/management/atest16', 'A测试16', 'sys:atest16:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '16', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('17', '/management/atest17', 'A测试17', 'sys:atest17:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '17', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('18', '/management/atest18', 'A测试18', 'sys:atest18:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '18', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('19', '/management/atest19', 'A测试19', 'sys:atest19:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '19', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('20', '/management/atest20', 'A测试20', 'sys:atest20:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '20', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('21', '/management/atest21', 'A测试21', 'sys:atest21:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '21', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('22', '/management/atest22', 'A测试22', 'sys:atest22:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '22', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('23', '/management/atest23', 'A测试23', 'sys:atest23:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '23', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('24', '/management/atest24', 'A测试24', 'sys:atest24:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '24', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('25', '/management/atest25', 'A测试25', 'sys:atest25:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '25', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('26', '/management/atest26', 'A测试26', 'sys:atest26:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '26', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('27', '/management/atest27', 'A测试27', 'sys:atest27:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '27', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('28', '/management/atest28', 'A测试28', 'sys:atest28:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '28', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('29', '/management/atest29', 'A测试29', 'sys:atest29:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '29', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('30', '/management/atest30', 'A测试30', 'sys:atest30:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '30', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('31', '/management/atest31', 'A测试31', 'sys:atest31:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '31', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('32', '/management/atest32', 'A测试32', 'sys:atest32:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '32', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('33', '/management/atest33', 'A测试33', 'sys:atest33:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '33', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('34', '/management/atest34', 'A测试34', 'sys:atest34:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '34', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('35', '/management/atest35', 'A测试35', 'sys:atest35:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '35', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('36', '/management/atest36', 'A测试36', 'sys:atest36:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '36', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('37', '/management/atest37', 'A测试37', 'sys:atest37:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '37', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('38', '/management/atest38', 'A测试38', 'sys:atest38:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '38', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('39', '/management/atest39', 'A测试39', 'sys:atest39:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '39', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('40', '/management/atest40', 'A测试40', 'sys:atest40:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '40', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('41', '/management/atest41', 'A测试41', 'sys:atest41:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '41', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('42', '/management/atest42', 'A测试42', 'sys:atest42:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '42', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('43', '/management/atest43', 'A测试43', 'sys:atest43:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '43', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('44', '/management/atest44', 'A测试44', 'sys:atest44:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '44', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('45', '/management/atest45', 'A测试45', 'sys:atest45:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '45', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('46', '/management/atest46', 'A测试46', 'sys:atest46:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '46', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('47', '/management/atest47', 'A测试47', 'sys:atest47:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '47', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('48', '/management/atest48', 'A测试48', 'sys:atest48:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '48', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('49', '/management/atest49', 'A测试49', 'sys:atest49:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '49', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('50', '/management/atest50', 'A测试50', 'sys:atest50:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '50', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('51', '/management/atest51', 'A测试51', 'sys:atest51:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '51', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('52', '/management/atest52', 'A测试52', 'sys:atest52:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '52', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('53', '/management/atest53', 'A测试53', 'sys:atest53:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '53', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('54', '/management/atest54', 'A测试54', 'sys:atest54:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '54', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('55', '/management/atest55', 'A测试55', 'sys:atest55:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '55', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('56', '/management/atest56', 'A测试56', 'sys:atest56:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '56', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('57', '/management/atest57', 'A测试57', 'sys:atest57:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '57', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('58', '/management/atest58', 'A测试58', 'sys:atest58:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '58', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('59', '/management/atest59', 'A测试59', 'sys:atest59:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '59', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('60', '/management/atest60', 'A测试60', 'sys:atest60:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '60', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('61', '/management/atest61', 'A测试61', 'sys:atest61:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '61', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('62', '/management/atest62', 'A测试62', 'sys:atest62:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '62', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('63', '/management/atest63', 'A测试63', 'sys:atest63:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '63', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('64', '/management/atest64', 'A测试64', 'sys:atest64:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '64', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('65', '/management/atest65', 'A测试65', 'sys:atest65:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '65', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('66', '/management/atest66', 'A测试66', 'sys:atest66:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '66', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('67', '/management/atest67', 'A测试67', 'sys:atest67:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '67', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('68', '/management/atest68', 'A测试68', 'sys:atest68:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '68', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('69', '/management/atest69', 'A测试69', 'sys:atest69:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '69', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('70', '/management/atest70', 'A测试70', 'sys:atest70:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '70', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('71', '/management/atest71', 'A测试71', 'sys:atest71:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '71', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('72', '/management/atest72', 'A测试72', 'sys:atest72:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '72', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('73', '/management/atest73', 'A测试73', 'sys:atest73:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '73', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('74', '/management/atest74', 'A测试74', 'sys:atest74:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '74', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('75', '/management/atest75', 'A测试75', 'sys:atest75:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '75', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('76', '/management/atest76', 'A测试76', 'sys:atest76:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '76', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('77', '/management/atest77', 'A测试77', 'sys:atest77:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '77', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('78', '/management/atest78', 'A测试78', 'sys:atest78:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '78', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('79', '/management/atest79', 'A测试79', 'sys:atest79:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '79', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('80', '/management/atest80', 'A测试80', 'sys:atest80:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '80', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('81', '/management/atest81', 'A测试81', 'sys:atest81:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '81', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('82', '/management/atest82', 'A测试82', 'sys:atest82:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '82', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('83', '/management/atest83', 'A测试83', 'sys:atest83:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '83', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('84', '/management/atest84', 'A测试84', 'sys:atest84:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '84', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('85', '/management/atest85', 'A测试85', 'sys:atest85:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '85', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('86', '/management/atest86', 'A测试86', 'sys:atest86:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '86', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('87', '/management/atest87', 'A测试87', 'sys:atest87:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '87', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('88', '/management/atest88', 'A测试88', 'sys:atest88:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '88', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('89', '/management/atest89', 'A测试89', 'sys:atest89:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '89', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('90', '/management/atest90', 'A测试90', 'sys:atest90:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '90', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('91', '/management/atest91', 'A测试91', 'sys:atest91:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '91', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('92', '/management/atest92', 'A测试92', 'sys:atest92:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
         '2017-08-15 13:56:37', '1', '92', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('93', '/management/atest93', 'A测试93', 'sys:atest93:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:38', '1',
         '2017-08-15 13:56:38', '1', '93', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('94', '/management/atest94', 'A测试94', 'sys:atest94:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:38', '1',
         '2017-08-15 13:56:38', '1', '94', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('95', '/management/atest95', 'A测试95', 'sys:atest95:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:38', '1',
         '2017-08-15 13:56:38', '1', '95', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('96', '/management/atest96', 'A测试96', 'sys:atest96:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:38', '1',
         '2017-08-15 13:56:38', '1', '96', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('97', '/management/atest97', 'A测试97', 'sys:atest97:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:38', '1',
         '2017-08-15 13:56:38', '1', '97', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('98', '/management/atest98', 'A测试98', 'sys:atest98:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:38', '1',
         '2017-08-15 13:56:38', '1', '98', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('99', '/management/atest99', 'A测试99', 'sys:atest99:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:38', '1',
         '2017-08-15 13:56:38', '1', '99', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('100', '/management/btest1', 'B测试1', 'sys:btest1:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '1', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('101', '/management/btest2', 'B测试2', 'sys:btest2:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '2', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('102', '/management/btest3', 'B测试3', 'sys:btest3:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '3', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('103', '/management/btest4', 'B测试4', 'sys:btest4:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '4', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('104', '/management/btest5', 'B测试5', 'sys:btest5:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '5', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('105', '/management/btest6', 'B测试6', 'sys:btest6:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '6', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('106', '/management/btest7', 'B测试7', 'sys:btest7:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '7', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('107', '/management/btest8', 'B测试8', 'sys:btest8:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '8', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('108', '/management/btest9', 'B测试9', 'sys:btest9:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '9', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('109', '/management/btest10', 'B测试10', 'sys:btest10:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '10', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('110', '/management/btest11', 'B测试11', 'sys:btest11:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '11', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('111', '/management/btest12', 'B测试12', 'sys:btest12:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '12', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('112', '/management/btest13', 'B测试13', 'sys:btest13:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '13', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('113', '/management/btest14', 'B测试14', 'sys:btest14:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '14', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('114', '/management/btest15', 'B测试15', 'sys:btest15:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '15', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('115', '/management/btest16', 'B测试16', 'sys:btest16:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '16', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('116', '/management/btest17', 'B测试17', 'sys:btest17:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '17', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('117', '/management/btest18', 'B测试18', 'sys:btest18:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '18', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('118', '/management/btest19', 'B测试19', 'sys:btest19:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '19', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('119', '/management/btest20', 'B测试20', 'sys:btest20:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '20', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('120', '/management/btest21', 'B测试21', 'sys:btest21:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '21', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('121', '/management/btest22', 'B测试22', 'sys:btest22:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '22', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('122', '/management/btest23', 'B测试23', 'sys:btest23:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '23', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('123', '/management/btest24', 'B测试24', 'sys:btest24:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '24', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('124', '/management/btest25', 'B测试25', 'sys:btest25:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '25', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('125', '/management/btest26', 'B测试26', 'sys:btest26:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '26', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('126', '/management/btest27', 'B测试27', 'sys:btest27:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '27', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('127', '/management/btest28', 'B测试28', 'sys:btest28:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '28', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('128', '/management/btest29', 'B测试29', 'sys:btest29:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '29', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('129', '/management/btest30', 'B测试30', 'sys:btest30:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '30', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('130', '/management/btest31', 'B测试31', 'sys:btest31:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '31', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('131', '/management/btest32', 'B测试32', 'sys:btest32:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '32', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('132', '/management/btest33', 'B测试33', 'sys:btest33:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '33', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('133', '/management/btest34', 'B测试34', 'sys:btest34:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '34', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('134', '/management/btest35', 'B测试35', 'sys:btest35:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '35', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('135', '/management/btest36', 'B测试36', 'sys:btest36:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '36', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('136', '/management/btest37', 'B测试37', 'sys:btest37:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '37', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('137', '/management/btest38', 'B测试38', 'sys:btest38:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '38', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('138', '/management/btest39', 'B测试39', 'sys:btest39:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '39', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('139', '/management/btest40', 'B测试40', 'sys:btest40:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '40', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('140', '/management/btest41', 'B测试41', 'sys:btest41:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '41', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('141', '/management/btest42', 'B测试42', 'sys:btest42:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '42', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('142', '/management/btest43', 'B测试43', 'sys:btest43:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '43', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('143', '/management/btest44', 'B测试44', 'sys:btest44:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '44', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('144', '/management/btest45', 'B测试45', 'sys:btest45:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '45', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('145', '/management/btest46', 'B测试46', 'sys:btest46:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '46', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('146', '/management/btest47', 'B测试47', 'sys:btest47:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '47', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('147', '/management/btest48', 'B测试48', 'sys:btest48:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '48', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('148', '/management/btest49', 'B测试49', 'sys:btest49:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '49', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('149', '/management/btest50', 'B测试50', 'sys:btest50:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '50', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('150', '/management/btest51', 'B测试51', 'sys:btest51:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '51', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('151', '/management/btest52', 'B测试52', 'sys:btest52:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '52', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('152', '/management/btest53', 'B测试53', 'sys:btest53:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '53', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('153', '/management/btest54', 'B测试54', 'sys:btest54:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '54', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('154', '/management/btest55', 'B测试55', 'sys:btest55:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '55', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('155', '/management/btest56', 'B测试56', 'sys:btest56:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '56', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('156', '/management/btest57', 'B测试57', 'sys:btest57:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '57', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('157', '/management/btest58', 'B测试58', 'sys:btest58:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '58', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('158', '/management/btest59', 'B测试59', 'sys:btest59:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '59', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('159', '/management/btest60', 'B测试60', 'sys:btest60:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '60', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('160', '/management/btest61', 'B测试61', 'sys:btest61:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '61', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('161', '/management/btest62', 'B测试62', 'sys:btest62:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '62', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('162', '/management/btest63', 'B测试63', 'sys:btest63:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '63', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('163', '/management/btest64', 'B测试64', 'sys:btest64:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '64', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('164', '/management/btest65', 'B测试65', 'sys:btest65:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '65', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('165', '/management/btest66', 'B测试66', 'sys:btest66:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '66', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('166', '/management/btest67', 'B测试67', 'sys:btest67:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '67', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('167', '/management/btest68', 'B测试68', 'sys:btest68:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '68', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('168', '/management/btest69', 'B测试69', 'sys:btest69:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '69', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('169', '/management/btest70', 'B测试70', 'sys:btest70:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '70', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('170', '/management/btest71', 'B测试71', 'sys:btest71:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '71', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('171', '/management/btest72', 'B测试72', 'sys:btest72:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '72', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('172', '/management/btest73', 'B测试73', 'sys:btest73:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '73', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('173', '/management/btest74', 'B测试74', 'sys:btest74:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '74', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('174', '/management/btest75', 'B测试75', 'sys:btest75:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '75', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('175', '/management/btest76', 'B测试76', 'sys:btest76:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '76', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('176', '/management/btest77', 'B测试77', 'sys:btest77:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '77', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('177', '/management/btest78', 'B测试78', 'sys:btest78:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '78', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('178', '/management/btest79', 'B测试79', 'sys:btest79:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '79', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('179', '/management/btest80', 'B测试80', 'sys:btest80:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '80', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('180', '/management/btest81', 'B测试81', 'sys:btest81:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '81', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('181', '/management/btest82', 'B测试82', 'sys:btest82:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '82', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('182', '/management/btest83', 'B测试83', 'sys:btest83:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '83', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('183', '/management/btest84', 'B测试84', 'sys:btest84:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '84', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('184', '/management/btest85', 'B测试85', 'sys:btest85:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '85', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('185', '/management/btest86', 'B测试86', 'sys:btest86:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '86', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('186', '/management/btest87', 'B测试87', 'sys:btest87:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '87', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('187', '/management/btest88', 'B测试88', 'sys:btest88:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '88', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('188', '/management/btest89', 'B测试89', 'sys:btest89:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '89', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('189', '/management/btest90', 'B测试90', 'sys:btest90:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '90', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('190', '/management/btest91', 'B测试91', 'sys:btest91:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '91', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('191', '/management/btest92', 'B测试92', 'sys:btest92:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '92', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('192', '/management/btest93', 'B测试93', 'sys:btest93:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '93', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('193', '/management/btest94', 'B测试94', 'sys:btest94:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '94', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('194', '/management/btest95', 'B测试95', 'sys:btest95:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '95', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('195', '/management/btest96', 'B测试96', 'sys:btest96:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '96', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('196', '/management/btest97', 'B测试97', 'sys:btest97:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '97', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('197', '/management/btest98', 'B测试98', 'sys:btest98:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '98', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('198', '/management/btest99', 'B测试99', 'sys:btest99:list', 'SYS_WECHAT_PLATFORM', '1', '2017-08-15 13:56:38', '1',
          '2017-08-15 13:56:38', '1', '99', NULL);

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
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_resource_module
-- ----------------------------
INSERT INTO `t_oauth_resource_module`
VALUES ('1', '系统管理', 'SYS_BASE_PLATFORM', '1', '2017-08-11 00:18:22', '1', '2017-08-09 19:41:26', '1', '0', '');
INSERT INTO `t_oauth_resource_module`
VALUES ('2', '个人信息管理', 'SYS_BASE_PLATFORM', '1', '2017-08-14 11:59:02', '1', '2017-08-14 11:59:02', '1', '0', '');
INSERT INTO `t_oauth_resource_module`
VALUES ('3', '系统日志及监控', 'SYS_BASE_PLATFORM', '1', '2017-08-14 11:59:13', '1', '2017-08-14 11:59:13', '1', '0', '');
INSERT INTO `t_oauth_resource_module`
VALUES ('4', '系统管理', 'SYS_WECHAT_PLATFORM', '1', '2017-08-14 12:02:23', '1', '2017-08-14 12:02:23', '1', '0', '');

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
  ('1', 'ROLE_BASE_DEVELOPER', 'A角色1', '0', 'SYS_BASE_PLATFORM', '2017-08-08 20:05:01', '1', '2017-08-14 15:18:59', '1',
        '0', '通用基础管理平台开发者', '1');
INSERT INTO `t_oauth_role` VALUES
  ('2', 'ROLE_BASE_SUPER_ADMIN', 'A角色2', '0', 'SYS_BASE_PLATFORM', '2017-08-08 20:21:16', '1', '2017-08-14 15:19:13',
        '1', '0', '基础平台超级管理员', '1');
INSERT INTO `t_oauth_role` VALUES
  ('3', 'ROLE_WECHAT_SUPER_ADMIN', 'B角色1', '0', 'SYS_WECHAT_PLATFORM', '2017-08-08 20:22:59', '1',
        '2017-08-14 15:19:24', '1', '0', '微信通用管理平台超级管理员', '1');
INSERT INTO `t_oauth_role` VALUES
  ('4', 'ROLE_WECHAT_ADMIN', 'B角色1.1', '3', 'SYS_WECHAT_PLATFORM', '2017-08-08 20:23:22', '1', '2017-08-14 15:19:42',
        '1', '0', '微信管理平台管理员', '1');
INSERT INTO `t_oauth_role` VALUES
  ('5', 'ROLE_WECHAT_DEVELOPER', 'B角色2', '0', 'SYS_WECHAT_PLATFORM', '2017-08-08 20:23:58', '1', '2017-08-14 15:19:32',
        '1', '0', '微信通用管理平台开发人员', '1');

-- ----------------------------
-- Table structure for t_oauth_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_role_resource`;
CREATE TABLE `t_oauth_role_resource` (
  `role_id`     INT(11) UNSIGNED NOT NULL,
  `resource_id` INT(11) UNSIGNED NOT NULL,
  `enabled`     TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '1可用0不可用',
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
  AUTO_INCREMENT = 11
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_session
-- ----------------------------
INSERT INTO `t_oauth_session` VALUES ('10', 'sa', 'b18ffc05-4fbc-4f9c-82ac-52090ec33ab7',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJGIxOGZmYzA1LTRmYmMtNGY5Yy04MmFjLTUyMDkwZWMzM2FiN3NyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV3z61FmeHNxAH4AA3cIAAABXfQ1gH94dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAR0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQAEy9vYXV0aDIvbWVudS1tb2R1bGV0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AC4vb2F1dGgyL3N5c3RlbS1tb2R1bGUvYXBpL2ZpbmQvbW9kdWxlcy9lbmFibGVkdABNb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LnN1cHBvcnQuRGVmYXVsdFN1YmplY3RDb250ZXh0X1BSSU5DSVBBTFNfU0VTU0lPTl9LRVlzcgAyb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LlNpbXBsZVByaW5jaXBhbENvbGxlY3Rpb26of1glxqMISgMAAUwAD3JlYWxtUHJpbmNpcGFsc3QAD0xqYXZhL3V0aWwvTWFwO3hwc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoTWFwNMBOXBBswPsCAAFaAAthY2Nlc3NPcmRlcnhxAH4ABj9AAAAAAAAMdwgAAAAQAAAAAXQAQW9yZy50ZW1wbGF0ZXByb2plY3QuaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8wc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAYeHh4',
                                            '127.0.0.1', '2017-08-18 13:57:52', '2017-08-18 15:18:53', '1800000',
                                            'http://127.0.0.1:8082/oauth2/menu-module',
                                            'http://127.0.0.1:8082/oauth2/system-module/api/find/modules/enabled',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');

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
  ('1', '测试系统平台A', 'SYS_BASE_PLATFORM', '1', '2017-08-14 14:47:52', '1', '2017-08-08 20:02:21', '1', '0',
   '管理系统的权限、菜单、角色、用户、系统参数等功能');
INSERT INTO `t_oauth_system_module` VALUES
  ('2', '测试系统平台B', 'SYS_WECHAT_PLATFORM', '1', '2017-08-14 14:48:01', '1', '2017-08-08 20:22:32', '1', '0', '微信管理平台');

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
  `salt`            VARCHAR(50)      NOT NULL
  COMMENT '盐',
  `cname`           VARCHAR(50)      NOT NULL
  COMMENT '姓名',
  `dept_id`         INT(11) UNSIGNED NOT NULL
  COMMENT '部门id,多个用逗号隔开',
  `default_role_id` INT(11) UNSIGNED NOT NULL
  COMMENT '默认角色(父级)',
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
  AUTO_INCREMENT = 6
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_user
-- ----------------------------
INSERT INTO `t_oauth_user` VALUES
  ('1', 'sa', 'c0c382617df2d30b3cef427f1f11c92b', 'f7fddb4bf0fdceb77e01ef1bbc6fd826', '超级管理员', '1', '1',
        '765934806@qq.com', '765934806', NULL, '181xxxxxxxx', '1', '2017-08-08 20:05:42', '1', '2017-08-08 20:05:42',
   '1', '0', '伍文彬wwb');
INSERT INTO `t_oauth_user` VALUES
  ('2', 'wuwenbin', '1b0b3d9df72b8a911c0948ae2133e2b7', 'b8dbba89e4717f8549f91309e5a80b52', '伍文彬', '3', '1',
        '765934806@qq.com', NULL, NULL, '181xxxxxxxx', '1', '2017-08-13 10:57:57', '1', '2017-08-08 20:05:42', '1', '0',
   NULL);
INSERT INTO `t_oauth_user` VALUES
  ('3', 'test1', '5ad9dbfabd53f02cff01a6b663ea73e1', 'f168be98ce323815e3bd079bade7b6cb', '测试用户', '4', '4',
        '12313@123123.cc', NULL, NULL, '18123256321', '0', '2017-08-12 15:24:16', '1', '2017-08-12 12:48:42', '1', '0',
   NULL);
INSERT INTO `t_oauth_user` VALUES
  ('5', 'test23', '6940f3848099fc64f98cbedb22763329', 'd2b71cd468fca588af035b6b0dec6e6e', '托尔斯泰23', '4', '4',
        '123@123.123', NULL, NULL, '11122233355', '1', '2017-08-14 15:09:08', '1', '2017-08-14 15:09:08', '1', '0',
   NULL);

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
  AUTO_INCREMENT = 147
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
INSERT INTO `t_oauth_user_login_log`
VALUES ('69', '1', '2017-08-11 00:18:12', '127.0.0.1', '1', '2017-08-11 00:18:12', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('70', '2', '2017-08-11 10:25:10', '127.0.0.1', '1', '2017-08-11 10:25:10', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('71', '1', '2017-08-11 11:27:37', '127.0.0.1', '1', '2017-08-11 11:27:37', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('72', '1', '2017-08-11 15:14:08', '127.0.0.1', '1', '2017-08-11 15:14:08', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('73', '1', '2017-08-11 15:14:22', '127.0.0.1', '1', '2017-08-11 15:14:22', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('74', '1', '2017-08-11 18:59:11', '127.0.0.1', '1', '2017-08-11 18:59:11', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('75', '1', '2017-08-11 22:35:51', '127.0.0.1', '1', '2017-08-11 22:35:51', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('76', '1', '2017-08-11 22:52:44', '127.0.0.1', '1', '2017-08-11 22:52:44', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('77', '1', '2017-08-11 23:36:03', '127.0.0.1', '1', '2017-08-11 23:36:03', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('78', '1', '2017-08-11 23:55:25', '127.0.0.1', '1', '2017-08-11 23:55:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('79', '1', '2017-08-12 10:40:55', '127.0.0.1', '1', '2017-08-12 10:40:55', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('80', '1', '2017-08-12 10:52:11', '127.0.0.1', '1', '2017-08-12 10:52:11', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('81', '1', '2017-08-12 10:53:29', '127.0.0.1', '1', '2017-08-12 10:53:29', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('82', '1', '2017-08-12 11:15:00', '127.0.0.1', '1', '2017-08-12 11:15:00', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('83', '1', '2017-08-12 11:35:04', '127.0.0.1', '1', '2017-08-12 11:35:04', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('84', '1', '2017-08-12 11:35:27', '127.0.0.1', '1', '2017-08-12 11:35:27', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('85', '1', '2017-08-12 12:42:35', '127.0.0.1', '1', '2017-08-12 12:42:35', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('86', '1', '2017-08-12 12:43:47', '127.0.0.1', '1', '2017-08-12 12:43:47', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('87', '2', '2017-08-12 12:44:16', '127.0.0.1', '1', '2017-08-12 12:44:16', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('88', '1', '2017-08-12 12:46:47', '127.0.0.1', '1', '2017-08-12 12:46:47', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('89', '1', '2017-08-12 12:47:03', '127.0.0.1', '1', '2017-08-12 12:47:03', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('90', '1', '2017-08-12 13:19:34', '127.0.0.1', '1', '2017-08-12 13:19:34', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('91', '1', '2017-08-12 14:04:04', '127.0.0.1', '1', '2017-08-12 14:04:04', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('92', '1', '2017-08-12 14:51:42', '127.0.0.1', '1', '2017-08-12 14:51:42', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('93', '1', '2017-08-12 15:11:31', '127.0.0.1', '1', '2017-08-12 15:11:31', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('94', '1', '2017-08-12 15:13:51', '127.0.0.1', '1', '2017-08-12 15:13:51', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('95', '3', '2017-08-12 15:23:57', '127.0.0.1', '0', '2017-08-12 15:23:57', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('96', '3', '2017-08-12 15:24:28', '127.0.0.1', '0', '2017-08-12 15:24:28', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('97', '1', '2017-08-12 15:51:59', '127.0.0.1', '1', '2017-08-12 15:51:59', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('98', '1', '2017-08-12 15:53:11', '127.0.0.1', '1', '2017-08-12 15:53:11', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('99', '1', '2017-08-12 15:57:23', '127.0.0.1', '1', '2017-08-12 15:57:23', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('100', '1', '2017-08-12 15:58:15', '127.0.0.1', '1', '2017-08-12 15:58:15', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('101', '1', '2017-08-12 15:58:36', '127.0.0.1', '1', '2017-08-12 15:58:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('102', '2', '2017-08-12 15:59:23', '0:0:0:0:0:0:0:1', '1', '2017-08-12 15:59:23', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('103', '1', '2017-08-12 16:07:11', '127.0.0.1', '1', '2017-08-12 16:07:11', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('104', '1', '2017-08-13 10:42:46', '127.0.0.1', '1', '2017-08-13 10:42:46', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('105', '1', '2017-08-13 10:57:50', '127.0.0.1', '1', '2017-08-13 10:57:50', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('106', '2', '2017-08-13 10:58:11', '127.0.0.1', '1', '2017-08-13 10:58:11', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('107', '1', '2017-08-14 11:07:12', '127.0.0.1', '1', '2017-08-14 11:07:12', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('108', '1', '2017-08-14 11:11:00', '127.0.0.1', '1', '2017-08-14 11:11:00', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('109', '1', '2017-08-14 11:16:01', '127.0.0.1', '1', '2017-08-14 11:16:01', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('110', '1', '2017-08-14 11:24:38', '127.0.0.1', '1', '2017-08-14 11:24:38', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('111', '1', '2017-08-14 11:57:51', '127.0.0.1', '1', '2017-08-14 11:57:51', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('112', '1', '2017-08-14 12:05:16', '127.0.0.1', '1', '2017-08-14 12:05:16', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('113', '1', '2017-08-14 12:40:17', '127.0.0.1', '1', '2017-08-14 12:40:17', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('114', '1', '2017-08-14 13:28:04', '127.0.0.1', '1', '2017-08-14 13:28:04', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('115', '1', '2017-08-14 13:35:11', '127.0.0.1', '1', '2017-08-14 13:35:11', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('116', '1', '2017-08-14 13:52:15', '127.0.0.1', '1', '2017-08-14 13:52:15', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('117', '1', '2017-08-14 14:08:36', '127.0.0.1', '1', '2017-08-14 14:08:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('118', '1', '2017-08-14 14:16:51', '127.0.0.1', '1', '2017-08-14 14:16:51', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('119', '1', '2017-08-14 14:17:36', '127.0.0.1', '1', '2017-08-14 14:17:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('120', '1', '2017-08-14 14:18:36', '127.0.0.1', '1', '2017-08-14 14:18:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('121', '1', '2017-08-14 14:19:10', '127.0.0.1', '1', '2017-08-14 14:19:10', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('122', '1', '2017-08-14 14:19:23', '127.0.0.1', '1', '2017-08-14 14:19:23', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('123', '1', '2017-08-14 14:19:47', '127.0.0.1', '1', '2017-08-14 14:19:47', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('124', '1', '2017-08-14 14:20:00', '127.0.0.1', '1', '2017-08-14 14:20:00', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('125', '1', '2017-08-14 14:23:31', '127.0.0.1', '1', '2017-08-14 14:23:31', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('126', '1', '2017-08-14 14:24:10', '127.0.0.1', '1', '2017-08-14 14:24:10', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('127', '1', '2017-08-14 14:24:49', '127.0.0.1', '1', '2017-08-14 14:24:49', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('128', '1', '2017-08-14 14:29:23', '127.0.0.1', '1', '2017-08-14 14:29:23', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('129', '1', '2017-08-14 14:30:07', '127.0.0.1', '1', '2017-08-14 14:30:07', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('130', '1', '2017-08-14 14:43:42', '127.0.0.1', '1', '2017-08-14 14:43:42', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('131', '1', '2017-08-14 15:36:02', '127.0.0.1', '1', '2017-08-14 15:36:02', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('132', '1', '2017-08-14 15:48:07', '127.0.0.1', '1', '2017-08-14 15:48:07', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('133', '1', '2017-08-15 10:50:58', '127.0.0.1', '1', '2017-08-15 10:50:58', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('134', '1', '2017-08-15 11:12:48', '127.0.0.1', '1', '2017-08-15 11:12:48', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('135', '1', '2017-08-15 11:30:56', '127.0.0.1', '1', '2017-08-15 11:30:56', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('136', '1', '2017-08-15 13:57:35', '127.0.0.1', '1', '2017-08-15 13:57:35', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('137', '1', '2017-08-16 21:31:02', '127.0.0.1', '1', '2017-08-16 21:31:02', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('138', '1', '2017-08-16 21:41:27', '127.0.0.1', '1', '2017-08-16 21:41:27', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('139', '1', '2017-08-17 11:07:11', '127.0.0.1', '1', '2017-08-17 11:07:11', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('140', '1', '2017-08-17 13:06:55', '127.0.0.1', '1', '2017-08-17 13:06:55', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('141', '1', '2017-08-17 16:30:58', '127.0.0.1', '1', '2017-08-17 16:30:58', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('142', '1', '2017-08-17 18:02:23', '127.0.0.1', '1', '2017-08-17 18:02:23', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('143', '1', '2017-08-18 10:10:10', '127.0.0.1', '1', '2017-08-18 10:10:10', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('144', '1', '2017-08-18 11:31:42', '127.0.0.1', '1', '2017-08-18 11:31:42', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('145', '1', '2017-08-18 13:46:43', '127.0.0.1', '1', '2017-08-18 13:46:43', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('146', '1', '2017-08-18 13:57:55', '127.0.0.1', '1', '2017-08-18 13:57:55', NULL, NULL, NULL, '0', NULL);

-- ----------------------------
-- Table structure for t_oauth_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_user_role`;
CREATE TABLE `t_oauth_user_role` (
  `user_id` INT(11) UNSIGNED NOT NULL
  COMMENT '用户id',
  `role_id` INT(11) UNSIGNED NOT NULL
  COMMENT '角色id',
  `enabled` TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '1可用0不可用',
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
DROP TRIGGER IF EXISTS `resource_tg1`;
DELIMITER ;;
CREATE TRIGGER `resource_tg1`
AFTER UPDATE ON `t_oauth_resource`
FOR EACH ROW
  BEGIN
    UPDATE t_oauth_menu
    SET enabled = new.enabled
    WHERE id = old.id;
    UPDATE t_oauth_privilege_page
    SET enabled = new.enabled
    WHERE resource_id = old.id;
    UPDATE t_oauth_privilege_operation
    SET enabled = new.enabled
    WHERE resource_id = old.id;
  END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `resource_tg2`;
DELIMITER ;;
CREATE TRIGGER `resource_tg2`
AFTER DELETE ON `t_oauth_resource`
FOR EACH ROW
  BEGIN
    DELETE FROM t_oauth_privilege_operation
    WHERE t_oauth_privilege_operation.resource_id = old.id;
    DELETE FROM t_oauth_menu
    WHERE t_oauth_menu.resource_id = old.id;
    DELETE FROM t_oauth_privilege_page
    WHERE t_oauth_privilege_page.resource_id = old.id;
  END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `role_tg1`;
DELIMITER ;;
CREATE TRIGGER `role_tg1`
AFTER UPDATE ON `t_oauth_role`
FOR EACH ROW
  BEGIN
    UPDATE t_oauth_role_resource
    SET enabled = new.enabled
    WHERE role_id = old.id;
    UPDATE t_oauth_user_role
    SET enabled = new.enabled
    WHERE role_id = old.id;
    UPDATE t_oauth_menu
    SET enabled = new.enabled
    WHERE role_id = old.id;
  END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `role_tg2`;
DELIMITER ;;
CREATE TRIGGER `role_tg2`
AFTER DELETE ON `t_oauth_role`
FOR EACH ROW
  BEGIN
    DELETE FROM t_oauth_role_resource
    WHERE role_id = old.id;
    DELETE FROM t_oauth_user_role
    WHERE role_id = old.id;
    DELETE FROM t_oauth_menu
    WHERE role_id = old.id;
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
    UPDATE t_oauth_user_role
    SET enabled = new.enabled
    WHERE user_id = old.id;
  END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `user_tg2`;
DELIMITER ;;
CREATE TRIGGER `user_tg2`
AFTER DELETE ON `t_oauth_user`
FOR EACH ROW
  BEGIN
    DELETE FROM t_oauth_user_login_log
    WHERE user_id = old.id;
    DELETE FROM t_oauth_user_role
    WHERE user_id = old.id;
  END
;;
DELIMITER ;
