pageSetUp();

// page_function
var page_function = function () {


    var $table = $("#menu-module-table");

    //搜索控件显影的监听事件
    $("#menu-module-search-control").on("click", function () {
        window.__customControls___ = $("input[type=checkbox]").prop("checked");
        TF.reInitTable($table, {
            url: "/oauth2/menuModule/api/list",
            toolbar: '#menu-module-toolbar',
            queryParams: query_params,
            filterControl: true
        })
    });

    //设置表格的搜索参数
    var query_params = function (params) {
        return {
            limit: params.limit,
            offset: params.offset,
            order: params.order,
            sort: params.sort,
            name: $("input.bootstrap-table-filter-control-name").val(),
            systemCodeName: $(".bootstrap-table-filter-control-systemCode").val()
        };
    };

    //加载表格
    TF.initTable($table, {
        url: "/oauth2/menuModule/api/list",
        toolbar: '#menu-module-toolbar',
        queryParams: query_params
    });

    var app = new Vue({
        el: "#menu-module-operation",
        data: {
            menumodule: {
                id: '',
                name: '',
                systemCode: {
                    selected: '',
                    options: []
                },
                enabled: true,
                orderIndex: null,
                remark: ''
            },
            error: {
                nameError: false,
                nameErrorMsg: '',
                orderError: false,
                orderErrorMsg: ''
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
                app.error.nameError = Boolean($errs.name)
                app.error.nameErrorMsg = $errs.name
                app.error.orderError = Boolean($errs.orderIndex)
                app.error.orderErrorMsg = $errs.orderIndex

                if (!check_result) {
                    TF.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var datas = app.menumodule

                    for (var data in datas) {
                        if (data === "systemCode")
                            continue;
                        params.append(data, datas[data])
                    }
                    params.append("systemCode", app.menumodule.systemCode.selected);
                    axios.post('/oauth2/menuModule/api/add', params)
                        .then(function (response) {
                            if (response.data.code === TF.STATUS_CODE.SUCCESS) {
                                layer.msg(response.data.message);
                                $("#add_menumodule_dialog").dialog("close");
                                $table.bootstrapTable("refresh");
                            } else {
                                TF.show_error_msg(response.data.message)
                            }
                        })
                        .catch(function (error) {
                            TF.show_error_msg(error.response.data.message)
                        });
                }
                return false;
            },
            handleSubmit_edit: function () {
                this.$vuerify.clear();//清空之前的验证结果信息
                var check_result = this.$vuerify.check();// 手动触发校验所有数据
                var $errs = this.$vuerify.$errors;

                app.error.nameError = Boolean($errs.name);
                app.error.nameErrorMsg = $errs.name;
                app.error.orderError = Boolean($errs.orderIndex);
                app.error.orderErrorMsg = $errs.orderIndex;

                if (!check_result) {
                    TF.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var datas = app.menumodule;
                    for (var data in datas) {
                        if (data === "systemCode") {
                            continue;
                        }
                        params.append(data, datas[data])
                    }
                    params.append("systemCode", datas.systemCode.selected)
                    axios.post(' /oauth2/menuModule/api/edit', params)
                        .then(function (response) {
                            if (response.data.code === TF.STATUS_CODE.SUCCESS) {
                                layer.msg(response.data.message);
                                $("#edit_menumodule_dialog").dialog("close");
                                $table.bootstrapTable('refresh');
                            } else {
                                TF.show_error_msg(response.data.message)
                            }
                        })
                        .catch(function (error) {
                            TF.show_error_msg(error.response.data.message)
                        });
                }
                return false;
            }
        },
        vuerify: {
            name: {
                test: function () {
                    return String(app.menumodule.name).length >= 2
                },
                message: '名字长度不能为空且不能过短'
            },
            orderIndex: {
                test: function () {
                    return !isNaN(app.menumodule.orderIndex)
                },
                message: '不能为空且必须为数字'
            },
        }
    });

    //监听添加事件
    $("#add-menumodule").click(function () {
        app.menumodule.id = "";
        app.menumodule.name = "";
        app.menumodule.enabled = true;
        app.menumodule.orderIndex = "0";
        app.menumodule.remark = "";

        app.error.nameError = false;
        app.error.nameErrorMsg = '';
        app.error.orderIndexError = false;
        app.error.orderIndexErrorMsg = '';

        $("#add_menumodule_dialog").dialog('open');
        return false;
    });

    $('#add_menumodule_dialog').dialog({
        autoOpen: false,
        width: 600,
        resizable: true,
        modal: true,
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 添加菜单模块</h4></div>",
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp; 确定",
            "class": "btn btn-info",
            click: function () {
                $("#menuModuleAdd").trigger("click");
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
    $("#edit-menumodule").click(function () {

        app.error.nameError = false;
        app.error.nameErrorMsg = '';
        app.error.orderIndexError = false;
        app.error.orderIndexErrorMsg = '';

        var ss = $table.bootstrapTable('getSelections');
        if (ss.length === 1) {

            var res = ss[0];
            $('#edit_menumodule_dialog').dialog('open');
            app.menumodule.id = res.id;
            app.menumodule.systemCode.selected = res.systemCode;
            app.menumodule.name = res.name;
            app.menumodule.enabled = res.enabled;
            app.menumodule.orderIndex = res.orderIndex;
            app.menumodule.remark = res.remark;
        } else {
            TF.show_error_message("错误选择", "请选择一条记录进行编辑")
        }
        return false;
    });

    $('#edit_menumodule_dialog').dialog({
        autoOpen: false,
        width: 600,
        resizable: true,
        modal: true,
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 编辑菜单</h4></div>",
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp; 确定",
            "class": "btn btn-info",
            click: function () {
                $("#menuModuleEdit").trigger("click");
            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp; 取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    });

    //监听禁用按钮事件
    $("#delete-menumodule").click(function () {
        var ss = $table.bootstrapTable('getSelections');
        if (ss.length === 0) {
            TF.show_error_message("错误选择", "请至少选择一项进行禁用操作")
        } else {
            $.SmartMessageBox({
                title: "<i class='fa fa-minus-square-o' style='color:red'></i> 禁用以下菜单模块?",
                content: $this.data('reset.msg') || "确认要禁用以下菜单模块?",
                buttons: '[取消][确定]'
            }, function (ButtonPressed) {
                if (ButtonPressed === "确定") {
                    var ids = "";
                    for (var i = 0; i < ss.length; i++) {
                        ids += ss[i].id + ",";
                    }
                    ids = ids.substr(0, ids.length - 1);//去除最后一个逗号
                    axios.post("/oauth2/menuModule/api/forbid?id=" + ids)
                        .then(function (response) {
                            if (response.data.code === TF.STATUS_CODE.SUCCESS) {
                                layer.msg(response.data.message);
                                $table.bootstrapTable("refresh");
                            } else {
                                TF.show_error_msg(response.data.message)
                            }
                        })

                }
            })
        }
    });


    //获取下拉框内容
    axios.post('/oauth2/system-module/api/find/modules/enabled', {})
        .then(function (response) {
            if (response.data.length > 0) {
                app.menumodule.systemCode = response.data;
                var $selectSystemCode = app.menumodule.systemCode;
                app.menumodule.systemCode.selected = $selectSystemCode[0].systemCode;//默认给下拉菜单选中第一个
                for (var i = 0; i < $selectSystemCode.length; i++) {
                    $('#menumodule-selector-add,#menumodule-selector-edit').append("<option value=" + $selectSystemCode[i].systemCode + ">" + $selectSystemCode[i].name + "</option>");
                }
            }
        })
        .catch(function (error) {
            TF.show_error_msg(error.response.data.message)
        });
};


// load related plugins
page_function();