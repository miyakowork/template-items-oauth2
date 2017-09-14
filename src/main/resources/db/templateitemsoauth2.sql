/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : templateitemsoauth2

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2017-09-15 00:34:24
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
INSERT INTO `t_oauth_department`
VALUES ('6', '中国中国中国中国中国中', '0', '1', '2017-08-28 13:24:05', '1', '2017-08-18 11:04:57', '1', '0', '');

-- ----------------------------
-- Table structure for t_oauth_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_oauth_menu`;
CREATE TABLE `t_oauth_menu` (
  `id`             INT(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '菜单id',
  `parent_id`      INT(11)          NOT NULL DEFAULT '0'
  COMMENT '父级id',
  `name`           VARCHAR(50)      NOT NULL
  COMMENT '名称',
  `resource_id`    INT(11) UNSIGNED          DEFAULT NULL
  COMMENT '资源id',
  `system_code`    VARCHAR(20)      NOT NULL
  COMMENT '系统模块代码',
  `icon`           VARCHAR(50)               DEFAULT NULL
  COMMENT '菜单图标',
  `icon_larger`    VARCHAR(50)               DEFAULT NULL
  COMMENT '菜单大图标',
  `menu_type`      VARCHAR(10)      NOT NULL
  COMMENT '菜单类型(1:权限菜单，2：外部url菜单，3：js事件，4：目录（即为3的JavaScript:void(0)事件或者#）)',
  `href`           VARCHAR(500)              DEFAULT NULL
  COMMENT '外部链接地址',
  `onclick`        TEXT COMMENT 'onclick事件',
  `target`         VARCHAR(16)               DEFAULT NULL
  COMMENT 'target属性',
  `role_id`        INT(11) UNSIGNED NOT NULL
  COMMENT '角色id',
  `menu_module_id` INT(11) UNSIGNED NOT NULL
  COMMENT '菜单模块id',
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
  AUTO_INCREMENT = 16
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_menu
-- ----------------------------
INSERT INTO `t_oauth_menu` VALUES
  ('1', '0', '系统管理', NULL, 'SYS_BASE', 'fa fa-lg fa-fw fa-cogs', 'null', '4', '#', '', '', '15', '15', '1',
   '2017-09-08 22:47:36', '1', '2017-09-08 22:47:36', '1', '2', '');
INSERT INTO `t_oauth_menu` VALUES
  ('2', '0', '系统日志及监控', NULL, 'SYS_BASE', 'fa fa-lg fa-fw fa-dashboard', '', '4', '#', '', '', '15', '15', '1',
   '2017-09-08 22:53:55', '1', '2017-09-08 22:53:55', '1', '1', '');
INSERT INTO `t_oauth_menu` VALUES
  ('5', '1', '用户菜单管理', '29', 'SYS_BASE', 'fa fa-fw fa-list-ul', '', '1', '/oauth2/menu', '', '', '15', '15', '1',
   '2017-09-10 09:40:38', '1', '2017-09-10 09:40:38', '1', '2', '');
INSERT INTO `t_oauth_menu` VALUES
  ('6', '1', '其他测试菜单', NULL, 'SYS_BASE', 'fa fa-fw fa-star-o', '', '4', '#', '', '', '15', '15', '1',
   '2017-09-10 10:26:09', '1', '2017-09-10 10:26:09', '1', '0', '');
INSERT INTO `t_oauth_menu` VALUES
  ('7', '6', '测试onclick菜单', NULL, 'SYS_BASE', 'fa fa-fw fa-lg fa-terminal', NULL, '3', '', 'alert(111);', '', '15',
   '15', '1', '2017-09-10 10:27:15', '1', '2017-09-10 10:27:15', '1', '0', '');
INSERT INTO `t_oauth_menu` VALUES
  ('8', '1', '菜单模块管理', '14', 'SYS_BASE', 'fa fa-fw fa-cubes', '', '1', '/oauth2/menuModule', '', '', '15', '15', '1',
   '2017-09-10 10:28:28', '1', '2017-09-10 10:28:28', '1', '3', '');
INSERT INTO `t_oauth_menu` VALUES
  ('9', '1', '角色权限配置', '22', 'SYS_BASE', 'fa fa-fw fa-users', '', '1', '/oauth2/privilege', '', '', '15', '15', '1',
   '2017-09-10 10:29:45', '1', '2017-09-10 10:29:45', '1', '1', '');
INSERT INTO `t_oauth_menu` VALUES
  ('10', '1', '系统参数管理', '16', 'SYS_BASE', 'fa fa-fw fa-cogs', '', '1', '/oauth2/systemParam', '', '', '15', '15', '1',
   '2017-09-10 18:04:53', '1', '2017-09-10 18:04:53', '1', '0', '');
INSERT INTO `t_oauth_menu` VALUES
  ('11', '1', '页面权限管理', '24', 'SYS_BASE', 'fa fa-fw fa-link', 'null', '1', '/oauth2/privilegePage', '', '', '15', '15',
   '1', '2017-09-10 18:08:23', '1', '2017-09-10 18:08:23', '1', '0', '');
INSERT INTO `t_oauth_menu` VALUES
  ('12', '2', '用户登录日志管理', '26', 'SYS_BASE', 'fa fa-fw fa-child', NULL, '1', '/oauth2/log', '', '', '15', '15', '1',
   '2017-09-11 09:36:45', '1', '2017-09-11 09:36:45', '1', '0', '');
INSERT INTO `t_oauth_menu` VALUES
  ('13', '0', '先搞一个目录', NULL, 'SYS_BASE', 'fa fa-fw fa-lg fa-bookmark-o', 'null', '4', '#', '', '', '15', '16', '1',
   '2017-09-12 14:49:05', '1', '2017-09-12 14:49:05', '1', '3', '');
INSERT INTO `t_oauth_menu` VALUES
  ('14', '13', '百度一下', NULL, 'SYS_BASE', '', NULL, '2', 'http://www.baidu.com', '', '_blank', '15', '16', '1',
   '2017-09-12 14:50:01', '1', '2017-09-12 14:50:01', '1', '0', '');
INSERT INTO `t_oauth_menu` VALUES
  ('15', '0', '首页', '33', 'SYS_BASE', 'fa fa-fw fa-lg fa-home', NULL, '1', '/oauth2/dashboard', '', '', '15', '15', '1',
   '2017-09-12 16:56:17', '1', '2017-09-12 16:56:17', '1', '0', '');

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
  AUTO_INCREMENT = 17
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_menu_module
-- ----------------------------
INSERT INTO `t_oauth_menu_module` VALUES
  ('2', '测试菜单模块A1', '', '', 'SYS_BASE_PLATFORM', '1', '2017-09-05 11:41:08', '1', '2017-08-18 17:25:36', '1', '0', '');
INSERT INTO `t_oauth_menu_module` VALUES
  ('4', '测试菜单模块B1', '', '', 'SYS_WECHAT_PLATFORM', '1', '2017-09-05 11:56:54', '1', '2017-08-18 18:56:43', '1', '0',
   '');
INSERT INTO `t_oauth_menu_module` VALUES
  ('8', '测试菜单模块A2', '', '', 'SYS_BASE_PLATFORM', '1', '2017-08-26 13:17:51', '1', '2017-08-26 13:17:51', '1', '0', '');
INSERT INTO `t_oauth_menu_module`
VALUES ('10', '11', '', '', 'SYS_BASE_PLATFORM', '1', '2017-09-04 15:07:12', '1', '2017-09-04 15:07:12', '1', '0', '');
INSERT INTO `t_oauth_menu_module`
VALUES ('12', '就用了', '', '', 'SYS_BASE_PLATFORM', '0', '2017-09-04 15:41:01', '1', '2017-09-04 15:41:01', '1', '0', '');
INSERT INTO `t_oauth_menu_module` VALUES
  ('13', '48563251202', '', '', 'SYS_BASE_PLATFORM', '0', '2017-09-04 15:41:21', '1', '2017-09-04 15:41:21', '1', '0',
   '');
INSERT INTO `t_oauth_menu_module` VALUES
  ('14', '老赖好记忆', '', '', 'SYS_WECHAT_PLATFORM', '1', '2017-09-04 15:43:05', '1', '2017-09-04 15:43:05', '1', '0', '');
INSERT INTO `t_oauth_menu_module` VALUES
  ('15', '系统管理', '', 'fa fa-laptop', 'SYS_BASE', '1', '2017-09-11 12:58:04', '1', '2017-09-08 22:04:57', '1', '0', '');
INSERT INTO `t_oauth_menu_module` VALUES
  ('16', '个人设置', '', 'fa fa-user', 'SYS_BASE', '1', '2017-09-11 13:05:45', '1', '2017-09-08 22:05:16', '1', '0', '');

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
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_operation_privilege_type
-- ----------------------------
INSERT INTO `t_oauth_operation_privilege_type`
VALUES ('1', '页面按钮', '1', '2017-08-11 00:25:52', '1', '2017-08-10 11:49:20', '1', '0', '页面上的按钮、表单等url');
INSERT INTO `t_oauth_operation_privilege_type`
VALUES ('2', '表格列', '1', '2017-08-11 00:26:58', '1', '2017-08-11 00:26:58', '1', '0', '表格的列按照角色权限来显示');
INSERT INTO `t_oauth_operation_privilege_type`
VALUES ('3', '啦啦啦啦啦', '0', '2017-09-07 15:21:34', '1', '2017-09-07 15:21:01', '1', '0', 'sad婚育与健康');

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
  AUTO_INCREMENT = 95
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_privilege_operation
-- ----------------------------
INSERT INTO `t_oauth_privilege_operation`
VALUES ('2', '测试权限资源1', '19', '8', '1', '1', '2017-08-23 13:53:14', '1', '2017-08-23 13:53:14', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('17', 'A测试2', '2', '7', '1', '1', '2017-08-23 19:55:50', '1', '2017-08-23 19:55:50', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('18', 'A测试5', '5', '10', '1', '1', '2017-08-24 10:22:08', '1', '2017-08-24 10:22:08', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('19', 'A测试7', '7', '7', '1', '1', '2017-08-24 10:39:58', '1', '2017-08-24 10:39:58', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('20', 'A测试12', '12', '8', '1', '1', '2017-08-24 17:25:01', '1', '2017-08-24 17:25:01', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('21', 'A测试9', '9', '7', '1', '1', '2017-08-25 11:45:00', '1', '2017-08-25 11:45:00', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('22', '添加新的菜单模块操作', '801', '14', '1', '1', '2017-09-08 16:38:33', '1', '2017-09-08 16:38:33', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('23', '删除菜单模块操作', '802', '14', '1', '1', '2017-09-08 16:38:46', '1', '2017-09-08 16:38:46', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('24', '获取菜单模块页面的数据', '803', '14', '1', '1', '2017-09-08 16:38:54', '1', '2017-09-08 16:38:54', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('25', '查找可用的菜单模块集合操作', '804', '14', '1', '1', '2017-09-08 16:39:00', '1', '2017-09-08 16:39:00', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('26', '修改菜单模块操作', '805', '14', '1', '1', '2017-09-08 16:39:05', '1', '2017-09-08 16:39:05', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('29', '添加用户', '863', '15', '1', '1', '2017-09-08 16:40:10', '1', '2017-09-08 16:40:10', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('30', '禁用用户', '864', '15', '1', '1', '2017-09-08 16:40:17', '1', '2017-09-08 16:40:17', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('31', '获取用户列表页面数据', '865', '15', '1', '1', '2017-09-08 16:40:24', '1', '2017-09-08 16:40:24', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('32', '编辑用户', '866', '15', '1', '1', '2017-09-08 16:40:32', '1', '2017-09-08 16:40:32', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('33', '修改用户密码', '867', '15', '1', '1', '2017-09-08 16:40:37', '1', '2017-09-08 16:40:37', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('34', '添加系统参数', '856', '16', '1', '1', '2017-09-08 16:40:52', '1', '2017-09-08 16:40:52', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('35', '编辑系统参数', '858', '16', '1', '1', '2017-09-08 16:40:57', '1', '2017-09-08 16:40:57', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('36', '获取系统参数列表页面的数据', '859', '16', '1', '1', '2017-09-08 16:41:02', '1', '2017-09-08 16:41:02', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('37', '获取用户登录日志列表', '789', '17', '1', '1', '2017-09-08 16:41:12', '1', '2017-09-08 16:41:12', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('39', '添加部门操作', '784', '18', '1', '1', '2017-09-08 16:41:30', '1', '2017-09-08 16:41:30', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('40', '获取部门列表数据', '785', '18', '1', '1', '2017-09-08 16:42:04', '1', '2017-09-08 16:42:04', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('41', '获取部门树形结构操作', '786', '18', '1', '1', '2017-09-08 16:42:11', '1', '2017-09-08 16:42:11', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('42', '编辑部门操作', '787', '18', '1', '1', '2017-09-08 16:42:17', '1', '2017-09-08 16:42:17', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('43', '添加新资源操作', '832', '19', '1', '1', '2017-09-08 16:48:42', '1', '2017-09-08 16:48:42', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('44', '删除资源信息操作', '833', '19', '1', '1', '2017-09-08 16:49:12', '1', '2017-09-08 16:49:12', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('45', '获取资源列表页面数据', '834', '19', '1', '1', '2017-09-08 16:49:17', '1', '2017-09-08 16:49:17', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('46', '编辑资源信息操作', '835', '19', '1', '1', '2017-09-08 16:49:23', '1', '2017-09-08 16:49:23', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation` VALUES
  ('47', '获取资源列表弹框选择页面的数据', '836', '19', '1', '1', '2017-09-08 16:49:28', '1', '2017-09-08 16:49:28', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('48', '添加新资源模块操作', '826', '20', '1', '1', '2017-09-08 16:49:43', '1', '2017-09-08 16:49:43', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('49', '删除资源模块操作', '827', '20', '1', '1', '2017-09-08 16:49:48', '1', '2017-09-08 16:49:48', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('50', '查询出资源模块树', '828', '20', '1', '1', '2017-09-08 16:49:52', '1', '2017-09-08 16:49:52', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('51', '获取资源模块管理页面的数据', '829', '20', '1', '1', '2017-09-08 16:49:58', '1', '2017-09-08 16:49:58', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('52', '修改资源模块操作', '830', '20', '1', '1', '2017-09-08 16:50:05', '1', '2017-09-08 16:50:05', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('53', '添加操作级权限类型操作', '807', '21', '1', '1', '2017-09-08 16:50:17', '1', '2017-09-08 16:50:17', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation` VALUES
  ('54', '查询可用的操作级权限类型的操作', '808', '21', '1', '1', '2017-09-08 16:50:26', '1', '2017-09-08 16:50:26', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('55', '编辑操作级权限类型对象操作', '810', '21', '1', '1', '2017-09-08 16:50:30', '1', '2017-09-08 16:50:30', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('56', '获取异步加载权限资源的操作', '812', '22', '1', '1', '2017-09-08 16:50:59', '1', '2017-09-08 16:50:59', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('57', '分配操作权限的操作', '813', '22', '1', '1', '2017-09-08 16:51:06', '1', '2017-09-08 16:51:06', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('58', '添加操作级权限操作', '815', '23', '1', '1', '2017-09-08 16:51:23', '1', '2017-09-08 16:51:23', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('59', '删除操作级权限操作', '816', '23', '1', '1', '2017-09-08 16:51:27', '1', '2017-09-08 16:51:27', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('60', '获取操作级权限页面数据', '817', '23', '1', '1', '2017-09-08 16:51:32', '1', '2017-09-08 16:51:32', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('61', '编辑操作级权限操作', '818', '23', '1', '1', '2017-09-08 16:51:37', '1', '2017-09-08 16:51:37', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('63', '添加页面级权限的操作', '821', '24', '1', '1', '2017-09-08 16:51:52', '1', '2017-09-08 16:51:52', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('64', '删除页面级权限的操作', '822', '24', '1', '1', '2017-09-08 16:51:56', '1', '2017-09-08 16:51:56', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('65', '获取页面级权限列表的操作', '823', '24', '1', '1', '2017-09-08 16:52:01', '1', '2017-09-08 16:52:01', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('66', '编辑页面级权限的操作', '824', '24', '1', '1', '2017-09-08 16:52:05', '1', '2017-09-08 16:52:05', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('67', '添加一个新角色的操作', '839', '25', '1', '1', '2017-09-08 16:52:31', '1', '2017-09-08 16:52:31', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('68', '修改一个角色对象的操作', '840', '25', '1', '1', '2017-09-08 16:52:38', '1', '2017-09-08 16:52:38', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('69', '获取角色列表页面的数据', '842', '25', '1', '1', '2017-09-08 16:52:43', '1', '2017-09-08 16:52:43', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('70', '获取角色列表页面的数据', '842', '25', '1', '1', '2017-09-08 16:52:51', '1', '2017-09-08 16:52:51', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('71', '获取会话列表页面的数据', '845', '28', '1', '1', '2017-09-08 16:59:52', '1', '2017-09-08 16:59:52', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('72', '获取菜单表格树数据', '798', '29', '1', '1', '2017-09-08 17:02:09', '1', '2017-09-08 17:02:09', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('73', '添加菜单操作', '795', '29', '1', '1', '2017-09-08 17:02:17', '1', '2017-09-08 17:02:17', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('74', '编辑菜单操作', '797', '29', '1', '1', '2017-09-08 17:02:25', '1', '2017-09-08 17:02:25', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('75', '删除菜单操作', '796', '29', '1', '1', '2017-09-08 17:02:32', '1', '2017-09-08 17:02:32', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('77', '根据菜单模块查找菜单树操作', '799', '30', '1', '1', '2017-09-08 17:05:59', '1', '2017-09-08 17:05:59', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('78', '获取用户登录图表数据', '791', '27', '1', '1', '2017-09-08 17:18:30', '1', '2017-09-08 17:18:30', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('79', '获取操作级权限列表页面的数据', '809', '23', '1', '1', '2017-09-08 17:18:45', '1', '2017-09-08 17:18:45', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation` VALUES
  ('80', '根据父节点和系统模块获取该节点下面的树数据', '841', '25', '1', '1', '2017-09-08 17:19:55', '1', '2017-09-08 17:19:55', '1', '0',
   '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('81', '强制踢出用户', '844', '28', '1', '1', '2017-09-08 17:20:14', '1', '2017-09-08 17:20:14', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation` VALUES
  ('82', '表格中使用系统模块查询的下拉框操作', '846', '33', '1', '1', '2017-09-08 17:24:57', '1', '2017-09-08 17:24:57', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('83', '公共的下拉框搜索对象的值', '847', '33', '1', '1', '2017-09-08 17:25:01', '1', '2017-09-08 17:25:01', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('84', '系统模块的添加处理', '849', '34', '1', '1', '2017-09-08 17:25:39', '1', '2017-09-08 17:25:39', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('85', '删除系统模块处理操作', '850', '34', '1', '1', '2017-09-08 17:25:44', '1', '2017-09-08 17:25:44', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('86', '获取系统模块列表页面的数据', '851', '34', '1', '1', '2017-09-08 17:25:49', '1', '2017-09-08 17:25:49', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('87', '获取所有可用的系统模块', '852', '34', '1', '1', '2017-09-08 17:25:54', '1', '2017-09-08 17:25:54', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation` VALUES
  ('88', '获取系统模块的zTree树，无异步加载', '853', '34', '1', '1', '2017-09-08 17:26:26', '1', '2017-09-08 17:26:26', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('89', '修改系统模块的操作', '854', '34', '1', '1', '2017-09-08 17:26:31', '1', '2017-09-08 17:26:31', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('90', '删除参数', '857', '16', '1', '1', '2017-09-08 17:26:39', '1', '2017-09-08 17:26:39', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('91', '添加菜单查找带回的权限资源', '869', '14', '1', '1', '2017-09-09 20:55:16', '1', '2017-09-09 20:55:16', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('92', '首页获取左侧菜单', '870', '29', '1', '1', '2017-09-10 11:04:53', '1', '2017-09-10 11:04:53', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('93', '获取当前登录用户登录信息', '872', '15', '1', '1', '2017-09-11 09:23:58', '1', '2017-09-11 09:23:58', '1', '0', '');
INSERT INTO `t_oauth_privilege_operation`
VALUES ('94', '首页获取左侧菜单', '871', '33', '1', '1', '2017-09-11 09:24:06', '1', '2017-09-11 09:24:06', '1', '0', '');

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
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_privilege_page
-- ----------------------------
INSERT INTO `t_oauth_privilege_page`
VALUES ('7', '测试页面资源1', '6', '1', '1', '2017-08-23 19:42:44', '1', '2017-08-22 11:37:58', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('8', '测试页面资源2', '10', '1', '1', '2017-08-23 19:42:51', '1', '2017-08-22 11:38:08', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('9', '测试页面资源3', '114', '4', '1', '2017-08-23 19:43:02', '1', '2017-08-22 11:38:17', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('10', '测试页面资源4', '9', '3', '1', '2017-08-23 19:43:15', '1', '2017-08-22 11:38:31', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('11', '测试页面资源5', '15', '3', '1', '2017-08-23 19:43:19', '1', '2017-08-22 11:48:57', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('12', '测试页面资源6', '85', '2', '1', '2017-08-23 19:43:23', '1', '2017-08-22 11:50:03', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('13', '测试页面资源7', '5', '1', '1', '2017-08-23 19:43:28', '1', '2017-08-23 19:42:25', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('14', '菜单模块', '800', '9', '1', '2017-09-08 16:36:18', '1', '2017-09-08 16:36:18', '1', '0', '把菜单分类成几大模块');
INSERT INTO `t_oauth_privilege_page`
VALUES ('15', '用户管理', '860', '9', '1', '2017-09-08 16:36:37', '1', '2017-09-08 16:36:37', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('16', '系统参数列表页面', '855', '9', '1', '2017-09-08 16:36:52', '1', '2017-09-08 16:36:52', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('17', '用户登录日志列表展示页面', '788', '9', '1', '2017-09-08 16:37:09', '1', '2017-09-08 16:37:09', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('18', '部门列表展示页面', '782', '9', '1', '2017-09-08 16:37:20', '1', '2017-09-08 16:37:20', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('19', '资源管理列表', '831', '10', '1', '2017-09-08 16:45:05', '1', '2017-09-08 16:45:05', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('20', '资源模块管理列表', '825', '10', '1', '2017-09-08 16:45:23', '1', '2017-09-08 16:45:23', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('21', '操作级权限类型管理列表', '806', '10', '1', '2017-09-08 16:45:56', '1', '2017-09-08 16:45:56', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('22', '权限配置页面', '811', '10', '1', '2017-09-08 16:46:38', '1', '2017-09-08 16:46:38', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('23', '操作级权限管理页面', '814', '10', '1', '2017-09-08 16:46:57', '1', '2017-09-08 16:46:57', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('24', '页面级权限管理页面', '819', '10', '1', '2017-09-08 16:47:22', '1', '2017-09-08 16:47:22', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('25', '角色列表页面', '837', '10', '1', '2017-09-08 16:47:35', '1', '2017-09-08 16:47:35', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('26', '用户登录日志管理列表', '788', '13', '1', '2017-09-08 16:59:14', '1', '2017-09-08 16:59:02', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('27', '用户登录统计管理', '790', '13', '1', '2017-09-08 16:59:28', '1', '2017-09-08 16:59:28', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('28', '会话列表页面', '843', '13', '1', '2017-09-08 16:59:42', '1', '2017-09-08 16:59:42', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('29', '菜单管理', '792', '9', '1', '2017-09-08 17:00:58', '1', '2017-09-08 17:00:58', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('30', '选择父级菜单的弹出框页面', '794', '9', '1', '2017-09-08 17:01:31', '1', '2017-09-08 17:01:31', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('31', '获取资源弹出框页面', '793', '9', '1', '2017-09-08 17:01:37', '1', '2017-09-08 17:01:37', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('32', '角色树页面', '838', '10', '1', '2017-09-08 17:18:58', '1', '2017-09-08 17:18:58', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('33', '首页', '868', '14', '1', '2017-09-08 17:24:53', '1', '2017-09-08 17:24:53', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('34', '多模块系统管理', '848', '9', '1', '2017-09-08 17:25:32', '1', '2017-09-08 17:25:32', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('35', '用户部门选择弹框页面', '861', '9', '1', '2017-09-08 17:27:00', '1', '2017-09-08 17:27:00', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('36', '用户角色选择弹框页面', '862', '9', '1', '2017-09-08 17:27:03', '1', '2017-09-08 17:27:03', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('37', '父部门节点的树展示页面', '783', '9', '1', '2017-09-09 09:04:20', '1', '2017-09-09 09:04:20', '1', '0', '');
INSERT INTO `t_oauth_privilege_page`
VALUES ('38', '获取的资源树弹出框', '820', '10', '1', '2017-09-09 09:09:22', '1', '2017-09-09 09:09:22', '1', '0', '');

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
  `permission_mark` VARCHAR(50)      NOT NULL
  COMMENT '权限标识',
  `system_code`     VARCHAR(20)      NOT NULL
  COMMENT '系统模块代码',
  `enabled`         TINYINT(1)       NOT NULL DEFAULT '1'
  COMMENT '是否可用',
  `update_date`     DATETIME                  DEFAULT CURRENT_TIMESTAMP
  COMMENT '修改时间',
  `update_user`     INT(11)                   DEFAULT NULL
  COMMENT '修改人',
  `create_date`     DATETIME                  DEFAULT NULL
  COMMENT '创建日期',
  `create_user`     INT(11)                   DEFAULT NULL
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
  AUTO_INCREMENT = 873
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
  ('3', '/management/atest3', 'A测试3', 'sys:atest3:list', 'SYS_WECHAT_PLATFORM', '1', '2017-09-07 15:33:23', '1',
        '2017-08-14 13:55:13', '1', '0', '奥术大师大所多');
INSERT INTO `t_oauth_resource` VALUES
  ('4', '/management/atest4', 'A测试4', 'sys:atest4:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
        '2017-08-15 13:56:37', '1', '4', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('5', '/management/atest5', 'A测试5', 'sys:atest5:list', 'SYS_BASE_PLATFORM', '1', '2017-08-15 13:56:37', '1',
        '2017-08-15 13:56:37', '1', '5', NULL);
INSERT INTO `t_oauth_resource` VALUES
  ('6', '/management/atest6', 'A测试6', 'sys:atest6:list', 'SYS_BASE_PLATFORM', '1', '2017-08-24 17:00:46', '1',
        '2017-08-15 13:56:37', '1', '6', '');
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
INSERT INTO `t_oauth_resource` VALUES
  ('199', '/dasdasdsa', 'dasdsa', 'dasdasdas', 'SYS_BASE_PLATFORM', '1', '2017-09-07 22:21:42', '1',
          '2017-09-07 22:21:42', '1', '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('200', '/dffdfdfdfdf', 'fdfdfd', 'fdfdfdfdfdf', 'SYS_BASE_PLATFORM', '1', '2017-09-07 22:28:41', '1',
          '2017-09-07 22:28:41', '1', '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('782', '/oauth2/department', '部门列表展示页面', 'base:department:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL,
          NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('783', '/oauth2/department/tree', '父部门节点的树展示页面', 'base:department:tree', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('784', '/oauth2/department/api/add', '添加部门操作', 'base:department:add', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL,
          NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('785', '/oauth2/department/api/list', '获取部门列表数据', 'base:department:list', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('786', '/oauth2/department/api/selectDepartment', '获取部门树形结构操作', 'base:department:selectDepartment', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('787', '/oauth2/department/api/edit', '编辑部门操作', 'base:department:edit', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL,
          NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('788', '/oauth2/log', '用户登录日志列表展示页面', 'base:log:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL, NULL, '0',
   '');
INSERT INTO `t_oauth_resource` VALUES
  ('789', '/oauth2/log/api/list', '获取用户登录日志列表', 'base:log:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL,
          NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('790', '/oauth2/loginsum', '用户登录图标展示页面', 'base:loginsum:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL,
          NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('791', '/oauth2/loginsum/api/charts', '获取用户登录图标数据', 'base:loginsum:charts', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('792', '/oauth2/menu', '菜单树列表表格页面展示', 'base:menu:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL, NULL,
          '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('793', '/oauth2/menu/resourceSelect', '勾选菜单的对应的资源弹出框页面', 'base:menu:resourceSelect', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('794', '/oauth2/menu/parentTree', '选择父级菜单的弹出框页面', 'base:menu:parentTree', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('795', '/oauth2/menu/api/add', '添加菜单操作', 'base:menu:add', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL, NULL,
          '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('796', '/oauth2/menu/api/delete', '删除菜单操作', 'base:menu:delete', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL,
          NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('797', '/oauth2/menu/api/edit', '编辑菜单操作', 'base:menu:edit', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL, NULL,
          '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('798', '/oauth2/menu/api/list', '获取菜单表格树数据', 'base:menu:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL,
          NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('799', '/oauth2/menu/api/menuTree', '根据菜单模块查找菜单树操作', 'base:menu:menuTree', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('800', '/oauth2/menuModule', '菜单模块页面展示', 'base:menuModule:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL,
          NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('801', '/oauth2/menuModule/api/add', '添加新的菜单模块操作', 'base:menuModule:add', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('802', '/oauth2/menuModule/api/delete', '删除菜单模块操作', 'base:menuModule:delete', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('803', '/oauth2/menuModule/api/list', '获取菜单模块页面的数据', 'base:menuModule:list', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('804', '/oauth2/menuModule/api/find/enables', '查找可用的菜单模块集合操作', 'base:menuModule:enables', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('805', '/oauth2/menuModule/api/edit', '修改菜单模块操作', 'base:menuModule:edit', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('806', '/oauth2/operationPrivilegeType', '操作级权限类型列表页面', 'base:operationPrivilegeType:list', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('807', '/oauth2/operationPrivilegeType/api/add', '添加操作级权限类型操作', 'base:operationPrivilegeType:add', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('808', '/oauth2/operationPrivilegeType/api/find/operationType/enabled', '查询可用的操作级权限类型的操作',
          'base:operationPrivilegeType:enabled', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('809', '/oauth2/operationPrivilegeType/api/list', '获取操作级权限列表页面的数据', 'base:operationPrivilegeType:list', 'SYS_BASE',
          '1', '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('810', '/oauth2/operationPrivilegeType/api/edit', '编辑操作级权限类型对象操作', 'base:operationPrivilegeType:edit', 'SYS_BASE',
          '1', '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('811', '/oauth2/privilege', '权限配置页面', 'base:privilege:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL,
          NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('812', '/oauth2/privilege/api/getAjaxPrivilegeData', '获取异步加载权限资源的操作', 'base:privilege:getAjaxPrivilegeData',
          'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('813', '/oauth2/privilege/api/setPrivilege', '分配操作权限的操作', 'base:privilege:setPrivilege', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('814', '/oauth2/privilegeOperation', '操作级权限页面', 'base:privilegeOperation:list', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('815', '/oauth2/privilegeOperation/api/add', '添加操作级权限操作', 'base:privilegeOperation:add', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('816', '/oauth2/privilegeOperation/api/delete', '删除操作级权限操作', 'base:privilegeOperation:delete', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('817', '/oauth2/privilegeOperation/api/list', '获取操作级权限页面数据', 'base:privilegeOperation:list', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('818', '/oauth2/privilegeOperation/api/edit', '编辑操作级权限操作', 'base:privilegeOperation:edit', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('819', '/oauth2/privilegePage', '页面级权限页面', 'base:privilegePage:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL,
          NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('820', '/oauth2/privilegePage/resourceSelect', '获取资源树页面', 'base:privilegePage:resourceSelect', 'SYS_BASE', '1',
          '2017-09-09 21:05:05', '1', NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('821', '/oauth2/privilegePage/api/add', '添加页面级权限的操作', 'base:privilegePage:add', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('822', '/oauth2/privilegePage/api/delete', '删除页面级权限的操作', 'base:privilegePage:delete', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('823', '/oauth2/privilegePage/api/list', '获取页面级权限列表的操作', 'base:privilegePage:list', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('824', '/oauth2/privilegePage/api/edit', '编辑页面级权限的操作', 'base:privilegePage:edit', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('825', '/oauth2/resModule', '资源模块列表页面', 'base:resModule:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL,
          NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('826', '/oauth2/resModule/api/add', '添加新资源模块操作', 'base:resModule:add', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL,
          NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('827', '/oauth2/resModule/api/delete', '删除资源模块操作', 'base:resModule:delete', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('828', '/oauth2/resModule/api/resModuleTree', '查询出资源模块树', 'base:resModule:resModuleTree', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('829', '/oauth2/resModule/api/list', '获取资源模块管理页面的数据', 'base:resModule:list', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('830', '/oauth2/resModule/api/edit', '修改资源模块操作', 'base:resModule:edit', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL,
          NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('831', '/oauth2/resource', '资源列表页面', 'base:resource:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL, NULL,
          '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('832', '/oauth2/resource/api/add', '添加新资源操作', 'base:resource:add', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL,
          NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('833', '/oauth2/resource/api/delete', '删除资源信息操作', 'base:resource:delete', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('834', '/oauth2/resource/api/list', '获取资源列表页面数据', 'base:resource:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL,
          NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('835', '/oauth2/resource/api/edit', '编辑资源信息操作', 'base:resource:edit', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL,
          NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('836', '/oauth2/resource/api/selectResources', '获取资源列表弹框选择页面的数据', 'base:resource:selectResources', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('837', '/oauth2/role', '角色列表页面', 'base:role:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL, NULL, '0',
   '');
INSERT INTO `t_oauth_resource` VALUES
  ('838', '/oauth2/role/tree', '角色树页面', 'base:role:tree', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL, NULL, '0',
   '');
INSERT INTO `t_oauth_resource` VALUES
  ('839', '/oauth2/role/api/add', '添加一个新角色的操作', 'base:role:add', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL,
          NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('840', '/oauth2/role/api/edit', '修改一个角色对象的操作', 'base:role:edit', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL,
          NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('841', '/oauth2/role/api/selectRole', '根据父节点和系统模块获取该节点下面的树数据', 'base:role:selectRole', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('842', '/oauth2/role/api/list', '获取角色列表页面的数据', 'base:role:tree', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL,
          NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('843', '/oauth2/session', '会话列表页面', 'base:session:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL, NULL,
          '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('844', '/oauth2/session/api/forcelogout', '强制踢出用户', 'base:session:forcelogout', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('845', '/oauth2/session/api/list', '获取会话列表页面的数据', 'base:session:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL,
          NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('846', '/oauth2/systemModule/select', '表格中使用系统模块查询的下拉框操作', 'base:support:commonSelect', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('847', '/oauth2/common/select', '公共的下拉框搜索对象的值', 'base:support:commonSelect', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('848', '/oauth2/systemModule', '系统模块列表页面', 'base:systemModule:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL,
          NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('849', '/oauth2/systemModule/api/add', '系统模块的添加处理', 'base:systemModule:add', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('850', '/oauth2/systemModule/api/delete', '删除系统模块处理操作', 'base:systemModule:delete', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('851', '/oauth2/systemModule/api/list', '获取系统模块列表页面的数据', 'base:systemModule:list', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('852', '/oauth2/systemModule/api/find/modules/enabled', '获取所有可用的系统模块', 'base:systemModule:enabled', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('853', '/oauth2/systemModule/api/find/modules/enabled/moduleTree', '获取系统模块的zTree树，无异步加载',
          'base:systemModule:moduleTree', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('854', '/oauth2/systemModule/api/edit', '修改系统模块的操作', 'base:systemModule:edit', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('855', '/oauth2/systemParam', '系统参数列表页面', 'base:systemParam:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL,
          NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('856', '/oauth2/systemParam/api/add', '添加系统参数', 'base:systemParam:add', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL,
          NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('857', '/oauth2/systemParam/api/delete', '删除参数', 'base:systemParam:delete', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('858', '/oauth2/systemParam/api/edit', '编辑系统参数', 'base:systemParam:edit', 'SYS_BASE', '1', '2017-09-08 15:40:06',
          NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('859', '/oauth2/systemParam/api/list', '获取系统参数列表页面的数据', 'base:systemParam:list', 'SYS_BASE', '1',
          '2017-09-08 15:40:06', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('860', '/oauth2/user', '用户列表页面', 'base:user:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL, NULL, '0',
   '');
INSERT INTO `t_oauth_resource` VALUES
  ('861', '/oauth2/user/treeDept', '用户部门选择弹框页面', 'base:user:treeDept', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL,
          NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('862', '/oauth2/user/treeRole', '用户角色选择弹框页面', 'base:user:treeRole', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL,
          NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('863', '/oauth2/user/api/add', '添加用户', 'base:user:add', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL, NULL,
          '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('864', '/oauth2/user/api/delete', '禁用用户', 'base:user:delete', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL,
          NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('865', '/oauth2/user/api/list', '获取用户列表页面数据', 'base:user:list', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL,
          NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('866', '/oauth2/user/api/edit', '编辑用户', 'base:user:edit', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL, NULL,
          '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('867', '/oauth2/user/api/editPwd', '修改用户密码', 'base:user:editPwd', 'SYS_BASE', '1', '2017-09-08 15:40:06', NULL, NULL,
          NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('868', '/oauth2/dashboard', '首页', 'base:dashboard:view', 'SYS_BASE', '1', '2017-09-08 17:24:41', '1',
          '2017-09-08 17:24:41', '1', '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('869', '/oauth2/menu/api/addMenuRes', '添加菜单查找带回的权限资源', 'base:menu:addMenuRes', 'SYS_BASE', '1',
          '2017-09-09 20:54:41', '1', '2017-09-09 20:54:41', '1', '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('870', '/oauth/menu/api/getMenuListIndex', '首页获取左侧菜单', 'base:menu:getMenuListIndex', 'SYS_BASE', '1',
          '2017-09-10 11:04:39', '1', '2017-09-10 11:04:26', '1', '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('871', '/oauth2/menu/api/getMenuListIndex', '首页获取左侧菜单', 'base:menu:getMenuListIndex', 'SYS_BASE', '1',
          '2017-09-11 09:23:18', NULL, NULL, NULL, '0', '');
INSERT INTO `t_oauth_resource` VALUES
  ('872', '/oauth2/user/api/info', '获取当前登录用户登录信息', 'base:user:info', 'SYS_BASE', '1', '2017-09-11 09:23:19', NULL, NULL,
          NULL, '0', '');

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
  AUTO_INCREMENT = 15
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_resource_module
-- ----------------------------
INSERT INTO `t_oauth_resource_module`
VALUES ('1', 'A系统管理', 'SYS_BASE_PLATFORM', '1', '2017-08-19 11:15:46', '1', '2017-08-09 19:41:26', '1', '0', '');
INSERT INTO `t_oauth_resource_module`
VALUES ('2', 'A个人信息管理', 'SYS_BASE_PLATFORM', '1', '2017-08-31 17:08:08', '1', '2017-08-14 11:59:02', '1', '0', '');
INSERT INTO `t_oauth_resource_module`
VALUES ('3', 'A系统日志及监控', 'SYS_BASE_PLATFORM', '1', '2017-08-19 11:15:52', '1', '2017-08-14 11:59:13', '1', '0', '');
INSERT INTO `t_oauth_resource_module`
VALUES ('4', 'B系统管理', 'SYS_WECHAT_PLATFORM', '1', '2017-08-19 11:16:11', '1', '2017-08-14 12:02:23', '1', '0', '');
INSERT INTO `t_oauth_resource_module` VALUES
  ('9', '系统管理', 'SYS_BASE', '1', '2017-09-08 16:31:52', '1', '2017-09-08 16:31:25', '1', '0', '菜单模块、用户、系统参数、日志、部门');
INSERT INTO `t_oauth_resource_module`
VALUES ('10', '资源权限管理', 'SYS_BASE', '1', '2017-09-08 16:32:32', '1', '2017-09-08 16:32:32', '1', '0', '资源、权限、角色');
INSERT INTO `t_oauth_resource_module`
VALUES ('13', '系统日志及监控', 'SYS_BASE', '1', '2017-09-08 16:58:32', '1', '2017-09-08 16:58:27', '1', '0', '');
INSERT INTO `t_oauth_resource_module`
VALUES ('14', '其他模块', 'SYS_BASE', '1', '2017-09-08 17:20:37', '1', '2017-09-08 17:20:37', '1', '0', '');

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
  AUTO_INCREMENT = 16
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
  ('4', 'ROLE_WECHAT_ADMIN', 'B角色1.1', '3', 'SYS_WECHAT_PLATFORM', '2017-08-08 20:23:22', '1', '2017-08-24 11:46:28',
        '1', '0', '微信管理平台管理员', '1');
INSERT INTO `t_oauth_role` VALUES
  ('5', 'ROLE_WECHAT_DEVELOPER', 'B角色2', '0', 'SYS_WECHAT_PLATFORM', '2017-08-08 20:23:58', '1', '2017-08-14 15:19:32',
        '1', '0', '微信通用管理平台开发人员', '1');
INSERT INTO `t_oauth_role` VALUES
  ('6', 'ROLE_TEST_1_2', 'B角色1.2', '3', 'SYS_WECHAT_PLATFORM', '2017-08-25 11:02:02', '1', '2017-08-25 11:02:02', '1',
        '0', '', '1');
INSERT INTO `t_oauth_role` VALUES
  ('7', 'ROLE_TEST_2_1', 'B角色2.1', '5', 'SYS_WECHAT_PLATFORM', '2017-08-25 11:02:24', '1', '2017-08-25 11:02:24', '1',
        '0', '', '1');
INSERT INTO `t_oauth_role` VALUES
  ('8', 'ROLE_TEST_3', 'B角色3', '0', 'SYS_WECHAT_PLATFORM', '2017-08-25 11:50:17', '1', '2017-08-25 11:50:17', '1', '0',
        '', '1');
INSERT INTO `t_oauth_role` VALUES
  ('9', 'ROLE_TEST_4', 'B角色4', '0', 'SYS_WECHAT_PLATFORM', '2017-08-25 11:50:35', '1', '2017-08-25 11:50:35', '1', '0',
        '', '1');
INSERT INTO `t_oauth_role` VALUES
  ('10', 'ROLE_TEST_5', 'B角色5', '0', 'SYS_WECHAT_PLATFORM', '2017-08-25 11:50:41', '1', '2017-08-25 11:50:41', '1', '0',
         '', '1');
INSERT INTO `t_oauth_role` VALUES
  ('11', 'ROLE_TEST_6', 'B角色6', '0', 'SYS_WECHAT_PLATFORM', '2017-08-25 11:50:47', '1', '2017-08-25 11:50:47', '1', '0',
         '', '1');
INSERT INTO `t_oauth_role` VALUES
  ('12', 'ROLE_TEST_3_1', 'B角色3.1', '8', 'SYS_WECHAT_PLATFORM', '2017-08-25 11:50:57', '1', '2017-08-25 11:50:57', '1',
         '0', '', '1');
INSERT INTO `t_oauth_role` VALUES
  ('13', 'ROLE_TEST_1_1', 'A角色1.1', '1', 'SYS_BASE_PLATFORM', '2017-08-25 13:56:41', '1', '2017-08-25 13:56:41', '1',
         '0', '', '1');
INSERT INTO `t_oauth_role` VALUES
  ('14', 'ROLE_DEV', '开发者', '0', 'SYS_BASE_PLATFORM', '2017-09-05 11:38:32', '1', '2017-09-05 11:38:32', '1', '0', '',
   '1');
INSERT INTO `t_oauth_role` VALUES
  ('15', 'ROLE_BASE_SA', '超级管理开发人员', '0', 'SYS_BASE', '2017-09-13 15:43:45', '1', '2017-09-08 15:44:09', '1', '0',
         'BASE平台超级管理开发人员', '1');

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
INSERT INTO `t_oauth_role_resource` VALUES ('2', '85', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('4', '114', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('2', '6', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('2', '2', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('2', '7', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('2', '15', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('1', '15', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('1', '85', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('13', '6', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('13', '7', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('13', '9', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('13', '10', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('13', '19', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('13', '12', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('13', '85', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('1', '10', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('1', '19', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('1', '12', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('1', '6', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('1', '9', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('6', '114', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('1', '2', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('8', '114', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('13', '2', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '782', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '783', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '784', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '785', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '786', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '787', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '788', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '790', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '809', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '810', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '811', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '812', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '813', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '814', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '815', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '816', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '817', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '818', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '819', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '820', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '821', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '822', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '846', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '847', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '848', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '849', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '850', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '851', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '852', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '853', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '854', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '855', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '856', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '857', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '858', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '859', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '860', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '861', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '862', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '863', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '864', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '865', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '866', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '867', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '791', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '792', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '793', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '794', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '795', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '796', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '797', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '798', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '799', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '800', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '801', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '802', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '803', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '804', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '805', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '806', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '807', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '808', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '823', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '824', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '825', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '826', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '827', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '828', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '829', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '830', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '831', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '832', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '833', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '834', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '835', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '836', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '837', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '838', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '839', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '840', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '841', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '842', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '843', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '844', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '845', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '789', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '869', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '870', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '868', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '871', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('15', '872', '1');
INSERT INTO `t_oauth_role_resource` VALUES ('7', '114', '1');

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
  AUTO_INCREMENT = 102
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_session
-- ----------------------------
INSERT INTO `t_oauth_session` VALUES ('18', 'sa', '5b4cf345-4a62-4ecc-880d-28174a8743e3',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDViNGNmMzQ1LTRhNjItNGVjYy04ODBkLTI4MTc0YTg3NDNlM3NyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5lvCJNeHNxAH4AA3cIAAABXmW8c3h4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAR0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQADC9vYXV0aDIvbWVudXQAUG9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5zdXBwb3J0LkRlZmF1bHRTdWJqZWN0Q29udGV4dF9BVVRIRU5USUNBVEVEX1NFU1NJT05fS0VZc3IAEWphdmEubGFuZy5Cb29sZWFuzSBygNWc+u4CAAFaAAV2YWx1ZXhwAXQAGGJlZm9yZS5sb2dpbi5zdWNjZXNzLnVybHQAPS9vYXV0aDIvbWVudU1vZHVsZS9hcGkvZmluZC9lbmFibGVzP3N5c3RlbU1vZHVsZUNvZGU9U1lTX0JBU0V0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAGP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8yc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAYeHh4',
                                            '127.0.0.1', '2017-09-09 16:23:02', '2017-09-09 16:23:23', '1800000',
                                            'http://127.0.0.1:8082/oauth2/role/api/selectRole',
                                            'http://127.0.0.1:8082/oauth2/menuModule/api/find/enables',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('22', '127.0.0.1', '5d3faecb-d877-4c74-b642-2db7881ddc3a',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDVkM2ZhZWNiLWQ4NzctNGM3NC1iNjQyLTJkYjc4ODFkZGMzYXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5ms/S6eHNxAH4AA3cIAAABXmbmHYF4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAR0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQADC9vYXV0aDIvbWVudXQAUG9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5zdXBwb3J0LkRlZmF1bHRTdWJqZWN0Q29udGV4dF9BVVRIRU5USUNBVEVEX1NFU1NJT05fS0VZc3IAEWphdmEubGFuZy5Cb29sZWFuzSBygNWc+u4CAAFaAAV2YWx1ZXhwAXQAGGJlZm9yZS5sb2dpbi5zdWNjZXNzLnVybHQAFS9vYXV0aDIvbWVudS9hcGkvbGlzdHQATW9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5zdXBwb3J0LkRlZmF1bHRTdWJqZWN0Q29udGV4dF9QUklOQ0lQQUxTX1NFU1NJT05fS0VZc3IAMm9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5TaW1wbGVQcmluY2lwYWxDb2xsZWN0aW9uqH9YJcajCEoDAAFMAA9yZWFsbVByaW5jaXBhbHN0AA9MamF2YS91dGlsL01hcDt4cHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaE1hcDTATlwQbMD7AgABWgALYWNjZXNzT3JkZXJ4cQB+AAY/QAAAAAAADHcIAAAAEAAAAAF0ADltZS53dXdlbmJpbi5pdGVtcy5vYXV0aDIuY29uZmlnLnN1cHBvcnQucmVhbG0uVXNlclJlYWxtXzBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hTZXTYbNdald0qHgIAAHhyABFqYXZhLnV0aWwuSGFzaFNldLpEhZWWuLc0AwAAeHB3DAAAAAI/QAAAAAAAAXQAAnNheHgAdwEBcQB+ABh4eHg=',
                                            '127.0.0.1', '2017-09-09 20:53:43', '2017-09-09 21:48:30', '1800000',
                                            'http://127.0.0.1:8082/oauth2/menu',
                                            'http://127.0.0.1:8082/oauth2/menu/api/list',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('39', 'sa', '17cb2c84-f1f1-4426-9d54-3194800305fb',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDE3Y2IyYzg0LWYxZjEtNDQyNi05ZDU0LTMxOTQ4MDAzMDVmYnNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5rNT9qeHNxAH4AA3cIAAABXmtKUW94dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAR0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQAFS9vYXV0aDIvdXNlci9hcGkvaW5mb3QAUG9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5zdXBwb3J0LkRlZmF1bHRTdWJqZWN0Q29udGV4dF9BVVRIRU5USUNBVEVEX1NFU1NJT05fS0VZc3IAEWphdmEubGFuZy5Cb29sZWFuzSBygNWc+u4CAAFaAAV2YWx1ZXhwAXQAGGJlZm9yZS5sb2dpbi5zdWNjZXNzLnVybHQAFS9vYXV0aDIvbWVudS9hcGkvbGlzdHQATW9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5zdXBwb3J0LkRlZmF1bHRTdWJqZWN0Q29udGV4dF9QUklOQ0lQQUxTX1NFU1NJT05fS0VZc3IAMm9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5TaW1wbGVQcmluY2lwYWxDb2xsZWN0aW9uqH9YJcajCEoDAAFMAA9yZWFsbVByaW5jaXBhbHN0AA9MamF2YS91dGlsL01hcDt4cHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaE1hcDTATlwQbMD7AgABWgALYWNjZXNzT3JkZXJ4cQB+AAY/QAAAAAAADHcIAAAAEAAAAAF0ADltZS53dXdlbmJpbi5pdGVtcy5vYXV0aDIuY29uZmlnLnN1cHBvcnQucmVhbG0uVXNlclJlYWxtXzJzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hTZXTYbNdald0qHgIAAHhyABFqYXZhLnV0aWwuSGFzaFNldLpEhZWWuLc0AwAAeHB3DAAAABA/QAAAAAAAAXQAAnNheHgAdwEBcQB+ABh4eHg=',
                                            '127.0.0.1', '2017-09-10 17:53:25', '2017-09-10 18:16:26', '1800000',
                                            'http://127.0.0.1:8082/oauth2/user/api/info',
                                            'http://127.0.0.1:8082/oauth2/menu/api/list',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('41', 'sa', '50d6482f-1f26-4060-978f-af521ec3f5df',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDUwZDY0ODJmLTFmMjYtNDA2MC05NzhmLWFmNTIxZWMzZjVkZnNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5uibDfeHNxAH4AA3cIAAABXm6J7wt4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAN0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AHQvb2F1dGgyL3ByaXZpbGVnZVBhZ2UvYXBpL2xpc3Q/bGltaXQ9MTAmb2Zmc2V0PTAmb3JkZXI9YXNjJnNvcnQ9aWQmZW5hYmxlZD0mbW9kdWxlSWQ9OSZyZXNvdXJjZU5hbWU9Jl89MTUwNTA5MzA3MTQyN3QATW9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5zdXBwb3J0LkRlZmF1bHRTdWJqZWN0Q29udGV4dF9QUklOQ0lQQUxTX1NFU1NJT05fS0VZc3IAMm9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5TaW1wbGVQcmluY2lwYWxDb2xsZWN0aW9uqH9YJcajCEoDAAFMAA9yZWFsbVByaW5jaXBhbHN0AA9MamF2YS91dGlsL01hcDt4cHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaE1hcDTATlwQbMD7AgABWgALYWNjZXNzT3JkZXJ4cQB+AAY/QAAAAAAADHcIAAAAEAAAAAF0ADltZS53dXdlbmJpbi5pdGVtcy5vYXV0aDIuY29uZmlnLnN1cHBvcnQucmVhbG0uVXNlclJlYWxtXzBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hTZXTYbNdald0qHgIAAHhyABFqYXZhLnV0aWwuSGFzaFNldLpEhZWWuLc0AwAAeHB3DAAAABA/QAAAAAAAAXQAAnNheHgAdwEBcQB+ABJ4eHg=',
                                            '127.0.0.1', '2017-09-11 09:24:31', '2017-09-11 09:24:47', '1800000',
                                            'http://127.0.0.1:8082/login',
                                            'http://127.0.0.1:8082/oauth2/privilegePage/api/list',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('42', 'sa', '007862d6-cc2c-40bb-bdfb-67d30f9f4d7e',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDAwNzg2MmQ2LWNjMmMtNDBiYi1iZGZiLTY3ZDMwZjlmNGQ3ZXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5ui/nbeHNxAH4AA3cIAAABXm6ORr94dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAR0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQADS9vYXV0aDIvaW5kZXh0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0ABEvb2F1dGgyL3VuZGVmaW5lZHQATW9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5zdXBwb3J0LkRlZmF1bHRTdWJqZWN0Q29udGV4dF9QUklOQ0lQQUxTX1NFU1NJT05fS0VZc3IAMm9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5TaW1wbGVQcmluY2lwYWxDb2xsZWN0aW9uqH9YJcajCEoDAAFMAA9yZWFsbVByaW5jaXBhbHN0AA9MamF2YS91dGlsL01hcDt4cHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaE1hcDTATlwQbMD7AgABWgALYWNjZXNzT3JkZXJ4cQB+AAY/QAAAAAAADHcIAAAAEAAAAAF0ADltZS53dXdlbmJpbi5pdGVtcy5vYXV0aDIuY29uZmlnLnN1cHBvcnQucmVhbG0uVXNlclJlYWxtXzBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hTZXTYbNdald0qHgIAAHhyABFqYXZhLnV0aWwuSGFzaFNldLpEhZWWuLc0AwAAeHB3DAAAAAI/QAAAAAAAAXQAAnNheHgAdwEBcQB+ABh4eHg=',
                                            '127.0.0.1', '2017-09-11 09:27:01', '2017-09-11 09:29:32', '1800000',
                                            'http://127.0.0.1:8082/oauth2/index',
                                            'http://127.0.0.1:8082/oauth2/undefined',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('43', 'sa', '6bef3e3b-9813-4641-b26f-e4a1acf5c8f2',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDZiZWYzZTNiLTk4MTMtNDY0MS1iMjZmLWU0YTFhY2Y1YzhmMnNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5ujoLheHNxAH4AA3cIAAABXm6OoR94dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAR0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQADS9vYXV0aDIvaW5kZXh0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AA0vb2F1dGgyL2luZGV4dABNb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LnN1cHBvcnQuRGVmYXVsdFN1YmplY3RDb250ZXh0X1BSSU5DSVBBTFNfU0VTU0lPTl9LRVlzcgAyb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LlNpbXBsZVByaW5jaXBhbENvbGxlY3Rpb26of1glxqMISgMAAUwAD3JlYWxtUHJpbmNpcGFsc3QAD0xqYXZhL3V0aWwvTWFwO3hwc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoTWFwNMBOXBBswPsCAAFaAAthY2Nlc3NPcmRlcnhxAH4ABj9AAAAAAAAMdwgAAAAQAAAAAXQAOW1lLnd1d2VuYmluLml0ZW1zLm9hdXRoMi5jb25maWcuc3VwcG9ydC5yZWFsbS5Vc2VyUmVhbG1fM3NyABdqYXZhLnV0aWwuTGlua2VkSGFzaFNldNhs11qV3SoeAgAAeHIAEWphdmEudXRpbC5IYXNoU2V0ukSFlZa4tzQDAAB4cHcMAAAAED9AAAAAAAABdAACc2F4eAB3AQFxAH4AGHh4eA==',
                                            '127.0.0.1', '2017-09-11 09:29:47', '2017-09-11 09:29:55', '1800000',
                                            'http://127.0.0.1:8082/oauth2/index', 'http://127.0.0.1:8082/oauth2/index',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('44', 'sa', '71372539-e458-43ea-adb9-8cd3bfe8343c',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDcxMzcyNTM5LWU0NTgtNDNlYS1hZGI5LThjZDNiZmU4MzQzY3NyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5ukBEzeHNxAH4AA3cIAAABXm6VLj94dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAR0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQADS9vYXV0aDIvaW5kZXh0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AC0vb2F1dGgyL3N5c3RlbU1vZHVsZS9hcGkvZmluZC9tb2R1bGVzL2VuYWJsZWR0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAGP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV81c3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAYeHh4',
                                            '127.0.0.1', '2017-09-11 09:31:29', '2017-09-11 09:37:04', '1800000',
                                            'http://127.0.0.1:8082/oauth2/index',
                                            'http://127.0.0.1:8082/oauth2/systemModule/api/find/modules/enabled',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('45', '127.0.0.1', 'd86d06b8-6fbb-4ca3-8dbb-b17362bfb897',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJGQ4NmQwNmI4LTZmYmItNGNhMy04ZGJiLWIxNzM2MmJmYjg5N3NyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5ul7M8eHNxAH4AA3cIAAABXm6Xs8h4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAJ0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQAFS9vYXV0aDIvdXNlci9hcGkvaW5mb3QAGGJlZm9yZS5sb2dpbi5zdWNjZXNzLnVybHEAfgANeHg=',
                                            '127.0.0.1', '2017-09-11 09:39:49', '2017-09-11 09:39:49', '1800000',
                                            'http://127.0.0.1:8082/oauth2/user/api/info',
                                            'http://127.0.0.1:8082/undefined',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('46', '127.0.0.1', '9581f24a-2401-4903-b275-60a71dae5c64',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDk1ODFmMjRhLTI0MDEtNDkwMy1iMjc1LTYwYTcxZGFlNWM2NHNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5umD2weHEAfgAEdxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAJ0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACUwACnJlcXVlc3RVUklxAH4ACXhwdAADR0VUcHQAFS9vYXV0aDIvdXNlci9hcGkvaW5mb3QAGGJlZm9yZS5sb2dpbi5zdWNjZXNzLnVybHEAfgAMeHg=',
                                            '127.0.0.1', '2017-09-11 09:40:25', '2017-09-11 09:40:25', '1800000',
                                            'http://127.0.0.1:8082/oauth2/user/api/info',
                                            'http://127.0.0.1:8082/oauth2/user/api/info',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('47', 'sa', 'cbfd67ea-5121-4dc2-9ce8-d06eaf641ace',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJGNiZmQ2N2VhLTUxMjEtNGRjMi05Y2U4LWQwNmVhZjY0MWFjZXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5umnPfeHNxAH4AA3cIAAABXm6hBhR4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAR0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQAFS9vYXV0aDIvdXNlci9hcGkvaW5mb3QAUG9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5zdXBwb3J0LkRlZmF1bHRTdWJqZWN0Q29udGV4dF9BVVRIRU5USUNBVEVEX1NFU1NJT05fS0VZc3IAEWphdmEubGFuZy5Cb29sZWFuzSBygNWc+u4CAAFaAAV2YWx1ZXhwAXQAGGJlZm9yZS5sb2dpbi5zdWNjZXNzLnVybHEAfgANdABNb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LnN1cHBvcnQuRGVmYXVsdFN1YmplY3RDb250ZXh0X1BSSU5DSVBBTFNfU0VTU0lPTl9LRVlzcgAyb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LlNpbXBsZVByaW5jaXBhbENvbGxlY3Rpb26of1glxqMISgMAAUwAD3JlYWxtUHJpbmNpcGFsc3QAD0xqYXZhL3V0aWwvTWFwO3hwc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoTWFwNMBOXBBswPsCAAFaAAthY2Nlc3NPcmRlcnhxAH4ABj9AAAAAAAAMdwgAAAAQAAAAAXQAOW1lLnd1d2VuYmluLml0ZW1zLm9hdXRoMi5jb25maWcuc3VwcG9ydC5yZWFsbS5Vc2VyUmVhbG1fNXNyABdqYXZhLnV0aWwuTGlua2VkSGFzaFNldNhs11qV3SoeAgAAeHIAEWphdmEudXRpbC5IYXNoU2V0ukSFlZa4tzQDAAB4cHcMAAAAED9AAAAAAAABdAACc2F4eAB3AQFxAH4AF3h4eA==',
                                            '127.0.0.1', '2017-09-11 09:42:50', '2017-09-11 09:50:00', '1800000',
                                            'http://127.0.0.1:8082/oauth2/user/api/info', 'http://127.0.0.1:8082/',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('48', 'sa', 'a251ef42-c72d-4873-9514-b3c979ca1c29',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJGEyNTFlZjQyLWM3MmQtNDg3My05NTE0LWIzYzk3OWNhMWMyOXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5upfIJeHNxAH4AA3cIAAABXm6zSE94dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAN0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0ABUvb2F1dGgyL21lbnUvYXBpL2xpc3R0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAGP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8xc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgASeHh4',
                                            '127.0.0.1', '2017-09-11 09:55:23', '2017-09-11 10:09:57', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/oauth2/menu/api/list',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('49', 'sa', '5e18e7e4-987a-40fb-91f8-ee4f6a2a898d',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDVlMThlN2U0LTk4N2EtNDBmYi05MWY4LWVlNGY2YTJhODk4ZHNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5us+FxeHNxAH4AA3cIAAABXm608i54dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAN0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AGwvb2F1dGgyL3N5c3RlbVBhcmFtL2FwaS9saXN0P2xpbWl0PTEwJm9mZnNldD0wJm9yZGVyPWFzYyZzb3J0PWlkJm5hbWU9JnZhbHVlPSZzZWxlY3RFbmFibGVkPSZfPTE1MDUwOTU5MDUyMDB0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAGP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8xc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgASeHh4',
                                            '127.0.0.1', '2017-09-11 10:10:36', '2017-09-11 10:11:46', '1800000',
                                            'http://127.0.0.1:8082/login',
                                            'http://127.0.0.1:8082/oauth2/systemParam/api/list',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:55.0) Gecko/20100101 Firefox/55.0');
INSERT INTO `t_oauth_session` VALUES ('50', 'sa', '1e114574-ba5b-4e55-81bd-46bf9e9a71b0',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDFlMTE0NTc0LWJhNWItNGU1NS04MWJkLTQ2YmY5ZTlhNzFiMHNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5utUZneHNxAH4AA3cIAAABXm63aiJ4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAN0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0ABEvb2F1dGgyL2Rhc2hib2FyZHQATW9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5zdXBwb3J0LkRlZmF1bHRTdWJqZWN0Q29udGV4dF9QUklOQ0lQQUxTX1NFU1NJT05fS0VZc3IAMm9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5TaW1wbGVQcmluY2lwYWxDb2xsZWN0aW9uqH9YJcajCEoDAAFMAA9yZWFsbVByaW5jaXBhbHN0AA9MamF2YS91dGlsL01hcDt4cHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaE1hcDTATlwQbMD7AgABWgALYWNjZXNzT3JkZXJ4cQB+AAY/QAAAAAAADHcIAAAAEAAAAAF0ADltZS53dXdlbmJpbi5pdGVtcy5vYXV0aDIuY29uZmlnLnN1cHBvcnQucmVhbG0uVXNlclJlYWxtXzFzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hTZXTYbNdald0qHgIAAHhyABFqYXZhLnV0aWwuSGFzaFNldLpEhZWWuLc0AwAAeHB3DAAAABA/QAAAAAAAAXQAAnNheHgAdwEBcQB+ABJ4eHg=',
                                            '127.0.0.1', '2017-09-11 10:12:07', '2017-09-11 10:14:28', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/oauth2/dashboard',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:55.0) Gecko/20100101 Firefox/55.0');
INSERT INTO `t_oauth_session` VALUES ('51', 'sa', 'dd19cab9-fa65-4247-863c-ea92a53824e7',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJGRkMTljYWI5LWZhNjUtNDI0Ny04NjNjLWVhOTJhNTM4MjRlN3NyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5uuJQdeHEAfgAEdxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAJ0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAFP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8yc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAPeHh4',
                                            '127.0.0.1', '2017-09-11 10:15:44', '2017-09-11 10:15:44', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/login',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('52', 'sa', '32a4bf87-a3b4-46c5-992d-d1ea9e7f9223',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDMyYTRiZjg3LWEzYjQtNDZjNS05OTJkLWQxZWE5ZTdmOTIyM3NyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5uuPLeeHEAfgAEdxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAJ0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAFP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8yc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAPeHh4',
                                            '127.0.0.1', '2017-09-11 10:16:08', '2017-09-11 10:16:08', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/login',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('53', 'sa', '07f1a721-b6ab-4abd-b3d5-e2d57ef38399',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDA3ZjFhNzIxLWI2YWItNGFiZC1iM2Q1LWUyZDU3ZWYzODM5OXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5uuiLxeHEAfgAEdxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAJ0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAFP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8yc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAPeHh4',
                                            '127.0.0.1', '2017-09-11 10:17:26', '2017-09-11 10:17:26', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/login',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('54', 'sa', 'd5b737a4-d5ab-4d0e-b36e-134233b8a184',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJGQ1YjczN2E0LWQ1YWItNGQwZS1iMzZlLTEzNDIzM2I4YTE4NHNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5uvUbteHNxAH4AA3cIAAABXm69iTV4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAN0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AA0vb2F1dGgyL2luZGV4dABNb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LnN1cHBvcnQuRGVmYXVsdFN1YmplY3RDb250ZXh0X1BSSU5DSVBBTFNfU0VTU0lPTl9LRVlzcgAyb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LlNpbXBsZVByaW5jaXBhbENvbGxlY3Rpb26of1glxqMISgMAAUwAD3JlYWxtUHJpbmNpcGFsc3QAD0xqYXZhL3V0aWwvTWFwO3hwc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoTWFwNMBOXBBswPsCAAFaAAthY2Nlc3NPcmRlcnhxAH4ABj9AAAAAAAAMdwgAAAAQAAAAAXQAOW1lLnd1d2VuYmluLml0ZW1zLm9hdXRoMi5jb25maWcuc3VwcG9ydC5yZWFsbS5Vc2VyUmVhbG1fNXNyABdqYXZhLnV0aWwuTGlua2VkSGFzaFNldNhs11qV3SoeAgAAeHIAEWphdmEudXRpbC5IYXNoU2V0ukSFlZa4tzQDAAB4cHcMAAAAED9AAAAAAAABdAACc2F4eAB3AQFxAH4AEnh4eA==',
                                            '127.0.0.1', '2017-09-11 10:20:52', '2017-09-11 10:21:09', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/oauth2/index',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('55', 'sa', '7ded6b20-9f73-456e-918f-224eb84a0dea',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDdkZWQ2YjIwLTlmNzMtNDU2ZS05MThmLTIyNGViODRhMGRlYXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5uvf+heHEAfgAEdxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAJ0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAFP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV81c3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAPeHh4',
                                            '127.0.0.1', '2017-09-11 10:21:39', '2017-09-11 10:21:39', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/login',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('59', 'sa', 'f29e45dd-d44a-4688-bb98-703dc0af1960',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJGYyOWU0NWRkLWQ0NGEtNDY4OC1iYjk4LTcwM2RjMGFmMTk2MHNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5uwEvYeHNxAH4AA3cIAAABXm7ATa54dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAN0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AA0vb2F1dGgyL2luZGV4dABNb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LnN1cHBvcnQuRGVmYXVsdFN1YmplY3RDb250ZXh0X1BSSU5DSVBBTFNfU0VTU0lPTl9LRVlzcgAyb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LlNpbXBsZVByaW5jaXBhbENvbGxlY3Rpb26of1glxqMISgMAAUwAD3JlYWxtUHJpbmNpcGFsc3QAD0xqYXZhL3V0aWwvTWFwO3hwc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoTWFwNMBOXBBswPsCAAFaAAthY2Nlc3NPcmRlcnhxAH4ABj9AAAAAAAAMdwgAAAAQAAAAAXQAOW1lLnd1d2VuYmluLml0ZW1zLm9hdXRoMi5jb25maWcuc3VwcG9ydC5yZWFsbS5Vc2VyUmVhbG1fMHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaFNldNhs11qV3SoeAgAAeHIAEWphdmEudXRpbC5IYXNoU2V0ukSFlZa4tzQDAAB4cHcMAAAAED9AAAAAAAABdAACc2F4eAB3AQFxAH4AEnh4eA==',
                                            '127.0.0.1', '2017-09-11 10:24:10', '2017-09-11 10:24:10', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/oauth2/index',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('60', 'sa', 'aa33478d-c7ca-437a-babd-a1f72ce24d4e',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJGFhMzM0NzhkLWM3Y2EtNDM3YS1iYWJkLWExZjcyY2UyNGQ0ZXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5uwHzEeHNxAH4AA3cIAAABXm7BptZ4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAN0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AA0vb2F1dGgyL2luZGV4dABNb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LnN1cHBvcnQuRGVmYXVsdFN1YmplY3RDb250ZXh0X1BSSU5DSVBBTFNfU0VTU0lPTl9LRVlzcgAyb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LlNpbXBsZVByaW5jaXBhbENvbGxlY3Rpb26of1glxqMISgMAAUwAD3JlYWxtUHJpbmNpcGFsc3QAD0xqYXZhL3V0aWwvTWFwO3hwc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoTWFwNMBOXBBswPsCAAFaAAthY2Nlc3NPcmRlcnhxAH4ABj9AAAAAAAAMdwgAAAAQAAAAAXQAOW1lLnd1d2VuYmluLml0ZW1zLm9hdXRoMi5jb25maWcuc3VwcG9ydC5yZWFsbS5Vc2VyUmVhbG1fMHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaFNldNhs11qV3SoeAgAAeHIAEWphdmEudXRpbC5IYXNoU2V0ukSFlZa4tzQDAAB4cHcMAAAAED9AAAAAAAABdAACc2F4eAB3AQFxAH4AEnh4eA==',
                                            '127.0.0.1', '2017-09-11 10:24:22', '2017-09-11 10:25:39', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/oauth2/index',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('61', 'sa', '335fa5a9-f9dc-47d6-8a97-4cd6caa653f5',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDMzNWZhNWE5LWY5ZGMtNDdkNi04YTk3LTRjZDZjYWE2NTNmNXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5uwc9KeHEAfgAEdxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAJ0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAFP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8wc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAPeHh4',
                                            '127.0.0.1', '2017-09-11 10:25:49', '2017-09-11 10:25:49', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/login',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('62', 'sa', '262a2ded-f73f-49f5-bbcb-f0eb077b1c69',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDI2MmEyZGVkLWY3M2YtNDlmNS1iYmNiLWYwZWIwNzdiMWM2OXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5uwstoeHEAfgAEdxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAJ0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAFP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8wc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAPeHh4',
                                            '127.0.0.1', '2017-09-11 10:26:53', '2017-09-11 10:26:53', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/login',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('63', 'sa', '1b7011fc-3ca1-4d4a-ac77-5e306c89214b',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDFiNzAxMWZjLTNjYTEtNGQ0YS1hYzc3LTVlMzA2Yzg5MjE0YnNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5uw6VJeHNxAH4AA3cIAAABXm7FCxd4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAN0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AC0vb2F1dGgyL3N5c3RlbU1vZHVsZS9hcGkvZmluZC9tb2R1bGVzL2VuYWJsZWR0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAGP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8xc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgASeHh4',
                                            '127.0.0.1', '2017-09-11 10:27:49', '2017-09-11 10:29:21', '1800000',
                                            'http://127.0.0.1:8082/login',
                                            'http://127.0.0.1:8082/oauth2/systemModule/api/find/modules/enabled',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('64', 'sa', '84be4226-887e-4cc0-85d1-c4ff0faba65e',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDg0YmU0MjI2LTg4N2UtNGNjMC04NWQxLWM0ZmYwZmFiYTY1ZXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5uxoDTeHEAfgAEdxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAJ0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAFP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8wc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAPeHh4',
                                            '127.0.0.1', '2017-09-11 10:30:56', '2017-09-11 10:30:56', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/login',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('65', 'sa', '3600d914-8ed1-4430-b152-e4f714fa5372',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDM2MDBkOTE0LThlZDEtNDQzMC1iMTUyLWU0ZjcxNGZhNTM3MnNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5uy35PeHNxAH4AA3cIAAABXm7NhbB4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAN0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AE8vb2F1dGgyL21lbnUvYXBpL2dldE1lbnVMaXN0SW5kZXg/cm9sZUlkPTE1JnN5c3RlbUNvZGU9U1lTX0JBU0UmbWVudU1vZHVsZUlkPTE1dABNb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LnN1cHBvcnQuRGVmYXVsdFN1YmplY3RDb250ZXh0X1BSSU5DSVBBTFNfU0VTU0lPTl9LRVlzcgAyb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LlNpbXBsZVByaW5jaXBhbENvbGxlY3Rpb26of1glxqMISgMAAUwAD3JlYWxtUHJpbmNpcGFsc3QAD0xqYXZhL3V0aWwvTWFwO3hwc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoTWFwNMBOXBBswPsCAAFaAAthY2Nlc3NPcmRlcnhxAH4ABj9AAAAAAAAMdwgAAAAQAAAAAXQAOW1lLnd1d2VuYmluLml0ZW1zLm9hdXRoMi5jb25maWcuc3VwcG9ydC5yZWFsbS5Vc2VyUmVhbG1fMHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaFNldNhs11qV3SoeAgAAeHIAEWphdmEudXRpbC5IYXNoU2V0ukSFlZa4tzQDAAB4cHcMAAAAAj9AAAAAAAABdAACc2F4eAB3AQFxAH4AEnh4eA==',
                                            '127.0.0.1', '2017-09-11 10:36:24', '2017-09-11 10:38:36', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('67', 'sa', '68db7611-b452-49fa-946e-e65adee851f6',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDY4ZGI3NjExLWI0NTItNDlmYS05NDZlLWU2NWFkZWU4NTFmNnNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5u0NFSeHEAfgAEdxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAJ0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAFP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8xc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAPeHh4',
                                            '127.0.0.1', '2017-09-11 10:42:12', '2017-09-11 10:42:12', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/login',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('68', 'sa', '1587130f-1d68-4879-9045-209e52259764',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDE1ODcxMzBmLTFkNjgtNDg3OS05MDQ1LTIwOWU1MjI1OTc2NHNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5u0X9LeHNxAH4AA3cIAAABXm7RgbF4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAN0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AE8vb2F1dGgyL21lbnUvYXBpL2dldE1lbnVMaXN0SW5kZXg/cm9sZUlkPTE1JnN5c3RlbUNvZGU9U1lTX0JBU0UmbWVudU1vZHVsZUlkPTE1dABNb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LnN1cHBvcnQuRGVmYXVsdFN1YmplY3RDb250ZXh0X1BSSU5DSVBBTFNfU0VTU0lPTl9LRVlzcgAyb3JnLmFwYWNoZS5zaGlyby5zdWJqZWN0LlNpbXBsZVByaW5jaXBhbENvbGxlY3Rpb26of1glxqMISgMAAUwAD3JlYWxtUHJpbmNpcGFsc3QAD0xqYXZhL3V0aWwvTWFwO3hwc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoTWFwNMBOXBBswPsCAAFaAAthY2Nlc3NPcmRlcnhxAH4ABj9AAAAAAAAMdwgAAAAQAAAAAXQAOW1lLnd1d2VuYmluLml0ZW1zLm9hdXRoMi5jb25maWcuc3VwcG9ydC5yZWFsbS5Vc2VyUmVhbG1fMXNyABdqYXZhLnV0aWwuTGlua2VkSGFzaFNldNhs11qV3SoeAgAAeHIAEWphdmEudXRpbC5IYXNoU2V0ukSFlZa4tzQDAAB4cHcMAAAAED9AAAAAAAABdAACc2F4eAB3AQFxAH4AEnh4eA==',
                                            '127.0.0.1', '2017-09-11 10:42:57', '2017-09-11 10:42:58', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('69', 'sa', '110208e4-d657-4874-98c0-1299b8ff3bfb',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDExMDIwOGU0LWQ2NTctNDg3NC05OGMwLTEyOTliOGZmM2JmYnNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5u0bt+eHEAfgAEdxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAJ0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAFP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8xc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAPeHh4',
                                            '127.0.0.1', '2017-09-11 10:43:12', '2017-09-11 10:43:12', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/login',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('70', 'sa', '4791b6d9-0c13-4125-b478-cabf2d6ee1b7',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDQ3OTFiNmQ5LTBjMTMtNDEyNS1iNDc4LWNhYmYyZDZlZTFiN3NyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5u06DOeHEAfgAEdxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAJ0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAFP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8wc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAPeHh4',
                                            '127.0.0.1', '2017-09-11 10:45:17', '2017-09-11 10:45:17', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/login',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('72', 'sa', 'ebc3c12f-53f5-4376-aae2-e1e08d353717',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJGViYzNjMTJmLTUzZjUtNDM3Ni1hYWUyLWUxZTA4ZDM1MzcxN3NyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5u1Gx6eHNxAH4AA3cIAAABXm7Ue7l4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAN0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AGAvb2F1dGgyL2xvZy9hcGkvbGlzdD9saW1pdD0xMCZvZmZzZXQ9MCZvcmRlcj1kZXNjJnNvcnQ9bGFzdF9sb2dpbl9kYXRlJnVzZXJuYW1lPSZfPTE1MDUwOTc5NjkwMDh0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAGP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8wc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgASeHh4',
                                            '127.0.0.1', '2017-09-11 10:46:09', '2017-09-11 10:46:13', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/oauth2/log/api/list',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('73', 'sa', '5e2efcb2-946a-4eb4-8fb6-bdddb6b3fb75',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDVlMmVmY2IyLTk0NmEtNGViNC04ZmI2LWJkZGRiNmIzZmI3NXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5u1KYoeHNxAH4AA3cIAAABXm7UwOF4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAN0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AGAvb2F1dGgyL2xvZy9hcGkvbGlzdD9saW1pdD0xMCZvZmZzZXQ9MCZvcmRlcj1kZXNjJnNvcnQ9bGFzdF9sb2dpbl9kYXRlJnVzZXJuYW1lPSZfPTE1MDUwOTc5ODM3ODB0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAGP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8wc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgASeHh4',
                                            '127.0.0.1', '2017-09-11 10:46:24', '2017-09-11 10:46:30', '1800000',
                                            'http://127.0.0.1:8082/login', 'http://127.0.0.1:8082/oauth2/log/api/list',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('76', 'sa', '31a9b3ed-017d-4cfe-b5fb-b7c61a954289',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDMxYTliM2VkLTAxN2QtNGNmZS1iNWZiLWI3YzYxYTk1NDI4OXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5u2Yf/eHNxAH4AA3cIAAABXm7ZtpF4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAR0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQAAS90AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AGAvb2F1dGgyL2xvZy9hcGkvbGlzdD9saW1pdD0xMCZvZmZzZXQ9MCZvcmRlcj1kZXNjJnNvcnQ9bGFzdF9sb2dpbl9kYXRlJnVzZXJuYW1lPSZfPTE1MDUwOTgzMDY3NjN0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAGP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8xc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAYeHh4',
                                            '127.0.0.1', '2017-09-11 10:51:43', '2017-09-11 10:51:55', '1800000',
                                            'http://127.0.0.1:8082/', 'http://127.0.0.1:8082/oauth2/log/api/list',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('77', '127.0.0.1', '4ddc1739-f6e9-4b28-bc12-b697459f948a',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDRkZGMxNzM5LWY2ZTktNGIyOC1iYzEyLWI2OTc0NTlmOTQ4YXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5u2dWAeHNxAH4AA3cIAAABXm7a8w14dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAJ0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQAAS90ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmxxAH4ADXh4',
                                            '127.0.0.1', '2017-09-11 10:52:03', '2017-09-11 10:53:16', '1800000',
                                            'http://127.0.0.1:8082/', 'http://127.0.0.1:8082/login',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('78', '127.0.0.1', '8d9587d4-24ce-48b5-acd0-b6cd35263399',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDhkOTU4N2Q0LTI0Y2UtNDhiNS1hY2QwLWI2Y2QzNTI2MzM5OXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5u238veHNxAH4AA3cIAAABXm7eyG54dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAJ0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQAAS90ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AAYvbG9naW54eA==',
                                            '127.0.0.1', '2017-09-11 10:53:52', '2017-09-11 10:57:28', '1800000',
                                            'http://127.0.0.1:8082/', 'http://127.0.0.1:8082/login',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('90', 'sa', '9a0aa7ae-295f-451c-92c8-2158e6169715',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDlhMGFhN2FlLTI5NWYtNDUxYy05MmM4LTIxNThlNjE2OTcxNXNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV5wubmceHNxAH4AA3cIAAABXnF/Z9N4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAN0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AGAvb2F1dGgyL2xvZy9hcGkvbGlzdD9saW1pdD0xMCZvZmZzZXQ9MCZvcmRlcj1kZXNjJnNvcnQ9bGFzdF9sb2dpbl9kYXRlJnVzZXJuYW1lPSZfPTE1MDUxNDE4MTMzNTh0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAGP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8wc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAAQP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgASeHh4',
                                            '127.0.0.1', '2017-09-11 19:36:13', '2017-09-11 23:12:09', '1800000',
                                            'http://127.0.0.1:8082/login/', 'http://127.0.0.1:8082/oauth2/log/api/list',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('96', '127.0.0.1', 'a62bae92-3a54-4121-a443-3929e7c85fdf',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJGE2MmJhZTkyLTNhNTQtNDEyMS1hNDQzLTM5MjllN2M4NWZkZnNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV50+kF2eHNxAH4AA3cIAAABXnV5Qn54dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAR0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQAAS90AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0ABEvb2F1dGgyL2Rhc2hib2FyZHQATW9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5zdXBwb3J0LkRlZmF1bHRTdWJqZWN0Q29udGV4dF9QUklOQ0lQQUxTX1NFU1NJT05fS0VZc3IAMm9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5TaW1wbGVQcmluY2lwYWxDb2xsZWN0aW9uqH9YJcajCEoDAAFMAA9yZWFsbVByaW5jaXBhbHN0AA9MamF2YS91dGlsL01hcDt4cHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaE1hcDTATlwQbMD7AgABWgALYWNjZXNzT3JkZXJ4cQB+AAY/QAAAAAAADHcIAAAAEAAAAAF0ADltZS53dXdlbmJpbi5pdGVtcy5vYXV0aDIuY29uZmlnLnN1cHBvcnQucmVhbG0uVXNlclJlYWxtXzJzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hTZXTYbNdald0qHgIAAHhyABFqYXZhLnV0aWwuSGFzaFNldLpEhZWWuLc0AwAAeHB3DAAAAAI/QAAAAAAAAXQAAnNheHgAdwEBcQB+ABh4eHg=',
                                            '127.0.0.1', '2017-09-12 15:25:11', '2017-09-12 17:43:55', '1800000',
                                            'http://127.0.0.1:8082/', 'http://127.0.0.1:8082/oauth2/dashboard',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('97', '127.0.0.1', 'cb122095-8287-4475-8c31-be22236e4218',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJGNiMTIyMDk1LTgyODctNDQ3NS04YzMxLWJlMjIyMzZlNDIxOHNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV52xyXmeHNxAH4AA3cIAAABXnbyCtF4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAR0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQAAS90AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0AF0vb2F1dGgyL3ByaXZpbGVnZVBhZ2UvYXBpL2xpc3Q/bGltaXQ9MTAmb2Zmc2V0PTAmb3JkZXI9YXNjJnNvcnQ9aWQmbW9kdWxlSWQ9MSZfPTE1MDUyMzQwNzgwMDV0AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAGP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8wc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAACP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgAYeHh4',
                                            '127.0.0.1', '2017-09-12 23:48:36', '2017-09-13 00:35:28', '1800000',
                                            'http://127.0.0.1:8082/',
                                            'http://127.0.0.1:8082/oauth2/privilegePage/api/list',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('98', '127.0.0.1', '59d5118c-e15e-453a-a97f-da834878dbc4',
                                            'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDU5ZDUxMThjLWUxNWUtNDUzYS1hOTdmLWRhODM0ODc4ZGJjNHNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV528nSgeHNxAH4AA3cIAAABXnb7Yhx4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAR0ABFzaGlyb1NhdmVkUmVxdWVzdHNyACZvcmcuYXBhY2hlLnNoaXJvLndlYi51dGlsLlNhdmVkUmVxdWVzdK/OPK15gsq6AgADTAAGbWV0aG9kdAASTGphdmEvbGFuZy9TdHJpbmc7TAALcXVlcnlTdHJpbmdxAH4ACkwACnJlcXVlc3RVUklxAH4ACnhwdAADR0VUcHQAAS90AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0ABEvb2F1dGgyL2Rhc2hib2FyZHQATW9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5zdXBwb3J0LkRlZmF1bHRTdWJqZWN0Q29udGV4dF9QUklOQ0lQQUxTX1NFU1NJT05fS0VZc3IAMm9yZy5hcGFjaGUuc2hpcm8uc3ViamVjdC5TaW1wbGVQcmluY2lwYWxDb2xsZWN0aW9uqH9YJcajCEoDAAFMAA9yZWFsbVByaW5jaXBhbHN0AA9MamF2YS91dGlsL01hcDt4cHNyABdqYXZhLnV0aWwuTGlua2VkSGFzaE1hcDTATlwQbMD7AgABWgALYWNjZXNzT3JkZXJ4cQB+AAY/QAAAAAAADHcIAAAAEAAAAAF0ADltZS53dXdlbmJpbi5pdGVtcy5vYXV0aDIuY29uZmlnLnN1cHBvcnQucmVhbG0uVXNlclJlYWxtXzBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hTZXTYbNdald0qHgIAAHhyABFqYXZhLnV0aWwuSGFzaFNldLpEhZWWuLc0AwAAeHB3DAAAAAI/QAAAAAAAAXQAAnNheHgAdwEBcQB+ABh4eHg=',
                                            '127.0.0.1', '2017-09-13 00:35:55', '2017-09-13 00:45:40', '1800000',
                                            'http://127.0.0.1:8082/', 'http://127.0.0.1:8082/oauth2/dashboard',
                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36');
INSERT INTO `t_oauth_session` VALUES ('101', '127.0.0.1', '1d233cee-3875-4f4b-8c41-dd92d4593f2b',
                                             'rO0ABXNyACpvcmcuYXBhY2hlLnNoaXJvLnNlc3Npb24ubWd0LlNpbXBsZVNlc3Npb26dHKG41YxibgMAAHhwdwIA23QAJDFkMjMzY2VlLTM4NzUtNGY0Yi04YzQxLWRkOTJkNDU5M2YyYnNyAA5qYXZhLnV0aWwuRGF0ZWhqgQFLWXQZAwAAeHB3CAAAAV553kDGeHNxAH4AA3cIAAABXnopzXR4dxMAAAAAABt3QAAJMTI3LjAuMC4xc3IAEWphdmEudXRpbC5IYXNoTWFwBQfawcMWYNEDAAJGAApsb2FkRmFjdG9ySQAJdGhyZXNob2xkeHA/QAAAAAAADHcIAAAAEAAAAAN0AFBvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfQVVUSEVOVElDQVRFRF9TRVNTSU9OX0tFWXNyABFqYXZhLmxhbmcuQm9vbGVhbs0gcoDVnPruAgABWgAFdmFsdWV4cAF0ABhiZWZvcmUubG9naW4uc3VjY2Vzcy51cmx0ABUvb2F1dGgyL3VzZXIvYXBpL2luZm90AE1vcmcuYXBhY2hlLnNoaXJvLnN1YmplY3Quc3VwcG9ydC5EZWZhdWx0U3ViamVjdENvbnRleHRfUFJJTkNJUEFMU19TRVNTSU9OX0tFWXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBzcgAXamF2YS51dGlsLkxpbmtlZEhhc2hNYXA0wE5cEGzA+wIAAVoAC2FjY2Vzc09yZGVyeHEAfgAGP0AAAAAAAAx3CAAAABAAAAABdAA5bWUud3V3ZW5iaW4uaXRlbXMub2F1dGgyLmNvbmZpZy5zdXBwb3J0LnJlYWxtLlVzZXJSZWFsbV8wc3IAF2phdmEudXRpbC5MaW5rZWRIYXNoU2V02GzXWpXdKh4CAAB4cgARamF2YS51dGlsLkhhc2hTZXS6RIWVlri3NAMAAHhwdwwAAAACP0AAAAAAAAF0AAJzYXh4AHcBAXEAfgASeHh4',
                                             '127.0.0.1', '2017-09-13 14:12:42', '2017-09-13 15:35:14', '1800000',
                                             'http://127.0.0.1:8082/login/',
                                             'http://127.0.0.1:8082/oauth2/user/api/info',
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
  AUTO_INCREMENT = 7
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_system_module
-- ----------------------------
INSERT INTO `t_oauth_system_module` VALUES
  ('1', '测试系统平台A', 'SYS_BASE_PLATFORM', '1', '2017-08-14 14:47:52', '1', '2017-08-08 20:02:21', '1', '0',
   '管理系统的权限、菜单、角色、用户、系统参数等功能');
INSERT INTO `t_oauth_system_module` VALUES
  ('2', '测试系统平台B', 'SYS_WECHAT_PLATFORM', '1', '2017-08-14 14:48:01', '1', '2017-08-08 20:22:32', '1', '0', '微信管理平台');
INSERT INTO `t_oauth_system_module`
VALUES ('3', '测试www系统平台', 'SYS_WWW', '0', '2017-09-06 15:31:18', '1', '2017-09-06 15:30:27', '1', '0', '这是用来测试的一条数据');
INSERT INTO `t_oauth_system_module`
VALUES ('4', '查封人生态度', 'SYS_QSDF', '0', '2017-09-06 22:32:56', '1', '2017-09-06 22:32:56', '1', '2', 'fdgfg来来来');
INSERT INTO `t_oauth_system_module`
VALUES ('6', '基础管理平台', 'SYS_BASE', '1', '2017-09-07 16:19:06', '1', '2017-09-07 16:18:42', '1', '0', '基础管理平台');

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
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of t_oauth_system_param
-- ----------------------------
INSERT INTO `t_oauth_system_param` VALUES
  ('1', 'open_security_control', '0', '1', '2017-08-08 22:44:38', '1', '2017-08-08 22:44:26', '1', '0',
   '是否打开系统权限控制，1打开，0不打开');
INSERT INTO `t_oauth_system_param`
VALUES ('2', 'dll_pp_1', '153213', '0', '2017-09-07 13:04:06', '1', '2017-09-07 13:03:56', '1', '0', '啊啊啊');

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
  ('1', 'sa', 'c0c382617df2d30b3cef427f1f11c92b', 'f7fddb4bf0fdceb77e01ef1bbc6fd826', '超级管理员', '1', '15',
        '765934806@qq.com', '765934806', NULL, '181xxxxxxxx', '1', '2017-08-08 20:05:42', '1', '2017-08-08 20:05:42',
   '1', '0', '伍文彬wwb');
INSERT INTO `t_oauth_user` VALUES
  ('2', 'wuwenbin', 'e7290ba15c77df874d9b75a1d40d4503', 'd8dc30581c63b193478121c5bee5558f', '伍文彬', '3', '1',
        '765934806@qq.com', NULL, NULL, '181xxxxxxxx', '1', '2017-09-05 13:36:02', '5', '2017-08-08 20:05:42', '1', '0',
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
  AUTO_INCREMENT = 440
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
INSERT INTO `t_oauth_user_login_log`
VALUES ('147', '1', '2017-08-18 17:20:32', '127.0.0.1', '1', '2017-08-18 17:20:32', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('148', '1', '2017-08-18 17:25:15', '127.0.0.1', '1', '2017-08-18 17:25:15', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('149', '1', '2017-08-18 18:49:36', '127.0.0.1', '1', '2017-08-18 18:49:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('150', '1', '2017-08-19 10:23:18', '127.0.0.1', '1', '2017-08-19 10:23:18', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('151', '1', '2017-08-19 10:33:25', '127.0.0.1', '1', '2017-08-19 10:33:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('152', '1', '2017-08-19 11:14:00', '127.0.0.1', '1', '2017-08-19 11:14:00', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('153', '1', '2017-08-19 11:15:08', '127.0.0.1', '1', '2017-08-19 11:15:08', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('154', '1', '2017-08-19 11:47:12', '127.0.0.1', '1', '2017-08-19 11:47:12', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('155', '1', '2017-08-19 11:50:43', '127.0.0.1', '1', '2017-08-19 11:50:43', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('156', '1', '2017-08-19 11:52:19', '127.0.0.1', '1', '2017-08-19 11:52:19', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('157', '1', '2017-08-19 12:09:36', '127.0.0.1', '1', '2017-08-19 12:09:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('158', '1', '2017-08-19 12:32:02', '127.0.0.1', '1', '2017-08-19 12:32:02', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('159', '1', '2017-08-19 17:45:57', '127.0.0.1', '1', '2017-08-19 17:45:57', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('160', '1', '2017-08-19 18:43:37', '127.0.0.1', '1', '2017-08-19 18:43:37', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('161', '1', '2017-08-21 10:38:09', '127.0.0.1', '1', '2017-08-21 10:38:09', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('162', '1', '2017-08-21 10:53:03', '127.0.0.1', '1', '2017-08-21 10:53:03', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('163', '1', '2017-08-21 15:14:41', '127.0.0.1', '1', '2017-08-21 15:14:41', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('164', '1', '2017-08-21 15:18:00', '127.0.0.1', '1', '2017-08-21 15:18:00', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('165', '1', '2017-08-21 15:23:17', '127.0.0.1', '1', '2017-08-21 15:23:17', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('166', '1', '2017-08-21 15:23:47', '127.0.0.1', '1', '2017-08-21 15:23:47', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('167', '1', '2017-08-21 15:41:25', '127.0.0.1', '1', '2017-08-21 15:41:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('168', '1', '2017-08-21 16:23:20', '127.0.0.1', '1', '2017-08-21 16:23:20', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('169', '1', '2017-08-21 16:45:50', '127.0.0.1', '1', '2017-08-21 16:45:50', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('170', '1', '2017-08-21 17:19:04', '127.0.0.1', '1', '2017-08-21 17:19:04', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('171', '1', '2017-08-21 17:26:09', '127.0.0.1', '1', '2017-08-21 17:26:09', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('172', '1', '2017-08-21 19:21:24', '127.0.0.1', '1', '2017-08-21 19:21:24', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('173', '1', '2017-08-21 22:13:36', '127.0.0.1', '1', '2017-08-21 22:13:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('174', '1', '2017-08-22 10:04:17', '127.0.0.1', '1', '2017-08-22 10:04:17', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('175', '1', '2017-08-22 10:39:57', '127.0.0.1', '1', '2017-08-22 10:39:57', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('176', '1', '2017-08-22 10:43:49', '127.0.0.1', '1', '2017-08-22 10:43:49', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('177', '1', '2017-08-22 10:51:33', '127.0.0.1', '1', '2017-08-22 10:51:33', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('178', '1', '2017-08-22 10:54:47', '127.0.0.1', '1', '2017-08-22 10:54:47', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('179', '1', '2017-08-22 10:57:27', '127.0.0.1', '1', '2017-08-22 10:57:27', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('180', '1', '2017-08-22 11:23:00', '127.0.0.1', '1', '2017-08-22 11:23:00', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('181', '1', '2017-08-22 13:37:25', '127.0.0.1', '1', '2017-08-22 13:37:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('182', '1', '2017-08-22 13:43:58', '127.0.0.1', '1', '2017-08-22 13:43:58', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('183', '1', '2017-08-22 14:20:56', '127.0.0.1', '1', '2017-08-22 14:20:56', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('184', '1', '2017-08-22 15:03:48', '127.0.0.1', '1', '2017-08-22 15:03:48', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('185', '1', '2017-08-22 15:07:08', '127.0.0.1', '1', '2017-08-22 15:07:08', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('186', '1', '2017-08-22 15:08:55', '127.0.0.1', '1', '2017-08-22 15:08:55', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('187', '1', '2017-08-22 16:35:38', '127.0.0.1', '1', '2017-08-22 16:35:38', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('188', '1', '2017-08-22 17:35:05', '127.0.0.1', '1', '2017-08-22 17:35:05', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('189', '1', '2017-08-22 19:08:04', '127.0.0.1', '1', '2017-08-22 19:08:04', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('190', '1', '2017-08-22 20:31:34', '127.0.0.1', '1', '2017-08-22 20:31:34', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('191', '1', '2017-08-23 10:41:50', '127.0.0.1', '1', '2017-08-23 10:41:50', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('192', '1', '2017-08-23 11:19:38', '127.0.0.1', '1', '2017-08-23 11:19:38', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('193', '1', '2017-08-23 12:47:19', '127.0.0.1', '1', '2017-08-23 12:47:19', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('194', '1', '2017-08-23 12:53:47', '127.0.0.1', '1', '2017-08-23 12:53:47', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('195', '1', '2017-08-23 13:01:16', '127.0.0.1', '1', '2017-08-23 13:01:16', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('196', '1', '2017-08-23 13:09:47', '127.0.0.1', '1', '2017-08-23 13:09:47', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('197', '1', '2017-08-23 13:11:23', '127.0.0.1', '1', '2017-08-23 13:11:23', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('198', '1', '2017-08-23 13:12:26', '127.0.0.1', '1', '2017-08-23 13:12:26', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('199', '1', '2017-08-23 13:16:59', '127.0.0.1', '1', '2017-08-23 13:16:59', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('200', '1', '2017-08-23 13:29:38', '127.0.0.1', '1', '2017-08-23 13:29:38', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('201', '1', '2017-08-23 13:33:13', '127.0.0.1', '1', '2017-08-23 13:33:13', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('202', '1', '2017-08-23 13:35:36', '127.0.0.1', '1', '2017-08-23 13:35:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('203', '1', '2017-08-23 13:39:37', '127.0.0.1', '1', '2017-08-23 13:39:37', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('204', '1', '2017-08-23 13:40:36', '127.0.0.1', '1', '2017-08-23 13:40:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('205', '1', '2017-08-23 14:46:05', '127.0.0.1', '1', '2017-08-23 14:46:05', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('206', '1', '2017-08-23 14:50:28', '127.0.0.1', '1', '2017-08-23 14:50:28', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('207', '1', '2017-08-23 15:23:36', '127.0.0.1', '1', '2017-08-23 15:23:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('208', '1', '2017-08-23 16:34:44', '127.0.0.1', '1', '2017-08-23 16:34:44', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('209', '1', '2017-08-23 16:53:26', '127.0.0.1', '1', '2017-08-23 16:53:26', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('210', '1', '2017-08-23 19:41:25', '127.0.0.1', '1', '2017-08-23 19:41:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('211', '1', '2017-08-24 10:20:41', '127.0.0.1', '1', '2017-08-24 10:20:41', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('212', '1', '2017-08-24 10:38:46', '127.0.0.1', '1', '2017-08-24 10:38:46', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('213', '1', '2017-08-24 11:38:35', '127.0.0.1', '1', '2017-08-24 11:38:35', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('214', '1', '2017-08-24 12:18:14', '127.0.0.1', '1', '2017-08-24 12:18:14', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('215', '1', '2017-08-24 12:19:25', '127.0.0.1', '1', '2017-08-24 12:19:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('216', '1', '2017-08-24 12:23:25', '127.0.0.1', '1', '2017-08-24 12:23:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('217', '1', '2017-08-24 12:44:12', '127.0.0.1', '1', '2017-08-24 12:44:12', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('218', '1', '2017-08-24 12:45:41', '127.0.0.1', '1', '2017-08-24 12:45:41', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('219', '1', '2017-08-24 12:48:54', '127.0.0.1', '1', '2017-08-24 12:48:54', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('220', '1', '2017-08-24 12:49:55', '127.0.0.1', '1', '2017-08-24 12:49:55', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('221', '1', '2017-08-24 12:50:25', '127.0.0.1', '1', '2017-08-24 12:50:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('222', '1', '2017-08-24 13:19:37', '127.0.0.1', '1', '2017-08-24 13:19:37', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('223', '1', '2017-08-24 13:20:37', '127.0.0.1', '1', '2017-08-24 13:20:37', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('224', '1', '2017-08-24 13:25:10', '127.0.0.1', '1', '2017-08-24 13:25:10', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('225', '1', '2017-08-24 13:47:32', '127.0.0.1', '1', '2017-08-24 13:47:32', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('226', '1', '2017-08-24 17:00:26', '127.0.0.1', '1', '2017-08-24 17:00:26', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('227', '1', '2017-08-24 20:26:43', '127.0.0.1', '1', '2017-08-24 20:26:43', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('228', '1', '2017-08-25 10:53:07', '127.0.0.1', '1', '2017-08-25 10:53:07', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('229', '1', '2017-08-25 11:07:40', '127.0.0.1', '1', '2017-08-25 11:07:40', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('230', '1', '2017-08-25 11:13:16', '127.0.0.1', '1', '2017-08-25 11:13:16', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('231', '1', '2017-08-25 12:51:27', '127.0.0.1', '1', '2017-08-25 12:51:27', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('232', '1', '2017-08-25 13:54:56', '127.0.0.1', '1', '2017-08-25 13:54:56', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('233', '1', '2017-08-25 15:05:21', '127.0.0.1', '1', '2017-08-25 15:05:21', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('234', '1', '2017-08-25 17:09:53', '127.0.0.1', '1', '2017-08-25 17:09:53', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('235', '1', '2017-08-25 18:15:01', '127.0.0.1', '1', '2017-08-25 18:15:01', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('236', '1', '2017-08-26 11:32:34', '127.0.0.1', '1', '2017-08-26 11:32:34', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('237', '1', '2017-08-26 13:30:36', '127.0.0.1', '1', '2017-08-26 13:30:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('238', '1', '2017-08-26 13:34:41', '127.0.0.1', '1', '2017-08-26 13:34:41', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('239', '1', '2017-08-27 10:24:12', '127.0.0.1', '1', '2017-08-27 10:24:12', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('240', '1', '2017-08-27 11:06:38', '127.0.0.1', '1', '2017-08-27 11:06:38', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('241', '1', '2017-08-27 11:09:54', '127.0.0.1', '1', '2017-08-27 11:09:54', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('242', '1', '2017-08-27 11:12:56', '127.0.0.1', '1', '2017-08-27 11:12:56', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('243', '1', '2017-08-27 11:19:45', '127.0.0.1', '1', '2017-08-27 11:19:45', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('244', '1', '2017-08-27 11:37:41', '127.0.0.1', '1', '2017-08-27 11:37:41', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('245', '1', '2017-08-27 11:51:46', '127.0.0.1', '1', '2017-08-27 11:51:46', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('246', '1', '2017-08-27 12:41:06', '127.0.0.1', '1', '2017-08-27 12:41:06', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('247', '1', '2017-08-27 16:59:47', '127.0.0.1', '1', '2017-08-27 16:59:47', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('248', '1', '2017-08-27 19:04:27', '127.0.0.1', '1', '2017-08-27 19:04:27', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('249', '1', '2017-08-27 19:04:46', '127.0.0.1', '1', '2017-08-27 19:04:46', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('250', '1', '2017-08-27 19:10:23', '127.0.0.1', '1', '2017-08-27 19:10:23', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('251', '1', '2017-08-27 19:10:45', '127.0.0.1', '1', '2017-08-27 19:10:45', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('252', '1', '2017-08-27 20:43:47', '127.0.0.1', '1', '2017-08-27 20:43:47', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('253', '1', '2017-08-27 22:05:00', '127.0.0.1', '1', '2017-08-27 22:05:00', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('254', '1', '2017-08-27 23:25:25', '127.0.0.1', '1', '2017-08-27 23:25:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('255', '1', '2017-08-28 10:09:24', '127.0.0.1', '1', '2017-08-28 10:09:24', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('256', '1', '2017-08-28 10:23:38', '0:0:0:0:0:0:0:1', '1', '2017-08-28 10:23:38', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('257', '1', '2017-08-28 11:42:44', '127.0.0.1', '1', '2017-08-28 11:42:44', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('258', '1', '2017-08-28 11:44:36', '127.0.0.1', '1', '2017-08-28 11:44:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('259', '1', '2017-08-28 12:42:54', '127.0.0.1', '1', '2017-08-28 12:42:54', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('260', '1', '2017-08-28 12:46:14', '127.0.0.1', '1', '2017-08-28 12:46:14', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('261', '1', '2017-08-28 12:52:41', '127.0.0.1', '1', '2017-08-28 12:52:41', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('262', '1', '2017-08-28 12:59:14', '127.0.0.1', '1', '2017-08-28 12:59:14', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('263', '1', '2017-08-28 13:53:19', '127.0.0.1', '1', '2017-08-28 13:53:19', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('264', '1', '2017-08-28 14:14:19', '127.0.0.1', '1', '2017-08-28 14:14:19', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('265', '1', '2017-08-28 14:29:36', '127.0.0.1', '1', '2017-08-28 14:29:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('266', '1', '2017-08-28 14:58:04', '127.0.0.1', '1', '2017-08-28 14:58:04', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('267', '1', '2017-08-28 15:04:53', '127.0.0.1', '1', '2017-08-28 15:04:53', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('268', '1', '2017-08-28 15:07:35', '127.0.0.1', '1', '2017-08-28 15:07:35', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('269', '1', '2017-08-28 15:16:18', '127.0.0.1', '1', '2017-08-28 15:16:18', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('270', '1', '2017-08-28 15:17:19', '127.0.0.1', '1', '2017-08-28 15:17:19', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('271', '1', '2017-08-28 15:22:30', '127.0.0.1', '1', '2017-08-28 15:22:30', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('272', '1', '2017-08-28 15:23:51', '127.0.0.1', '1', '2017-08-28 15:23:51', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('273', '1', '2017-08-28 15:27:25', '127.0.0.1', '1', '2017-08-28 15:27:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('274', '1', '2017-08-28 16:01:54', '127.0.0.1', '1', '2017-08-28 16:01:54', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('275', '1', '2017-08-28 16:05:31', '127.0.0.1', '1', '2017-08-28 16:05:31', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('276', '1', '2017-08-28 16:07:39', '127.0.0.1', '1', '2017-08-28 16:07:39', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('277', '1', '2017-08-28 16:08:13', '127.0.0.1', '1', '2017-08-28 16:08:13', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('278', '1', '2017-08-28 16:10:01', '127.0.0.1', '1', '2017-08-28 16:10:01', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('279', '1', '2017-08-28 16:23:55', '127.0.0.1', '1', '2017-08-28 16:23:55', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('280', '1', '2017-08-28 16:29:16', '127.0.0.1', '1', '2017-08-28 16:29:16', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('281', '1', '2017-08-28 17:03:26', '127.0.0.1', '1', '2017-08-28 17:03:26', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('282', '1', '2017-08-28 17:05:15', '127.0.0.1', '1', '2017-08-28 17:05:15', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('283', '1', '2017-08-28 17:12:44', '127.0.0.1', '1', '2017-08-28 17:12:44', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('284', '1', '2017-08-28 17:16:51', '127.0.0.1', '1', '2017-08-28 17:16:51', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('285', '1', '2017-08-28 17:27:16', '127.0.0.1', '1', '2017-08-28 17:27:16', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('286', '1', '2017-08-28 17:54:18', '127.0.0.1', '1', '2017-08-28 17:54:18', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('287', '1', '2017-08-28 18:01:15', '127.0.0.1', '1', '2017-08-28 18:01:15', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('288', '1', '2017-08-31 13:33:55', '127.0.0.1', '1', '2017-08-31 13:33:55', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('289', '1', '2017-08-31 13:39:16', '127.0.0.1', '1', '2017-08-31 13:39:16', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('290', '1', '2017-08-31 14:04:27', '127.0.0.1', '1', '2017-08-31 14:04:27', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('291', '1', '2017-08-31 14:33:29', '127.0.0.1', '1', '2017-08-31 14:33:29', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('292', '1', '2017-08-31 14:35:12', '127.0.0.1', '1', '2017-08-31 14:35:12', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('293', '1', '2017-08-31 14:44:57', '127.0.0.1', '1', '2017-08-31 14:44:57', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('294', '1', '2017-08-31 15:34:51', '127.0.0.1', '1', '2017-08-31 15:34:51', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('295', '1', '2017-09-01 11:47:45', '127.0.0.1', '1', '2017-09-01 11:47:45', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('296', '1', '2017-09-01 12:34:32', '127.0.0.1', '1', '2017-09-01 12:34:32', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('297', '1', '2017-09-01 13:33:04', '127.0.0.1', '1', '2017-09-01 13:33:04', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('298', '1', '2017-09-01 16:26:00', '127.0.0.1', '1', '2017-09-01 16:26:00', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('299', '1', '2017-09-01 17:34:23', '127.0.0.1', '1', '2017-09-01 17:34:23', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('300', '1', '2017-09-01 18:55:43', '127.0.0.1', '1', '2017-09-01 18:55:43', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('301', '1', '2017-09-02 10:44:12', '127.0.0.1', '1', '2017-09-02 10:44:12', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('302', '1', '2017-09-02 11:20:25', '127.0.0.1', '1', '2017-09-02 11:20:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('303', '1', '2017-09-02 12:33:01', '127.0.0.1', '1', '2017-09-02 12:33:01', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('304', '1', '2017-09-03 11:52:03', '127.0.0.1', '1', '2017-09-03 11:52:03', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('305', '1', '2017-09-03 11:54:49', '127.0.0.1', '1', '2017-09-03 11:54:49', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('306', '1', '2017-09-03 12:21:31', '127.0.0.1', '1', '2017-09-03 12:21:31', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('307', '1', '2017-09-03 13:35:13', '127.0.0.1', '1', '2017-09-03 13:35:13', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('308', '1', '2017-09-03 14:28:30', '127.0.0.1', '1', '2017-09-03 14:28:30', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('309', '1', '2017-09-03 16:30:00', '127.0.0.1', '1', '2017-09-03 16:30:00', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('310', '1', '2017-09-03 17:15:48', '127.0.0.1', '1', '2017-09-03 17:15:48', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('311', '1', '2017-09-03 19:19:16', '127.0.0.1', '1', '2017-09-03 19:19:16', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('312', '1', '2017-09-03 20:57:40', '127.0.0.1', '1', '2017-09-03 20:57:40', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('313', '1', '2017-09-04 10:42:48', '127.0.0.1', '1', '2017-09-04 10:42:48', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('314', '1', '2017-09-04 11:37:24', '127.0.0.1', '1', '2017-09-04 11:37:24', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('315', '1', '2017-09-05 11:34:47', '127.0.0.1', '1', '2017-09-05 11:34:47', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('316', '1', '2017-09-05 11:58:52', '127.0.0.1', '1', '2017-09-05 11:58:52', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('317', '1', '2017-09-05 13:03:15', '127.0.0.1', '1', '2017-09-05 13:03:15', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('318', '1', '2017-09-05 13:31:36', '192.168.31.145', '1', '2017-09-05 13:31:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('319', '1', '2017-09-05 13:32:54', '192.168.31.145', '1', '2017-09-05 13:32:54', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('320', '5', '2017-09-05 13:35:40', '192.168.31.145', '1', '2017-09-05 13:35:40', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('321', '2', '2017-09-05 13:36:53', '192.168.31.145', '1', '2017-09-05 13:36:53', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('322', '1', '2017-09-05 13:49:05', '127.0.0.1', '1', '2017-09-05 13:49:05', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('323', '1', '2017-09-06 14:56:09', '127.0.0.1', '1', '2017-09-06 14:56:09', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('324', '1', '2017-09-06 15:27:11', '127.0.0.1', '1', '2017-09-06 15:27:11', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('325', '1', '2017-09-06 15:28:11', '127.0.0.1', '1', '2017-09-06 15:28:11', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('326', '1', '2017-09-06 17:30:38', '127.0.0.1', '1', '2017-09-06 17:30:38', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('327', '1', '2017-09-06 22:31:20', '127.0.0.1', '1', '2017-09-06 22:31:20', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('328', '1', '2017-09-06 23:53:39', '127.0.0.1', '1', '2017-09-06 23:53:39', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('329', '1', '2017-09-07 09:22:57', '127.0.0.1', '1', '2017-09-07 09:22:57', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('330', '1', '2017-09-07 10:30:45', '127.0.0.1', '1', '2017-09-07 10:30:45', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('331', '1', '2017-09-07 11:40:18', '127.0.0.1', '1', '2017-09-07 11:40:18', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('332', '1', '2017-09-07 12:23:34', '127.0.0.1', '1', '2017-09-07 12:23:34', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('333', '1', '2017-09-07 13:01:35', '127.0.0.1', '1', '2017-09-07 13:01:35', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('334', '1', '2017-09-07 14:58:25', '127.0.0.1', '1', '2017-09-07 14:58:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('335', '1', '2017-09-07 15:28:57', '127.0.0.1', '1', '2017-09-07 15:28:57', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('336', '1', '2017-09-07 19:09:47', '127.0.0.1', '1', '2017-09-07 19:09:47', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('337', '1', '2017-09-07 20:09:34', '127.0.0.1', '1', '2017-09-07 20:09:34', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('338', '1', '2017-09-07 22:21:35', '127.0.0.1', '1', '2017-09-07 22:21:35', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('339', '1', '2017-09-07 22:28:08', '127.0.0.1', '1', '2017-09-07 22:28:08', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('340', '1', '2017-09-07 23:28:30', '127.0.0.1', '1', '2017-09-07 23:28:30', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('341', '1', '2017-09-08 11:18:22', '127.0.0.1', '1', '2017-09-08 11:18:22', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('342', '1', '2017-09-08 11:32:39', '127.0.0.1', '1', '2017-09-08 11:32:39', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('343', '1', '2017-09-08 13:02:32', '127.0.0.1', '1', '2017-09-08 13:02:32', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('344', '1', '2017-09-08 13:34:28', '127.0.0.1', '1', '2017-09-08 13:34:28', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('345', '1', '2017-09-08 14:18:08', '127.0.0.1', '1', '2017-09-08 14:18:08', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('346', '1', '2017-09-08 15:06:30', '127.0.0.1', '1', '2017-09-08 15:06:30', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('347', '1', '2017-09-08 15:07:35', '127.0.0.1', '1', '2017-09-08 15:07:35', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('348', '1', '2017-09-08 15:10:10', '127.0.0.1', '1', '2017-09-08 15:10:10', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('349', '1', '2017-09-08 16:03:50', '127.0.0.1', '1', '2017-09-08 16:03:50', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('350', '1', '2017-09-08 16:05:20', '127.0.0.1', '1', '2017-09-08 16:05:20', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('351', '1', '2017-09-08 16:11:35', '127.0.0.1', '1', '2017-09-08 16:11:35', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('352', '1', '2017-09-08 16:20:41', '127.0.0.1', '1', '2017-09-08 16:20:41', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('353', '1', '2017-09-08 17:17:29', '127.0.0.1', '1', '2017-09-08 17:17:29', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('354', '1', '2017-09-08 18:00:52', '127.0.0.1', '1', '2017-09-08 18:00:52', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('355', '1', '2017-09-08 21:25:14', '127.0.0.1', '1', '2017-09-08 21:25:14', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('356', '1', '2017-09-08 23:09:02', '127.0.0.1', '1', '2017-09-08 23:09:02', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('357', '1', '2017-09-08 23:17:48', '127.0.0.1', '1', '2017-09-08 23:17:48', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('358', '1', '2017-09-08 23:18:18', '127.0.0.1', '1', '2017-09-08 23:18:18', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('359', '1', '2017-09-09 09:03:03', '127.0.0.1', '1', '2017-09-09 09:03:03', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('360', '1', '2017-09-09 09:14:46', '127.0.0.1', '1', '2017-09-09 09:14:46', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('361', '1', '2017-09-09 12:11:02', '127.0.0.1', '1', '2017-09-09 12:11:02', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('362', '1', '2017-09-09 12:32:34', '127.0.0.1', '1', '2017-09-09 12:32:34', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('363', '1', '2017-09-09 12:36:21', '127.0.0.1', '1', '2017-09-09 12:36:21', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('364', '1', '2017-09-09 14:49:28', '127.0.0.1', '1', '2017-09-09 14:49:28', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('365', '1', '2017-09-09 15:27:29', '127.0.0.1', '1', '2017-09-09 15:27:29', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('366', '1', '2017-09-09 16:23:12', '127.0.0.1', '1', '2017-09-09 16:23:12', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('367', '1', '2017-09-09 18:26:25', '127.0.0.1', '1', '2017-09-09 18:26:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('368', '1', '2017-09-09 20:16:49', '127.0.0.1', '1', '2017-09-09 20:16:49', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('369', '1', '2017-09-09 20:53:48', '127.0.0.1', '1', '2017-09-09 20:53:48', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('370', '1', '2017-09-10 09:36:11', '127.0.0.1', '1', '2017-09-10 09:36:11', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('371', '1', '2017-09-10 11:01:58', '127.0.0.1', '1', '2017-09-10 11:01:58', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('372', '1', '2017-09-10 11:12:39', '127.0.0.1', '1', '2017-09-10 11:12:39', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('373', '1', '2017-09-10 11:51:29', '127.0.0.1', '1', '2017-09-10 11:51:29', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('374', '1', '2017-09-10 16:19:30', '127.0.0.1', '1', '2017-09-10 16:19:30', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('375', '1', '2017-09-10 16:20:31', '127.0.0.1', '1', '2017-09-10 16:20:31', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('376', '1', '2017-09-10 16:23:49', '127.0.0.1', '1', '2017-09-10 16:23:49', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('377', '1', '2017-09-10 16:54:12', '127.0.0.1', '1', '2017-09-10 16:54:12', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('378', '1', '2017-09-10 17:21:09', '127.0.0.1', '1', '2017-09-10 17:21:09', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('379', '1', '2017-09-10 17:23:08', '127.0.0.1', '1', '2017-09-10 17:23:08', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('380', '1', '2017-09-10 17:49:36', '127.0.0.1', '1', '2017-09-10 17:49:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('381', '1', '2017-09-10 17:53:29', '127.0.0.1', '1', '2017-09-10 17:53:29', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('382', '1', '2017-09-11 09:22:10', '127.0.0.1', '1', '2017-09-11 09:22:10', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('383', '1', '2017-09-11 09:24:31', '127.0.0.1', '1', '2017-09-11 09:24:31', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('384', '1', '2017-09-11 09:27:06', '127.0.0.1', '1', '2017-09-11 09:27:06', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('385', '1', '2017-09-11 09:29:51', '127.0.0.1', '1', '2017-09-11 09:29:51', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('386', '1', '2017-09-11 09:31:32', '127.0.0.1', '1', '2017-09-11 09:31:32', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('387', '1', '2017-09-11 09:48:22', '127.0.0.1', '1', '2017-09-11 09:48:22', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('388', '1', '2017-09-11 09:55:22', '127.0.0.1', '1', '2017-09-11 09:55:22', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('389', '1', '2017-09-11 10:10:36', '127.0.0.1', '1', '2017-09-11 10:10:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('390', '1', '2017-09-11 10:12:07', '127.0.0.1', '1', '2017-09-11 10:12:07', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('391', '1', '2017-09-11 10:15:43', '127.0.0.1', '1', '2017-09-11 10:15:43', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('392', '1', '2017-09-11 10:16:08', '127.0.0.1', '1', '2017-09-11 10:16:08', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('393', '1', '2017-09-11 10:17:25', '127.0.0.1', '1', '2017-09-11 10:17:25', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('394', '1', '2017-09-11 10:20:51', '127.0.0.1', '1', '2017-09-11 10:20:51', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('395', '1', '2017-09-11 10:21:39', '127.0.0.1', '1', '2017-09-11 10:21:39', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('396', '1', '2017-09-11 10:22:45', '127.0.0.1', '1', '2017-09-11 10:22:45', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('397', '1', '2017-09-11 10:23:22', '127.0.0.1', '1', '2017-09-11 10:23:22', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('398', '1', '2017-09-11 10:23:36', '127.0.0.1', '1', '2017-09-11 10:23:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('399', '1', '2017-09-11 10:24:09', '127.0.0.1', '1', '2017-09-11 10:24:09', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('400', '1', '2017-09-11 10:24:22', '127.0.0.1', '1', '2017-09-11 10:24:22', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('401', '1', '2017-09-11 10:25:48', '127.0.0.1', '1', '2017-09-11 10:25:48', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('402', '1', '2017-09-11 10:26:53', '127.0.0.1', '1', '2017-09-11 10:26:53', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('403', '1', '2017-09-11 10:27:49', '127.0.0.1', '1', '2017-09-11 10:27:49', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('404', '1', '2017-09-11 10:30:56', '127.0.0.1', '1', '2017-09-11 10:30:56', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('405', '1', '2017-09-11 10:36:23', '127.0.0.1', '1', '2017-09-11 10:36:23', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('406', '1', '2017-09-11 10:41:04', '127.0.0.1', '1', '2017-09-11 10:41:04', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('407', '1', '2017-09-11 10:42:12', '127.0.0.1', '1', '2017-09-11 10:42:12', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('408', '1', '2017-09-11 10:42:56', '127.0.0.1', '1', '2017-09-11 10:42:56', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('409', '1', '2017-09-11 10:43:12', '127.0.0.1', '1', '2017-09-11 10:43:12', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('410', '1', '2017-09-11 10:45:16', '127.0.0.1', '1', '2017-09-11 10:45:16', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('411', '1', '2017-09-11 10:45:56', '127.0.0.1', '1', '2017-09-11 10:45:56', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('412', '1', '2017-09-11 10:46:08', '127.0.0.1', '1', '2017-09-11 10:46:08', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('413', '1', '2017-09-11 10:46:23', '127.0.0.1', '1', '2017-09-11 10:46:23', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('414', '1', '2017-09-11 10:47:06', '127.0.0.1', '1', '2017-09-11 10:47:06', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('415', '1', '2017-09-11 10:51:34', '127.0.0.1', '1', '2017-09-11 10:51:34', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('416', '1', '2017-09-11 10:51:46', '127.0.0.1', '1', '2017-09-11 10:51:46', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('417', '1', '2017-09-11 10:58:21', '127.0.0.1', '1', '2017-09-11 10:58:21', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('418', '1', '2017-09-11 11:06:11', '127.0.0.1', '1', '2017-09-11 11:06:11', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('419', '1', '2017-09-11 11:07:16', '127.0.0.1', '1', '2017-09-11 11:07:16', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('420', '1', '2017-09-11 11:14:44', '127.0.0.1', '1', '2017-09-11 11:14:44', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('421', '1', '2017-09-11 11:15:19', '127.0.0.1', '1', '2017-09-11 11:15:19', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('422', '1', '2017-09-11 11:56:30', '127.0.0.1', '1', '2017-09-11 11:56:30', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('423', '1', '2017-09-11 13:43:53', '127.0.0.1', '1', '2017-09-11 13:43:53', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('424', '1', '2017-09-11 19:08:36', '127.0.0.1', '1', '2017-09-11 19:08:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('425', '1', '2017-09-11 19:28:46', '127.0.0.1', '1', '2017-09-11 19:28:46', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('426', '1', '2017-09-11 19:36:13', '127.0.0.1', '1', '2017-09-11 19:36:13', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('427', '1', '2017-09-11 19:56:36', '127.0.0.1', '1', '2017-09-11 19:56:36', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('428', '1', '2017-09-11 20:06:02', '127.0.0.1', '1', '2017-09-11 20:06:02', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('429', '1', '2017-09-12 09:49:18', '127.0.0.1', '1', '2017-09-12 09:49:18', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('430', '1', '2017-09-12 12:11:00', '127.0.0.1', '1', '2017-09-12 12:11:00', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('431', '1', '2017-09-12 14:42:49', '127.0.0.1', '1', '2017-09-12 14:42:49', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('432', '1', '2017-09-12 15:25:14', '127.0.0.1', '1', '2017-09-12 15:25:14', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('433', '1', '2017-09-12 15:27:00', '127.0.0.1', '1', '2017-09-12 15:27:00', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('434', '1', '2017-09-12 15:49:11', '127.0.0.1', '1', '2017-09-12 15:49:11', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('435', '1', '2017-09-12 23:48:41', '127.0.0.1', '1', '2017-09-12 23:48:41', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('436', '1', '2017-09-13 00:36:07', '127.0.0.1', '1', '2017-09-13 00:36:07', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('437', '1', '2017-09-13 09:58:55', '127.0.0.1', '1', '2017-09-13 09:58:55', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('438', '1', '2017-09-13 12:32:56', '127.0.0.1', '1', '2017-09-13 12:32:56', NULL, NULL, NULL, '0', NULL);
INSERT INTO `t_oauth_user_login_log`
VALUES ('439', '1', '2017-09-13 14:12:42', '127.0.0.1', '1', '2017-09-13 14:12:42', NULL, NULL, NULL, '0', NULL);

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
INSERT INTO `t_oauth_user_role` VALUES ('1', '15', '1');
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
    UPDATE t_oauth_role_resource
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
    DELETE FROM t_oauth_role_resource
    WHERE t_oauth_role_resource.resource_id = old.id;
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
DROP TRIGGER IF EXISTS `role_resource_tg1`;
DELIMITER ;;
CREATE TRIGGER `role_resource_tg1`
AFTER UPDATE ON `t_oauth_role_resource`
FOR EACH ROW
  BEGIN
    UPDATE t_oauth_menu
    SET enabled = new.enabled
    WHERE role_id = old.role_id AND resource_id = old.resource_id;
  END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `role_resource_tg2`;
DELIMITER ;;
CREATE TRIGGER `role_resource_tg2`
AFTER DELETE ON `t_oauth_role_resource`
FOR EACH ROW
  BEGIN
    DELETE FROM t_oauth_menu
    WHERE role_id = old.role_id AND resource_id = old.resource_id;
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
