pageSetUp();

var app;
// page_function
var page_function = function () {

    var $table = $("#user-table");

    //搜索控件显影的监听事件
    $("#user-search-control").on("click", function () {
        window.__customControls___ = $(this).find("input[type=checkbox]").prop("checked");
        Global.toggleTableSearch();
    });

    var query_params = function (params) {
        return {
            limit: params.limit,
            offset: params.offset,
            order: params.order,
            sort: params.sort,
            username: $("input.bootstrap-table-filter-control-username").val(),
            cname: $("input.bootstrap-table-filter-control-cname").val(),
            enabled: $(".bootstrap-table-filter-control-enabled").val(),
            createDate: $(".bootstrap-table-filter-control-createDate").val()
        };
    };

    app = new Vue({
        el: "#user_dialog",
        data: {
            user1: {
                id: '',
                username: '',
                cname: '',
                password: '',
                email: '',
                mobile: '',
                deptId: '',
                enabled: false,
                roleName: '',
                departmentName: '',
                orderIndex: 0,
                defaultRoleId: ''
            },
            error: {
                usernameError: false,
                usernameErrorMsg: '',
                cnameError: false,
                cnameErrorMsg: '',
                passwordError: false,
                passwordErrorMsg: '',
                emailError: false,
                emailErrorMsg: '',
                phoneError: false,
                phoneErrorMsg: '',
                deptIdError: false,
                deptIdErrorMsg: '',
                defaultRoleIdError: false,
                defaultRoleIdErrorMsg: ''
            },
            userPwdForce: {
                id: '',
                newPwd: '',
                confirmPwd: ''
            }
        },
        computed: {
            errors: function () {
                return this.$vuerify.$errors // 错误信息会在 $vuerify.$errors 内体现
            }
        },
        methods: {
            handleSubmit_add: function () {
                this.$vuerify.clear()//清空之前的验证结果信息
                var check_result = this.$vuerify.check()// 手动触发校验所有数据
                var $errs = this.$vuerify.$errors

                app.error.usernameError = Boolean($errs.username)
                app.error.usernameErrorMsg = $errs.username
                app.error.cnameError = Boolean($errs.cname)
                app.error.cnameErrorMsg = $errs.cname
                app.error.passwordError = Boolean($errs.password)
                app.error.passwordErrorMsg = $errs.password
                app.error.emailError = Boolean($errs.email)
                app.error.emailErrorMsg = $errs.email
                app.error.mobileError = Boolean($errs.mobile)
                app.error.mobileErrorMsg = $errs.mobile
                app.error.orderError = Boolean($errs.orderIndex)
                app.error.orderErrorMsg = $errs.orderIndex
                app.error.deptIdError = Boolean($errs.deptId)
                app.error.deptIdErrorMsg = $errs.deptId
                app.error.defaultRoleIdError = Boolean($errs.defaultRoleId)
                app.error.defaultRoleIdErrorMsg = $errs.defaultRoleId

                if (!check_result) {
                    Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var datas = app.user1
                    for (var data in datas) {
                        params.append(data, datas[data])
                    }
                    axios.post('/oauth2/user/api/add', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $('#add_user_dialog').dialog('close');
                                $table.bootstrapTable('refresh');

                            } else {
                                Global.show_error_msg(response.data.message)
                            }
                        })
                        .catch(function (error) {
                            if (error.response)
                                Global.show_error_msg(error.response.data.message)
                            else
                                Global.show_error_msg(error)
                        });
                }
                return false;
            },
            handleSubmit_edit: function () {
                this.$vuerify.clear()//清空之前的验证结果信息
                var check_result = this.$vuerify.check()// 手动触发校验所有数据
                var $errs = this.$vuerify.$errors
                app.error.usernameError = Boolean($errs.username)
                app.error.usernameErrorMsg = $errs.username
                app.error.cnameError = Boolean($errs.cname)
                app.error.cnameErrorMsg = $errs.cname
                app.error.passwordError = Boolean($errs.password)
                app.error.passwordErrorMsg = $errs.password
                app.error.emailError = Boolean($errs.email)
                app.error.emailErrorMsg = $errs.email
                app.error.mobileError = Boolean($errs.mobile)
                app.error.mobileErrorMsg = $errs.mobile
                app.error.deptIdError = Boolean($errs.deptId)
                app.error.deptIdErrorMsg = $errs.deptId
                app.error.defaultRoleIdError = Boolean($errs.defaultRoleId)
                app.error.defaultRoleIdErrorMsg = $errs.defaultRoleId


                if (!check_result) {
                    Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var datas = app.user1
                    for (var data in datas) {
                        params.append(data, datas[data])
                    }
                    axios.post('/oauth2/user/api/edit', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $('#edit_user_dialog ').dialog('close');
                                $table.bootstrapTable('refresh');
                            } else {
                                Global.show_error_msg(response.data.message)
                            }
                        })
                        .catch(function (error) {
                            Global.handleAxiosError(error);
                        });
                }
                return false;
            },
            handleSubmit_edit_pwd: function () {
                if (app.userPwdForce.newPwd !== app.userPwdForce.confirmPwd) {
                    Global.show_error_msg("两次输入的密码不一致！");
                } else {
                    var params = new URLSearchParams();
                    var datas = app.userPwdForce
                    for (var data in datas) {
                        params.append(data, datas[data])
                    }
                    axios.post('/oauth2/user/api/editPwd', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $('#edit_password_dialog ').dialog('close');
                            } else {
                                Global.show_error_msg(response.data.message)
                            }
                        })
                        .catch(function (error) {
                            if (error.response)
                                Global.show_error_msg(error.response.data.message)
                            else
                                Global.show_error_msg(error)
                        });
                }
                return false;
            },
            handleSubmit_group: function () {
                var roles = $("#allRoles").find("label>input[type=checkbox]:checked");
                var roleArray = new Array(roles.length);
                for (var i = 0; i < roles.length; i++) {
                    roleArray[i] = roles[i].value;
                }
                var userId = $("#editUserId").val();
                var params = new URLSearchParams();
                params.append("roles", roleArray);
                params.append("userId", userId)
                axios.post('/oauth2/user/api/modifyUserRoles', params)
                    .then(function (response) {
                        if (response.data.code === Global.status_code.success) {
                            layer.msg(response.data.message);
                            $('#user_role_group ').dialog('close');
                        } else {
                            Global.show_error_msg(response.data.message)
                        }
                    })
                    .catch(function (error) {
                        Global.handleAxiosError(error);
                    });
            }
        },
        vuerify: {
            username: {
                test: function () {
                    return String(app.user1.username).length >= 4
                },
                message: '用户名长度不能为空且不能少于4位'
            },
            cname: {
                test: function () {
                    return String(app.user1.cname).length >= 2
                },
                message: '名字长度不能少于2位'
            },
            password: {
                test: function () {
                    return String(app.user1.password).length > 4
                },
                message: '密码长度不能少于4位'
            },
            email: {
                test: function () {
                    var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
                    return String(app.user1.email).length === 0 || reg.test(app.user1.email);
                },
                message: '邮箱格式错误'
            },
            mobile: {
                test: function () {
                    var mobile = String(app.user1.mobile);
                    return mobile.length === 0 || mobile.length === 11;

                },
                message: '电话位(13,15,18)开头的11位数字'
            },
            deptId: {
                test: function () {
                    var deptId = app.user1.deptId;
                    return deptId !== null && deptId !== "";
                },
                message: '部门不能为空'
            },
            defaultRoleId: {
                test: function () {
                    var defaultRoleId = app.user1.defaultRoleId;
                    return defaultRoleId !== null && defaultRoleId !== "";
                },
                message: "默认角色不能为空"
            }
        }
    });


    //加载表格
    Global.initTable($table, {
        url: "/oauth2/user/api/list",
        toolbar: '#user-toolbar',
        queryParams: query_params,
        filterControl: true
    });

    // 点击添加角色弹出框
    $('#add_dialog_link').click(function () {
        for (var f in app.user1) {
            if (f === "enabled") {
                app.user1[f] = false;
            } else if (f === "orderIndex") {
                app.user1[f] = "0"
            } else {
                app.user1[f] = "";
            }

            for (var f in app.error) {
                if (f.indexOf("Msg") > -1) {
                    app.error[f] = "";
                } else {
                    app.error[f] = false;
                }
            }
        }
        $('#add_user_dialog').dialog('open');
        return false;
    });

    <!--添加dialog-->
    $('#add_user_dialog').dialog({
        autoOpen: false,
        width: 700,
        resizable: true,
        modal: true,
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 添加新用户</h4></div>",
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp; 添加",
            "class": "btn btn-info",
            click: function () {
                $("#userAdd").trigger("click");
            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp; 取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    });

    //监听编辑按钮事件
    $("#edit_userRole_group").click(function () {
        var ss = $table.bootstrapTable('getSelections');
        if (ss.length === 1) {
            var defaultRole = ss[0].defaultRoleId;
            var hasRoles, html = "";
            $.post("/oauth2/user/api/findCurrentUserRoles", {userId: ss[0].id}, function (hadRoles) {
                if (hadRoles.code === undefined) {
                    if (hadRoles instanceof Array) {//判断是不是登陆过期了，如果登录过期了，则返回的是一个提示对象json，不是role数组，所以可以使用此判断
                        hasRoles = hadRoles;
                        $.post("/oauth2/role/api/findAllRoles", function (roles) {
                            html += '<span class=" text-danger">' + roles[0].name + "</span><br/>";
                            for (var i = 0; i < roles.length; i++) {
                                if (i > 0 && roles[i].system_code !== roles[i - 1].system_code)
                                    html += '<hr><span class=" text-danger">' + roles[i].name + "</span><br/>";
                                var include = false;
                                for (var r in hasRoles) {
                                    if (hasRoles[r].id === roles[i].id)
                                        include = true;
                                }
                                var c = (include || defaultRole === roles[i].id) ? "checked" : "";
                                var d = defaultRole === roles[i].id ? " disabled='disabled'" : '';
                                var t = defaultRole === roles[i].id ? "（默认角色）" : "";
                                html += '<label class="checkbox-inline role-group"><input type="checkbox" class="checkbox style-0" value="' + roles[i].id + '"' + c + d + '><span>' + roles[i].cn_name + t + '</span></label>';
                            }
                            $("#allRoles").html(html)
                            $("#editUserId").val(ss[0].id);
                            $("#user_role_group").dialog("open");
                        });
                    }
                }
            });

        } else {
            Global.show_error_msg("请选择一个用户进行操作！");
        }
        return false;
    });

    <!--用户组编辑-->
    $('#user_role_group').dialog({
        autoOpen: false,
        width: 575,
        resizable: false,
        modal: true,
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 编辑用户组</h4></div>",
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp; 确定",
            "class": "btn btn-info",
            click: function () {
                $("#groupAdd").trigger("click");
            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp; 取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    });

    //监听编辑按钮事件
    $("#edit_dialog_link").click(function () {
        var ss = $table.bootstrapTable('getSelections');
        if (ss.length === 1) {
            var res = ss[0];
            for (var f in app.error) {
                if (f.indexOf("Msg") > -1) {
                    app.error[f] = null;
                } else {
                    app.error[f] = false;
                }
            }
            $('#edit_user_dialog').dialog('open');

            app.user1.id = res.id;
            app.user1.username = res.username;
            app.user1.cname = res.cname;
            app.user1.password = res.password;
            app.user1.email = res.email;
            app.user1.mobile = res.mobile;
            app.user1.orderIndex = res.orderIndex;
            app.user1.deptId = res.deptId;
            app.user1.departmentName = res.departmentName;
            app.user1.roleName = res.roleName;
            app.user1.defaultRoleId = res.defaultRoleId;
            app.user1.enabled = res.enabled;

        } else {
            Global.show_error_message("错误选择", "请选择一条数据进行修改操作！")
        }
        return false;
    });

    $('#edit_user_dialog').dialog({
        autoOpen: false,
        width: 700,
        resizable: true,
        modal: true,
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 编辑用户信息</h4></div>",
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp; 确定",
            "class": "btn btn-info",
            click: function () {
                $("#userEdit").trigger("click");
            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp; 取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    });
    <!-- 点击删除-->
    $('#delete-user').click(function () {
        var ss = $table.bootstrapTable('getSelections');
        if (ss.length === 0) {
            Global.show_error_message("错误选择", "请至少选择一行数据进行删除")
        } else {
            $.SmartMessageBox({
                title: "<i class='fa fa-minus-square-o' style='color:red'></i> 禁用用户?",
                content: $this.data('reset.msg') || "确认要禁用已选择的用户?",
                buttons: '[取消][确定]'
            }, function (ButtonPressed) {
                if (ButtonPressed === "确定") {
                    var ids = "";
                    for (var i = 0; i < ss.length; i++) {
                        ids += ss[i].id + ",";
                    }
                    ids = ids.substr(0, ids.length - 1);//去除最后一个逗号
                    axios.post("/oauth2/user/api/delete?ids=" + ids)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $table.bootstrapTable("refresh");
                            } else {
                                Global.show_error_msg(response.data.message)
                            }
                        })
                }
            })
        }
    });
    <!-- 添加页面弹出选择部门ztree-->
    $('#addGetPId,#editGetPId').click(function () {
        layer.open({
            type: 2,
            area: ['300px', '380px'],
            title: '选择部门(双击选定)',
            fixed: true,
            resize: false,
            offset: '200px',
            content: '/oauth2/user/treeDept'
        })
    });

    $("#addGetRole,#editGetRole").click(function () {
        layer.open({
            type: 2,
            area: ['300px', '420px'],
            title: '选择默认角色(双击选定)',
            fixed: true,
            resize: false,
            offset: '200px',
            content: '/oauth2/user/treeRole'
        })
    });

    $("#edit_password").click(function () {
        var ss = $table.bootstrapTable('getSelections');
        if (ss.length === 1) {
            app.userPwdForce.username = ss[0].username;
            app.userPwdForce.id = ss[0].id;
            app.userPwdForce.newPwd = '';
            app.userPwdForce.confirmPwd = "";

            $('#edit_password_dialog').dialog('open');
        } else {
            Global.show_error_msg("请选择一个用户进行密码修改操作！");
        }
    })

    $('#edit_password_dialog').dialog({
        autoOpen: false,
        width: 500,
        resizable: false,
        modal: true,
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 修改用户密码</h4></div>",
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp; 确定",
            "class": "btn btn-info",
            click: function () {
                $("#userPwdEdit").trigger("click");
            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp; 取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    });
};

$.root_.on("click", ".role-group", function () {
    var $this = $(this).find("input[type=checkbox]:not([disabled=disabled])");
    var s = $this.prop("checked");
    $this.prop("checked", !s);
});

page_function();

