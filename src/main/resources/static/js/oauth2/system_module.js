pageSetUp();
// page_function
var page_function = function () {

    var $table = $("#system-module-table");

    //设置表格的搜索参数
    var query_params = function (params) {
        return {
            limit: params.limit,
            offset: params.offset,
            order: params.order,
            sort: params.sort,
            name: $("input.bootstrap-table-filter-control-name").val(),
            systemCode: $("input.bootstrap-table-filter-control-systemCode").val(),
            enabled: $("select.bootstrap-table-filter-control-enabled").val()
        };
    };

    //加载表格
    Global.initTable($table, {
        url: "/oauth2/system-module/api/list",
        toolbar: '#system-module-toolbar',
        queryParams: query_params,
        filterControl: true
    });


    //--------------------------------------------------------------------
    var app = new Vue({
        el: "#add_edit",
        data: {
            systemmodule: {
                id: '',
                name: '',
                systemCode: '',
                enabled: '',
                orderIndex: 0,
                remark: ''
            },
            error: {
                nameError: false,
                nameErrorMsg: '',
                systemCodeError: false,
                systemCodeErrorMsg: '',
                orderIndexError: false,
                orderIndexErrorMsg: ''
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
                debugger
                app.error.nameError = Boolean($errs.name)
                app.error.nameErrorMsg = $errs.name
                app.error.orderIndexError = Boolean($errs.orderIndex)
                app.error.orderIndexErrorMsg = $errs.orderIndex
                app.error.systemCodeError = Boolean($errs.systemCode)
                app.error.systemCodeErrorMsg = $errs.systemCode

                if (!check_result) {
                    Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var datas = app.systemmodule
                    for (var data in datas) {
                        params.append(data, datas[data])
                    }
                    axios.post('/oauth2/system-module/api/add', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $("#addSystemModule").dialog("close");
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

                app.error.nameError = Boolean($errs.name)
                app.error.nameErrorMsg = $errs.name
                app.error.orderIndexError = Boolean($errs.orderIndex)
                app.error.orderIndexErrorMsg = $errs.orderIndex

                if (!check_result) {
                    Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var datas = app.systemmodule
                    for (var data in datas) {
                        params.append(data, datas[data])
                    }
                    axios.post('/oauth2/system-module/api/edit', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $("#editSystemModule").dialog("close");
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
            }
        },
        vuerify: {
            name: {
                test: function () {
                    return String(app.systemmodule.name).length >= 2
                },
                message: '名字长度不能为空且不能过短'
            },
            orderIndex: {
                test: function () {
                    return !isNaN(app.systemmodule.orderIndex)
                },
                message: '不能为空且必须为数字'
            },
            systemCode: {
                test: function () {
                    return String(app.systemmodule.systemCode).length > 3;
                },
                message: '不能为空且不能过短'
            }
        }
    });

    //监听添加事件
    $('#add-system-module').click(function () {
        $('#addSystemModule').dialog('open');
        app.systemmodule.id = "";
        app.systemmodule.name = "";
        app.systemmodule.systemCode = "";
        app.systemmodule.enabled = true;
        app.systemmodule.orderIndex = 0;
        app.systemmodule.remark = '';
        app.error.nameError = false;
        app.error.nameErrorMsg = '';
        app.error.orderError = false;
        app.error.orderErrorMsg = '';
        app.error.systemCodeError = false;
        app.error.systemCodeErrorMsg = '';
        return false;
    })

    //添加面板属性设置
    $('#addSystemModule').dialog({
        autoOpen: false,
        width: 600,
        resizable: true,
        modal: true,
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 添加系统模块</h4></div>",
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp; 添加",
            "class": "btn btn-info",
            click: function () {
                $("#sa").trigger("click");
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
    $('#edit-system-module').click(function () {
        if ($table.bootstrapTable('getSelections').length > 1) {
            Global.show_error_msg("只能选择一条信息进行编辑")
        } else if ($table.bootstrapTable('getSelections').length < 1) {
            Global.show_error_msg("请选择您想要编辑的信息")
        }
        else {

            var ss = $table.bootstrapTable('getSelections');
            var res = ss[0];

            $('#editSystemModule').dialog('open');
            app.systemmodule.id = res.id;
            app.systemmodule.name = res.name;
            app.systemmodule.systemCode = res.systemCode;
            app.systemmodule.enabled = res.enabled;
            app.systemmodule.orderIndex = res.orderIndex;
            app.systemmodule.remark = res.remark;
            app.error.nameError = false;
            app.error.nameErrorMsg = '';
            app.error.orderError = false;
            app.error.orderErrorMsg = '';
            app.error.systemCodeError = false;
            app.error.systemCodeErrorMsg = '';
            return false;

        }
    });
    //编辑面板属性设置
    $('#editSystemModule').dialog({
        autoOpen: false,
        width: 600,
        resizable: true,
        modal: true,
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 编辑系统模块</h4></div>",
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp; 修改",
            "class": "btn btn-info",
            click: function () {
                $("#sa_edit").trigger("click");
            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp; 取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    });
    //监听删除按钮事件
    $("#delete-system-module").click(function () {
        var $selectedEdit = $table.bootstrapTable("getSelections");
        if ($selectedEdit === null || $selectedEdit.length === 0) {
            Global.show_error_msg("请选择删除对象")
        }
        else {
            Global.deleteItems($table, "/oauth2/system-module/api/delete", "name");
        }
    });

};

//---------------------------------------------------------

/**
 * 判断创建用户是否为空
 * @param val
 * @returns {string}
 */
function parentCreatUserFormatter(val) {
    return val === null || val === "-" ? "根节点" : val;
}

/**
 * 判断更新用户是否为空
 * @param val
 * @returns {string}
 */
function parentUpdateUserFormatter(val) {
    return val === null || val === "-" ? "根节点" : val;
}


// load related plugins
page_function();
