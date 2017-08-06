//资源表:袁琪
DROP TABLE IF EXISTS `t_oauth_resource`;
CREATE TABLE `t_oauth_resource` (
  `id`              INT(11)      NOT NULL AUTO_INCREMENT
  COMMENT 'id',
  `url`             VARCHAR(100) NOT NULL
  COMMENT '资源路径',
  `name`            VARCHAR(50)  NOT NULL
  COMMENT '资源中文名称',
  `permission_mark` VARCHAR(16)  NOT NULL
  COMMENT '权限标识',
  `system_code`     VARCHAR(20)  NOT NULL
  COMMENT '系统模块代码',
  `enabled`         TINYINT      NOT NULL DEFAULT 1
  COMMENT '是否可用',
  `update_date`     DATETIME     NOT NULL DEFAULT CURRENT_DATE
  COMMENT '修改时间',
  `update_user`     INT(11)      NOT NULL
  COMMENT '修改人',
  `create_date`     DATETIME     NOT NULL
  COMMENT '创建日期',
  `create_user`     INT(11)      NOT NULL
  COMMENT '创建人',
  `order_index`     INT(11)      NOT NULL DEFAULT 0
  COMMENT '排序',
  `remark`          VARCHAR(50)
  COMMENT '备注',
  PRIMARY KEY (`id`)
);

//角色表：涂晨
DROP TABLE IF EXISTS `t_oauth_role`;
CREATE TABLE `t_oauth_role` (
  `id`          INT(11)     NOT NULL AUTO_INCREMENT
  COMMENT '主键ID',
  `name`        VARCHAR(50) NOT NULL
  COMMENT '名称',
  `cn_name`     VARCHAR(50) NOT NULL
  COMMENT '角色标识',
  `parent_id`   INT(11)     NOT NULL
  COMMENT '父级角色id',
  `system_code` VARCHAR(20) NOT NULL
  COMMENT '系统模块代码',
  `create_date` DATETIME    NOT NULL
  COMMENT '创建时间',
  `create_user` INT(11)     NOT NULL
  COMMENT '创建人',
  `update_date` DATETIME    NOT NULL DEFAULT CURRENT_DATE
  COMMENT '修改时间',
  `update_user` INT(11)     NOT NULL
  COMMENT '修改人',
  `order_index` INT(11)     NOT NULL
  COMMENT '排序',
  `remark`      VARCHAR(50)
  COMMENT '备注',
  `enabled`     TINYINT     NOT NULL DEFAULT 1
  COMMENT '是否可用',
  PRIMARY KEY (`id`)
);

//菜单表:刘蓉奇
DROP TABLE IF EXISTS `t_oauth_menu`;
CREATE TABLE `t_oauth_menu` (
  `id`             INT(11)     NOT NULL      AUTO_INCREMENT
  COMMENT '菜单id',
  `name`           VARCHAR(50) NOT NULL
  COMMENT '名称',
  `resource_id`    INT(11)     NOT NULL
  COMMENT '资源id',
  `system_code`    VARCHAR(20) NOT NULL
  COMMENT '系统模块代码',
  `icon`           VARCHAR(50)
  COMMENT '菜单图标',
  `menu_type`      VARCHAR(10) NOT NULL
  COMMENT '菜单类型(1:：权限菜单，2：外部url菜单，3：js事件)',
  `href`           VARCHAR(500)
  COMMENT '外部链接地址',
  `onclick`        TEXT
  COMMENT 'onclick事件',
  `target`         VARCHAR(16)
  COMMENT 'target属性',
  `role_id`        INT(11)     NOT NULL
  COMMENT '角色id',
  `menu_module_id` INT(11)     NOT NULL
  COMMENT '菜单模块id',
  `parent_id`      INT(11)     NOT NULL
  COMMENT '父级id',
  `enabled`        TINYINT     NOT NULL      DEFAULT 1
  COMMENT '是否可用',
  `update_date`    DATETIME    NOT NULL      DEFAULT CURRENT_DATE
  COMMENT '修改时间',
  `update_user`    INT(11)     NOT NULL
  COMMENT '修改人',
  `create_date`    DATETIME    NOT NULL
  COMMENT '创建时间',
  `create_user`    INT(11)     NOT NULL
  COMMENT '创建人',
  `order_index`    INT(11)     NOT NULL      DEFAULT 0
  COMMENT '排序',
  `remark`         VARCHAR(50)
  COMMENT '备注',
  PRIMARY KEY (`id`)
);

//菜单模块基础表:刘蓉奇
DROP TABLE IF EXISTS `t_oauth_menu_module`;
CREATE TABLE `t_oauth_menu_module` (
  `id`          INT(11)     NOT NULL    AUTO_INCREMENT
  COMMENT '菜单模块主键id',
  `name`        VARCHAR(50) NOT NULL
  COMMENT '名称',
  `system_code` VARCHAR(20) NOT NULL
  COMMENT '系统模块代码',
  `enabled`     TINYINT     NOT NULL    DEFAULT 1
  COMMENT '是否可用',
  `update_date` DATETIME    NOT NULL    DEFAULT CURRENT_DATE
  COMMENT '修改时间',
  `update_user` INT(11)     NOT NULL
  COMMENT '修改人',
  `create_date` DATETIME    NOT NULL
  COMMENT '创建时间',
  `create_user` INT(11)     NOT NULL
  COMMENT '创建人',
  `order_index` INT(11)     NOT NULL    DEFAULT 0
  COMMENT '排序',
  `remark`      VARCHAR(50)
  COMMENT '备注',
  PRIMARY KEY (`id`)
);

//资源模块表：袁琪
DROP TABLE IF EXISTS `t_oauth_resource_module`;
CREATE TABLE `t_oauth_resource_module` (
  `id`          INT(11)     NOT NULL AUTO_INCREMENT
  COMMENT '模块id',
  `name`        VARCHAR(50)          DEFAULT NULL
  COMMENT '名称',
  `system_code` VARCHAR(20) NOT NULL
  COMMENT '系统模块代码',
  `enabled`     TINYINT     NOT NULL DEFAULT 1
  COMMENT '是否可用',
  `update_date` DATETIME    NOT NULL DEFAULT CURRENT_DATE
  COMMENT '更新日期',
  `update_user` INT(11)     NOT NULL
  COMMENT '更新人',
  `create_date` DATETIME    NOT NULL
  COMMENT '创建日期',
  `create_user` INT(11)     NOT NULL
  COMMENT '创建人',
  `order_index` INT(11)     NOT NULL DEFAULT 0
  COMMENT '排序',
  `remark`      VARCHAR(50)
  COMMENT '备注',
  PRIMARY KEY (`id`)
);

//页面级权限表:张腾
DROP TABLE IF EXISTS `t_oauth_privilege_page`;
CREATE TABLE `t_oauth_privilege_page` (
  `id`                 INT(11)  NOT NULL  AUTO_INCREMENT
  COMMENT '页面权限表id',
  `resource_id`        INT(11)  NOT NULL
  COMMENT '资源id',
  `resource_module_id` CHAR(10) NOT NULL
  COMMENT '资源模块id',
  `enabled`            TINYINT  NOT NULL  DEFAULT 1
  COMMENT '是否可用',
  `update_date`        DATETIME NOT NULL  DEFAULT CURRENT_DATE
  COMMENT '修改时间',
  `update_user`        INT(11)  NOT NULL
  COMMENT '修改用户',
  `create_date`        DATETIME NOT NULL
  COMMENT '创建日期',
  `create_user`        INT(11)  NOT NULL
  COMMENT '创建用户',
  `order_index`        INT(11)  NOT NULL  DEFAULT 0
  COMMENT '排序',
  `remark`             VARCHAR(50)
  COMMENT '备注',
  PRIMARY KEY (`id`)
);

//作级权限类型基础表:张腾
DROP TABLE IF EXISTS `t_oauth_operation_privlege_type`;
CREATE TABLE `t_oauth_operation_privilege_type` (
  `id`          INT(11)     NOT NULL AUTO_INCREMENT
  COMMENT '操作级权限类型基础表Id',
  `name`        VARCHAR(50) NOT NULL
  COMMENT '操作级权限类型名称',
  `enabled`     TINYINT     NOT NULL DEFAULT 1
  COMMENT '是否可用',
  `update_date` DATETIME    NOT NULL DEFAULT CURRENT_DATE
  COMMENT '修改时间',
  `update_user` INT(11)     NOT NULL
  COMMENT '修改人',
  `create_date` DATETIME    NOT NULL
  COMMENT ' 创建时间',
  `create_user` INT(11)     NOT NULL
  COMMENT '创建人',
  `order_index` INT(11)     NOT NULL DEFAULT 0
  COMMENT '排序',
  `remark`      VARCHAR(50)
  COMMENT '备注',
  PRIMARY KEY (`id`)
);

//操作级权限表:张腾
DROP TABLE IF EXISTS `t_oauth_privilege_operation`;
CREATE TABLE `t_oauth_privilege_operation` (
  `id`                INT(11)     NOT NULL   AUTO_INCREMENT
  COMMENT '操作级权限表Id',
  `operation_name`    VARCHAR(50) NOT NULL
  COMMENT '操作名称',
  `resource_id`       INT(11)     NOT NULL
  COMMENT '资源id',
  `page_privilege_id` INT(11)     NOT NULL
  COMMENT '页面级权限id',
  `operation_type_id` INT(11)     NOT NULL
  COMMENT '操作类型id',
  `enabled`           TINYINT     NOT NULL   DEFAULT 1
  COMMENT '是否可用',
  `update_date`       DATETIME    NOT NULL   DEFAULT CURRENT_DATE
  COMMENT '修改日期',
  `update_user`       INT(11)     NOT NULL
  COMMENT '修改用户',
  `create_date`       DATETIME    NOT NULL
  COMMENT '创建日期',
  `create_user`       INT(11)     NOT NULL
  COMMENT '创建人',
  `order_index`       INT(11)     NOT NULL   DEFAULT 0
  COMMENT '排序',
  `remark`            VARCHAR(50)
  COMMENT '备注',
  PRIMARY KEY (`id`)
);

//部门表:袁琪
DROP TABLE IF EXISTS `t_oauth_department`;
CREATE TABLE `t_oauth_department` (
  `id`          INT(11)     NOT NULL  AUTO_INCREMENT
  COMMENT '部门主键id',
  `name`        VARCHAR(50) NOT NULL
  COMMENT '名称',
  `parent_id`   INT(11)     NOT NULL
  COMMENT '父级id',
  `enabled`     TINYINT     NOT NULL  DEFAULT 1
  COMMENT '是否可用',
  `update_date` DATETIME    NOT NULL  DEFAULT CURRENT_DATE
  COMMENT '修改时间',
  `update_user` INT(11)     NOT NULL
  COMMENT '修改人',
  `create_date` DATETIME    NOT NULL
  COMMENT '创建时间',
  `create_user` INT(11)     NOT NULL
  COMMENT '创建人',
  `order_index` INT(11)     NOT NULL  DEFAULT 0
  COMMENT '排序',
  `remark`      VARCHAR(50)
  COMMENT '备注',
  PRIMARY KEY (`id`)
);

//系统参数表：袁琪
DROP TABLE IF EXISTS `t_oauth_system_param`;
CREATE TABLE `t_oauth_system_param` (
  `id`          INT(11)     NOT NULL   AUTO_INCREMENT
  COMMENT '系统参数表主键id',
  `name`        VARCHAR(50) NOT NULL
  COMMENT '名称',
  `value`       VARCHAR(50) NOT NULL
  COMMENT '参数值',
  `enabled`     TINYINT     NOT NULL   DEFAULT 1
  COMMENT '是否可用',
  `update_date` DATETIME    NOT NULL   DEFAULT CURRENT_DATE
  COMMENT '更新时间',
  `update_user` INT(11)     NOT NULL
  COMMENT '更新人',
  `create_date` DATETIME    NOT NULL
  COMMENT '创建日期',
  `create_user` INT(11)     NOT NULL
  COMMENT '创建人',
  `order_index` INT(11)     NOT NULL   DEFAULT 0
  COMMENT '排序',
  `remark`      VARCHAR(50)
  COMMENT '备注',
  PRIMARY KEY (`id`)
);

//用户登录日志表：袁琪
DROP TABLE IF EXISTS `t_oauth_user_login_log`;
CREATE TABLE `t_oauth_user_login_log` (
  `id`              INT(11)     NOT NULL    AUTO_INCREMENT
  COMMENT '用户登录日志主键id',
  `user_id`         INT(11)     NOT NULL
  COMMENT '用户id',
  `last_login_date` DATETIME    NOT NULL
  COMMENT '登录时间',
  `last_login_ip`   VARCHAR(50) NOT NULL
  COMMENT '登录ip',
  `enabled`         TINYINT                 DEFAULT 1
  COMMENT '是否可用',
  `update_date`     DATETIME                DEFAULT CURRENT_DATE
  COMMENT '更新日期',
  `update_user`     INT(11)
  COMMENT '更新人',
  `create_date`     DATETIME
  COMMENT '创建时间',
  `create_user`     INT(11)
  COMMENT '创建人',
  `order_index`     INT(11)                 DEFAULT 0
  COMMENT '排序',
  `remark`          VARCHAR(50)
  COMMENT '备注',
  PRIMARY KEY (`id`)
);

//用户表:涂晨
DROP TABLE IF EXISTS `t_oauth_user`;
CREATE TABLE `t_oauth_user` (
  `id`              INT(11)     NOT NULL  AUTO_INCREMENT
  COMMENT '主键ID',
  `username`        VARCHAR(50) NOT NULL
  COMMENT '用户名',
  `password`        VARCHAR(50) NOT NULL
  COMMENT '密码',
  `cname`           VARCHAR(50) NOT NULL
  COMMENT '姓名',
  `dept_id`         INT(11)     NOT NULL
  COMMENT '部门id,多个用逗号隔开',
  `enabled`         TINYINT     NOT NULL  DEFAULT 1
  COMMENT '是否可用',
  `update_date`     DATETIME    NOT NULL  DEFAULT CURRENT_DATE
  COMMENT '修改时间',
  `update_user`     INT(11)     NOT NULL
  COMMENT '修改人',
  `create_date`     DATETIME    NOT NULL
  COMMENT '创建时间',
  `create_user`     INT(11)     NOT NULL
  COMMENT '创建人',
  `order_index`     INT(11)     NOT NULL  DEFAULT 0
  COMMENT '排序',
  `remark`          VARCHAR(50)
  COMMENT '备注',
  `salt`            VARCHAR(50) NOT NULL
  COMMENT '盐',
  `email`           VARCHAR(50) NOT NULL
  COMMENT '邮箱',
  `default_role_id` INT(11)     NOT NULL
  COMMENT '默认角色(父级)',
  `qq`              VARCHAR(50)
  COMMENT 'qq',
  `wechat`          VARCHAR(50)
  COMMENT '微信',
  `mobile`          VARCHAR(20)
  COMMENT '手机号码',
  PRIMARY KEY (`id`)
);

//系统模块表：wwb
DROP TABLE IF EXISTS `t_oauth_system_module`;
CREATE TABLE `t_oauth_system_module` (
  `id`          INT(11)     NOT NULL   AUTO_INCREMENT
  COMMENT '主键id',
  `name`        VARCHAR(20) NOT NULL
  COMMENT '系统模块名称',
  `system_code` VARCHAR(20) NOT NULL
  COMMENT '系统模块代码',
  `enabled`     TINYINT     NOT NULL   DEFAULT 1
  COMMENT '是否可用',
  `update_date` DATETIME    NOT NULL   DEFAULT CURRENT_DATE
  COMMENT '更新时间',
  `update_user` INT(11)     NOT NULL
  COMMENT '更新人',
  `create_date` DATETIME    NOT NULL
  COMMENT '创建日期',
  `create_user` INT(11)     NOT NULL
  COMMENT '创建人',
  `order_index` INT(11)     NOT NULL   DEFAULT 0
  COMMENT '排序',
  `remark`      VARCHAR(50)
  COMMENT '备注',
  PRIMARY KEY (`id`)
);

//用户角色中间表
DROP TABLE IF EXISTS `t_oauth_user_role`;
CREATE TABLE `t_oauth_user_role` (
  `user_id` INT(11) NOT NULL
  COMMENT '用户id',
  `role_id` INT(11) NOT NULL
  COMMENT '角色id'
);

//session会话持久化对象表
DROP TABLE IF EXISTS `t_oauth_session`;
CREATE TABLE `t_oauth_session` (
  `id`               INT(11) AUTO_INCREMENT NOT NULL
  COMMENT '会话持久化对象主键id',
  `username`         VARCHAR(50)            NOT NULL
  COMMENT '会话用户',
  `session_id`       VARCHAR(50)            NOT NULL
  COMMENT 'session id 唯一的',
  `session_base64`   TEXT                   NOT NULL
  COMMENT 'session序列化字符串',
  `ip`               VARCHAR(20)            NOT NULL
  COMMENT '创建这个会话的访问ip地址',
  `first_visit_date` DATETIME
  COMMENT '会话创建日期时间',
  `last_visit_date`  DATETIME
  COMMENT '最后访问日期',
  `session_timeout`  INT(11)                NOT NULL
  COMMENT 'session失效时间',
  `create_url`       VARCHAR(100)           NOT NULL
  COMMENT '创建这个会话的url',
  `update_url`       VARCHAR(100)           NOT NULL
  COMMENT '更新这个会话的url',
  `user_agent`       VARCHAR(200)
  COMMENT 'userAgent',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `T_OAUTH_ROLE_RESOURCE`;
CREATE TABLE T_OAUTH_ROLE_RESOURCE (
  ROLE_ID     INTEGER NOT NULL,
  RESOURCE_ID INTEGER NOT NULL,
  CONSTRAINT T_OAUTH_ROLE_RESOURCE_T_OAUTH_RESOURCE_ID_FK FOREIGN KEY (RESOURCE_ID) REFERENCES PUBLIC.T_OAUTH_RESOURCE (ID) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT T_OAUTH_ROLE_RESOURCE_T_OAUTH_ROLE_ID_FK FOREIGN KEY (ROLE_ID) REFERENCES PUBLIC.T_OAUTH_ROLE (ID) ON DELETE RESTRICT ON UPDATE RESTRICT
);

//以下为建立索引
ALTER TABLE PUBLIC.T_OAUTH_MENU
  ADD CONSTRAINT T_OAUTH_MENU_T_OAUTH_RESOURCE_ID_fk
FOREIGN KEY (RESOURCE_ID) REFERENCES T_OAUTH_RESOURCE (ID);
ALTER TABLE PUBLIC.T_OAUTH_MENU
  ADD CONSTRAINT T_OAUTH_MENU_T_OAUTH_SYSTEM_MODULE_SYSTEM_CODE_fk
FOREIGN KEY (SYSTEM_CODE) REFERENCES T_OAUTH_SYSTEM_MODULE (SYSTEM_CODE);
ALTER TABLE PUBLIC.T_OAUTH_MENU
  ADD CONSTRAINT T_OAUTH_MENU_T_OAUTH_ROLE_ID_fk
FOREIGN KEY (ROLE_ID) REFERENCES T_OAUTH_ROLE (ID);
ALTER TABLE PUBLIC.T_OAUTH_MENU
  ADD CONSTRAINT T_OAUTH_MENU_T_OAUTH_MENU_MODULE_ID_fk
FOREIGN KEY (MENU_MODULE_ID) REFERENCES T_OAUTH_MENU_MODULE (ID);

ALTER TABLE PUBLIC.T_OAUTH_MENU_MODULE
  ADD CONSTRAINT T_OAUTH_MENU_MODULE_T_OAUTH_SYSTEM_MODULE_SYSTEM_CODE_fk
FOREIGN KEY (SYSTEM_CODE) REFERENCES T_OAUTH_SYSTEM_MODULE (SYSTEM_CODE);

ALTER TABLE PUBLIC.T_OAUTH_PRIVILEGE_OPERATION
  ADD CONSTRAINT T_OAUTH_PRIVILEGE_OPERATION_T_OAUTH_RESOURCE_ID_fk
FOREIGN KEY (RESOURCE_ID) REFERENCES T_OAUTH_RESOURCE (ID);
ALTER TABLE PUBLIC.T_OAUTH_PRIVILEGE_OPERATION
  ADD CONSTRAINT T_OAUTH_PRIVILEGE_OPERATION_T_OAUTH_PRIVILEGE_PAGE_ID_fk
FOREIGN KEY (PAGE_PRIVILEGE_ID) REFERENCES T_OAUTH_PRIVILEGE_PAGE (ID);
ALTER TABLE PUBLIC.T_OAUTH_PRIVILEGE_OPERATION
  ADD CONSTRAINT T_OAUTH_PRIVILEGE_OPERATION_T_OAUTH_OPERATION_PRIVILEGE_TYPE_ID_fk
FOREIGN KEY (OPERATION_TYPE_ID) REFERENCES T_OAUTH_OPERATION_PRIVILEGE_TYPE (ID);

ALTER TABLE PUBLIC.T_OAUTH_PRIVILEGE_PAGE
  ADD CONSTRAINT T_OAUTH_PRIVILEGE_PAGE_T_OAUTH_RESOURCE_ID_fk
FOREIGN KEY (RESOURCE_ID) REFERENCES T_OAUTH_RESOURCE (ID);
ALTER TABLE PUBLIC.T_OAUTH_PRIVILEGE_PAGE
  ADD CONSTRAINT T_OAUTH_PRIVILEGE_PAGE_T_OAUTH_RESOURCE_MODULE_ID_fk
FOREIGN KEY (RESOURCE_MODULE_ID) REFERENCES T_OAUTH_RESOURCE_MODULE (ID);

ALTER TABLE PUBLIC.T_OAUTH_RESOURCE
  ADD CONSTRAINT T_OAUTH_RESOURCE_T_OAUTH_SYSTEM_MODULE_SYSTEM_CODE_fk
FOREIGN KEY (SYSTEM_CODE) REFERENCES T_OAUTH_SYSTEM_MODULE (SYSTEM_CODE);

ALTER TABLE PUBLIC.T_OAUTH_RESOURCE_MODULE
  ADD CONSTRAINT T_OAUTH_RESOURCE_MODULE_T_OAUTH_SYSTEM_MODULE_SYSTEM_CODE_fk
FOREIGN KEY (SYSTEM_CODE) REFERENCES T_OAUTH_SYSTEM_MODULE (SYSTEM_CODE);

ALTER TABLE PUBLIC.T_OAUTH_ROLE
  ADD CONSTRAINT T_OAUTH_ROLE_T_OAUTH_SYSTEM_MODULE_SYSTEM_CODE_fk
FOREIGN KEY (SYSTEM_CODE) REFERENCES T_OAUTH_SYSTEM_MODULE (SYSTEM_CODE);

ALTER TABLE PUBLIC.T_OAUTH_SYSTEM_MODULE
  ADD CONSTRAINT T_OAUTH_SYSTEM_MODULE_T_OAUTH_SYSTEM_MODULE_SYSTEM_CODE_fk
FOREIGN KEY (SYSTEM_CODE) REFERENCES T_OAUTH_SYSTEM_MODULE (SYSTEM_CODE);

ALTER TABLE PUBLIC.T_OAUTH_USER_LOGIN_LOG
  ADD CONSTRAINT T_OAUTH_USER_LOGIN_LOG_T_OAUTH_USER_ID_fk
FOREIGN KEY (USER_ID) REFERENCES T_OAUTH_USER (ID);

ALTER TABLE PUBLIC.T_OAUTH_USER_ROLE
  ADD CONSTRAINT T_OAUTH_USER_ROLE_T_OAUTH_USER_ID_fk
FOREIGN KEY (USER_ID) REFERENCES T_OAUTH_USER (ID);
ALTER TABLE PUBLIC.T_OAUTH_USER_ROLE
  ADD CONSTRAINT T_OAUTH_USER_ROLE_T_OAUTH_ROLE_ID_fk
FOREIGN KEY (USER_ID) REFERENCES T_OAUTH_ROLE (ID);