pageSetUp();
// page_function
var page_function = function () {

    var $table = $("#opt-table");
    //搜索控件显影的监听事件
    $("#opt-search-control").on("click", function () {
        window.__customControls___ = $(this).find("input[type=checkbox]").prop("checked");
        TF.reInitTable($table, {
            url: "/oauth2/operationPrivilegeType/api/list",
            toolbar: '#opt-toolbar',
            queryParams: query_params,
            filterControl: true
        })
    });

    var query_params = function (params) {
        return {
            limit: params.limit,
            offset: params.offset,
            order: params.order,
            sort: params.sort,
            name: $("input.bootstrap-table-filter-control-name").val(),
            enabled: $(".bootstrap-table-filter-control-enabled").val()
        };
    };
    //加载表格
    TF.initTable($table, {
        url: "/oauth2/operationPrivilegeType/api/list",
        toolbar: '#opt-toolbar',
        queryParams: query_params,
        filterControl: true
    });

    //--------------------------------------------------------------------
    var app = new Vue({
        el: "#add_edit",
        data: {
            operationprivilegetype: {
                name: '',
                enabled: '1',
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
                    var datas = app.operationprivilegetype
                    for (var data in datas) {
                        params.append(data, datas[data])
                    }
                    axios.post('/oauth2/operationPrivilegeType/api/add', params)
                        .then(function (response) {
                            if (response.data.code === TF.STATUS_CODE.SUCCESS) {
                                layer.msg(response.data.message);
                                $("#dialog_simple").dialog("close");
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
            },
            handleSubmit_edit: function () {
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
                    var datas = app.operationprivilegetype
                    for (var data in datas) {
                        params.append(data, datas[data])
                    }
                    axios.post('/oauth2/operationPrivilegeType/api/edit', params)
                        .then(function (response) {
                            if (response.data.code === TF.STATUS_CODE.SUCCESS) {
                                layer.msg(response.data.message);
                                $("#dialog_simple_edit").dialog("close");
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
                    return String(app.operationprivilegetype.name).length >= 3
                },
                message: '名字长度不能为空且不能过短'
            },
            orderIndex: {
                test: function () {
                    return !isNaN(app.operationprivilegetype.orderIndex)
                },
                message: '不能为空且必须为数字'
            },
        }
    });
    //监听添加事件
    $('#add-operationprivilegetype').click(function () {
        $('#dialog_simple').dialog('open');

        app.operationprivilegetype.id = "";

        app.operationprivilegetype.name = "";

        app.operationprivilegetype.enabled = true;

        app.operationprivilegetype.orderIndex = 0;

        app.operationprivilegetype.remark = "";

        app.error.nameError = false;
        app.error.nameErrorMsg = '';

        app.error.orderError = false;

        app.error.orderErrorMsg = '';

        return false;
    });
    //添加面板属性设置
    $('#dialog_simple').dialog({
        autoOpen: false,
        width: 550,
        resizable: true,
        modal: true,
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 添加操作级权限类型模块</h4></div>",
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
    $('#edit-operationprivilegetype').click(function () {
        if ($table.bootstrapTable('getSelections').length > 1) {
            TF.show_error_msg("只能选择一条信息进行编辑")
        } else if ($table.bootstrapTable('getSelections').length < 1) {
            TF.show_error_msg("请选择您想要编辑的信息")
        }
        else {

            var ss = $table.bootstrapTable('getSelections');
            var res = ss[0];
            $('#dialog_simple_edit').dialog('open');

            app.operationprivilegetype.id = res.id;

            app.operationprivilegetype.name = res.name;

            app.operationprivilegetype.enabled = res.enabled;
            app.operationprivilegetype.orderIndex = res.orderIndex;

            app.operationprivilegetype.remark = res.remark;


            app.error.nameError = false;
            app.error.nameErrorMsg = '';

            app.error.orderError = false;

            app.error.orderErrorMsg = '';

            return false;

        }
    });
    //编辑面板属性设置
    $('#dialog_simple_edit').dialog({
        autoOpen: false,
        width: 550,
        resizable: true,
        modal: true,
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 编辑操作级权限类型模块</h4></div>",
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


};

// load related plugins
page_function();