pageSetUp();
var app;
// page_function
var page_function = function () {
    var $table = $("#resModule-table");

    var query_params = function (params) {
        return {
            limit: params.limit,
            offset: params.offset,
            order: params.order,
            sort: params.sort,
            name: $("input.bootstrap-table-filter-control-name").val(),
            systemCode: $(".bootstrap-table-filter-control-systemModuleName").val(),
            selectEnabled: $(".bootstrap-table-filter-control-enabled").val()
        };
    };

    app = new Vue({
        el: "#res_module_dialog",
        data: {
            resModule: {
                id: '',
                name: '',
                enabled: true,
                orderIndex: null,
                remark: '',
                systemCode: {
                    selected: '',
                    options: []
                }
            },
            error: {
                nameError: false,
                nameErrorMsg: '',
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
                app.error.nameError = Boolean($errs.name)
                app.error.nameErrorMsg = $errs.name
                app.error.orderIndexError = Boolean($errs.orderIndex)
                app.error.orderIndexErrorMsg = $errs.orderIndex
                if (!check_result) {
                    TF.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var datas = app.resModule
                    for (var data in datas) {
                        if (data === "systemCode")
                            continue
                        params.append(data, datas[data])
                    }
                    params.append('systemCode', app.resModule.systemCode.selected)
                    axios.post('/oauth2/resModule/api/add', params)
                        .then(function (response) {
                            if (response.data.code === TF.status_code.success) {
                                layer.msg(response.data.message);
                                setTimeout(function () {
                                    $('#add_res_module_dialog').dialog('close');
                                    $table.bootstrapTable('refresh');
                                })
                            } else {
                                TF.show_error_msg(response.data.message)
                            }
                        })
                        .catch(function (error) {
                            if (error.response)
                                TF.show_error_msg(error.response.data.message)
                            else
                                TF.show_error_msg(error)
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
                    TF.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var datas = app.resModule
                    for (var data in datas) {
                        if (data === "systemCode")
                            continue
                        params.append(data, datas[data])
                    }
                    params.append("systemCode", app.resModule.systemCode.selected)
                    axios.post('/oauth2/resModule/api/edit', params)
                        .then(function (response) {
                            if (response.data.code === TF.status_code.success) {
                                layer.msg(response.data.message);
                                setTimeout(function () {
                                    $('#edit_res_module_dialog').dialog('close');
                                    $table.bootstrapTable('refresh');
                                })
                            } else {
                                TF.show_error_msg(response.data.message)
                            }
                        })
                        .catch(function (error) {
                            if (error.response)
                                TF.show_error_msg(error.response.data.message)
                            else
                                TF.show_error_msg(error)
                        });
                }
                return false;
            }
        },
        vuerify: {
            name: {
                test: function () {
                    return String(app.resModule.name).length >= 2
                },
                message: '名字长度不能为空且不能过短'
            },
            orderIndex: {
                test: function () {
                    return !isNaN(app.resModule.orderIndex)
                },
                message: '不能为空且必须为数字'
            },
        }
    });

    //加载表格
    TF.initTable($table, {
        url: "/oauth2/resModule/api/list",
        toolbar: '#resModule-toolbar',
        queryParams: query_params,
        filterControl: true
    });

    // Dialog click
    $('#add-resModule').click(function () {
        app.resModule.name = '';
        app.resModule.enabled = true;
        app.resModule.orderIndex = 0;
        app.resModule.remark = '';

        app.error.nameError = false;
        app.error.nameErrorMsg = '';
        app.error.orderIndexError = false;
        app.error.orderIndexErrorMsg = '';
        $('#add_res_module_dialog').dialog('open');
        return false;
    });
    <!--添加dialog-->
    $('#add_res_module_dialog').dialog({
        autoOpen: false,
        width: 550,
        resizable: true,
        modal: true,
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 添加资源模块</h4></div>",
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp; 添加",
            "class": "btn btn-info",
            click: function () {
                $("#resModuleAdd").trigger("click");
            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp; 取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    });
    <!--编辑dialog-->
    $('#edit-resModule').click(function () {
        //判断是否只选中一条信息
        if ($table.bootstrapTable('getSelections').length > 1) {
            TF.show_error_msg("只能选择一条信息进行编辑")
        } else if ($table.bootstrapTable('getSelections').length < 1) {
            TF.show_error_msg("请选择您想要编辑的信息")
        }
        //将选中的信息自动显示
        else {
            //获取选中的对象
            var $editResModule = $table.bootstrapTable('getSelections')[0];
            //把获取到的对象赋值给当前页面上的元素
            app.resModule.id = $editResModule.id
            app.resModule.name = $editResModule.name
            app.resModule.enabled = $editResModule.enabled
            app.resModule.orderIndex = $editResModule.orderIndex
            app.resModule.remark = $editResModule.remark
            app.resModule.systemCode.selected = $editResModule.systemCode

            app.error.nameError = false;
            app.error.nameErrorMsg = '';
            app.error.orderIndexError = false;
            app.error.orderIndexErrorMsg = '';

            $('#edit_res_module_dialog').dialog('open');
        }
        return false;
    });
    //编辑dialog
    $('#edit_res_module_dialog').dialog({
        autoOpen: false,
        width: 550,
        resizable: true,
        modal: true,
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 编辑资源模块</h4></div>",
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp; 编辑",
            "class": "btn btn-info",
            click: function () {
                $("#resModuleEdit").trigger("click");
            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp; 取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    });

    //删除
    $("#delete-resModule").click(function () {
        var ss = $table.bootstrapTable('getSelections');
        if (ss.length === 0) {
            TF.show_error_message("错误选择", "请至少选择一项进行删除")
        } else {
            TF.deleteItems($table, "/oauth2/resModule/api/delete", "name");
        }
    });


    //获取下拉框内容
    axios.post('/oauth2/system-module/api/find/modules/enabled', {})
        .then(function (response) {
            if (response.data.length > 0) {
                app.resModule.systemCode = response.data;
                var $selectSystemCode = app.resModule.systemCode;
                app.resModule.systemCode.selected = $selectSystemCode[0].systemCode;
                for (var i = 0; i < $selectSystemCode.length; i++) {
                    $('#resource-module-selector-add,#resource-module-selector-edit').append("<option value=" + $selectSystemCode[i].systemCode + ">" + $selectSystemCode[i].name + "</option>");
                }
            }
        })
        .catch(function (error) {
            if (error.response)
                TF.show_error_msg(error.response.data.message)
            else
                TF.show_error_msg(error)
        });

};

function selectSystemCode(e) {
    app.resModule.systemCode.selected = e.target.value
}


// load related plugins
page_function();
