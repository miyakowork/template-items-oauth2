pageSetUp();

// page_function
var page_function = function () {

    var $table = $("#system-param-table");

    //搜索控件显影的监听事件
    $("#system-param-search-control").on("click", function () {
        window.__customControls___ = $(this).find("input[type=checkbox]").prop("checked");
        Global.toggleTableSearch();
    });

    var query_params = function (params) {
        return {
            limit: params.limit,
            offset: params.offset,
            order: params.order,
            sort: params.sort,
            name: $("input.bootstrap-table-filter-control-name").val(),
            value: $("input.bootstrap-table-filter-control-value").val(),
            selectEnabled: $("bootstrap-table-filter-control-enabled").val()
        };
    };

    //加载表格
    Global.initTable($table, {
        url: "/oauth2/systemParam/api/list",
        toolbar: '#system-param-toolbar',
        queryParams: query_params,
        filterControl: true
    });


    var app = new Vue({
        el: "#sys_param_dialog",
        data: {
            sysParam: {
                id: '',
                name: '',
                value: '',
                enabled: true,
                orderIndex: null,
                remark: ''
            },
            error: {
                nameError: false,
                nameErrorMsg: '',
                valueError: false,
                valueErrorMsg: '',
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
                app.error.valueError = Boolean($errs.value)
                app.error.valueErrorMsg = $errs.value
                app.error.orderError = Boolean($errs.orderIndex)
                app.error.orderErrorMsg = $errs.orderIndex

                if (!check_result) {
                    Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var datas = app.sysParam
                    for (var data in datas) {
                        params.append(data, datas[data])
                    }
                    axios.post('/oauth2/systemParam/api/add', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $('#add_sys_param_dialog').dialog('close');
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
                app.error.valueError = Boolean($errs.value)
                app.error.valueErrorMsg = $errs.value
                app.error.orderError = Boolean($errs.orderIndex)
                app.error.orderErrorMsg = $errs.orderIndex

                if (!check_result) {
                    Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var datas = app.sysParam
                    for (var data in datas) {
                        params.append(data, datas[data])
                    }
                    axios.post('/oauth2/systemParam/api/edit', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $('#edit_sys_param_dialog').dialog('close');
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
                    return String(app.sysParam.name).length >= 2
                },
                message: '名字长度不能为空且不能过短'
            },
            value: {
                test: function () {
                    return String(app.sysParam.value).length > 0
                },
                message: '值不能为空'
            },
            orderIndex: {
                test: function () {
                    return !isNaN(app.sysParam.orderIndex)
                },
                message: '不能为空且必须为数字'
            }
        }

    })


    // Dialog click
    $('#add-system-param').click(function () {
        app.sysParam.name = '';
        app.sysParam.enabled = true;
        app.sysParam.value = '';
        app.sysParam.orderIndex = 0;
        app.sysParam.remark = '';

        app.error.nameError = false;
        app.error.nameErrorMsg = '';
        app.error.valueError = false;
        app.error.valueErrorMsg = '';
        app.error.orderIndexError = false;
        app.error.orderIndexErrorMsg = '';
        $('#add_sys_param_dialog').dialog('open');
        return false;
    });

    <!--添加dialog-->
    $('#add_sys_param_dialog').dialog({
        autoOpen: false,
        width: 550,
        resizable: true,
        modal: true,
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 添加系统参数</h4></div>",
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp; 添加",
            "class": "btn btn-info",
            click: function () {
                $("#systemParamAdd").trigger("click");
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
    $('#edit-system-param').click(function () {
        //判断是否只选中一条信息
        if ($table.bootstrapTable('getSelections').length > 1) {
            Global.show_error_msg("只能选择一条信息进行编辑")
        } else if ($table.bootstrapTable('getSelections').length < 1) {
            Global.show_error_msg("请选择您想要编辑的信息")
        }
        //将选中的信息自动显示
        else {
            $('#edit_sys_param_dialog').dialog('open');
            //获取选中的对象
            var $editsysParam = $table.bootstrapTable('getSelections')[0];
            //把获取到的对象赋值给当前页面上的元素
            app.sysParam.id = $editsysParam.id
            app.sysParam.name = $editsysParam.name
            app.sysParam.enabled = $editsysParam.enabled
            app.sysParam.value = $editsysParam.value
            app.sysParam.orderIndex = $editsysParam.orderIndex
            app.sysParam.remark = $editsysParam.remark
        }
        return false;
    });
    //编辑系统参数dialog
    $('#edit_sys_param_dialog').dialog({
        autoOpen: false,
        width: 550,
        resizable: true,
        modal: true,
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 编辑系统参数</h4></div>",
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp; 编辑",
            "class": "btn btn-info",
            click: function () {
                $("#sytemParamEdit").trigger("click");
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


page_function();
