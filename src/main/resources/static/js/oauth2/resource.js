pageSetUp();

var page_function = function () {
    var $table = $("#resource-table");
    //搜索控件显影的监听事件
    $("#resource-search-control").on("click", function () {
        window.__customControls___ = $(this).find("input[type=checkbox]").prop("checked");
        Global.toggleTableSearch();
    });

    var query_params = function (params) {
        return {
            limit: params.limit,
            offset: params.offset,
            order: params.order,
            sort: params.sort,
            url: $("input.bootstrap-table-filter-control-url").val(),
            permissionMark: $("input.bootstrap-table-filter-control-permissionMark").val(),
            systemCode: $(".bootstrap-table-filter-control-systemModuleName").val(),
            name: $("input.bootstrap-table-filter-control-name").val(),
            enabled: $(".bootstrap-table-filter-control-enabled").val()
        };
    };

    //加载表格
    Global.initTable($table, {
        url: "/oauth2/resource/api/list",
        toolbar: '#resource-toolbar',
        queryParams: query_params,
        filterControl: true
    });

    var app = new Vue({
        el: "#bigResource",
        data: {
            error: {
                urlError: false,
                urlErrorMsg: '',
                nameError: false,
                nameErrorMsg: '',
                permissionMarkError: false,
                permissionMarkErrorMsg: '',
                systemCodeError: '',
                systemCodeErrorMsg: '',
                enabledError: false,
                enabledErrorMsg: '',
                orderError: false,
                orderkErrorMsg: '',
            },
            Resource: {
                url: '',
                name: '',
                permissionMark: '',
                enabled: true,
                orderIndex: '0',
                remark: '',
                systemCode: {
                    selected: '',
                    options: []
                }
            }
        },
        methods: {
            //添加界面提交操作
            handleAddSubmit: function () {
                this.$vuerify.clear()//清空之前的验证结果信息
                var check_result = this.$vuerify.check()// 手动触发校验所有数据
                var $errs = this.$vuerify.$errors

                app.error.urlError = Boolean($errs.url)
                app.error.nameError = Boolean($errs.name)
                app.error.permissionMarkError = Boolean($errs.permissionMark)
                app.error.systemCodeError = Boolean($errs.systemCode)
                app.error.enabledError = Boolean($errs.enabled)
                app.error.orderError = Boolean($errs.orderIndex)
                app.error.urlErrorMsg = $errs.url
                app.error.nameErrorMsg = $errs.name
                app.error.permissionMarkErrorMsg = $errs.permissionMark
                app.error.systemCodeErrorMsg = $errs.systemCode
                app.error.enabledErrorMsg = $errs.enabled
                app.error.orderErrorMsg = $errs.orderIndex

                if (!check_result) {
                    Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var resources = app.Resource
                    for (var data in resources) {
                        if (data === "systemCode")
                            continue;
                        params.append(data, resources[data])
                    }
                    params.append("systemCode", app.Resource.systemCode.selected)
                    axios.post('/oauth2/resource/api/add', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                app.Resource.id = " ";
                                app.Resource.name = " ";
                                app.Resource.url = " ";
                                app.Resource.permissionMark = " ";
                                app.Resource.orderIndex = " ";
                                app.Resource.remark = " ";
                                $("#addResource").dialog("close");
                                $table.bootstrapTable("refresh");
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

            },

            //编辑界面提交操作
            handleEditSubmit: function () {
                this.$vuerify.clear()//清空之前的验证结果信息
                var check_result = this.$vuerify.check()// 手动触发校验所有数据
                var $errs = this.$vuerify.$errors

                app.error.urlError = Boolean($errs.url)
                app.error.permissionMarkError = Boolean($errs.permissionMark)
                app.error.enabledError = Boolean($errs.enabled)
                app.error.orderError = Boolean($errs.orderIndex)
                app.error.urlErrorMsg = $errs.url
                app.error.permissionMarkErrorMsg = $errs.permissionMark
                app.error.enabledErrorMsg = $errs.enabled
                app.error.orderErrorMsg = $errs.orderIndex

                if (!check_result) {
                    Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    params.append("id", app.Resource.id)
                    params.append("name", app.Resource.name)
                    params.append("url", app.Resource.url)
                    params.append("permissionMark", app.Resource.permissionMark)
                    params.append("systemCode", app.Resource.systemCode.selected)
                    params.append("enabled", app.Resource.enabled)
                    params.append("orderIndex", app.Resource.orderIndex)
                    params.append("remark", app.Resource.remark)
                    axios.post('/oauth2/resource/api/edit', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                app.Resource.id = " ";
                                app.Resource.name = " ";
                                app.Resource.url = " ";
                                app.Resource.permissionMark = " ";
                                app.Resource.orderIndex = " ";
                                app.Resource.remark = " ";
                                $("#editResource").dialog("close");
                                $table.bootstrapTable("refresh");
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
            }

        },
        computed: {
            errors: function () {
                return this.$vuerify.$errors // 错误信息会在 $vuerify.$errors 内体现
            }
        },

        vuerify: {
            url: {
                test: function () {
                    return String(app.Resource.url).length > 0
                        && app.Resource.url.startsWith("/")
                        && !Global.isChinese(app.Resource.url)
                },
                message: '资源路径不能为空且必须以/开头且不含中文'
            },
            name: {
                test: function () {
                    return String(app.Resource.name).length > 0
                },
                message: '资源名称不能为空'
            },
            permissionMark: {
                test: function () {
                    return String(app.Resource.permissionMark).length > 0
                },
                message: '权限标识不能为空'
            },
            orderIndex: {
                test: function () {
                    return !isNaN(app.Resource.orderIndex)
                },
                message: '排序索引不能为空且只为数字'
            },
        }

    });


    //监听新增按钮事件
    $("#add-resource").click(function () {
        for (var f in app.error) {
            if (f.indexOf("Msg") > -1) {
                app.error[f] = "";
            } else {
                app.error[f] = false;
            }
        }
        app.Resource.id = "";
        app.Resource.name = "";
        app.Resource.url = "";
        app.Resource.permissionMark = "";
        app.Resource.orderIndex = 0;
        app.Resource.remark = "";
        $("#addResource").dialog("open");
        return false;
    });

    //监听编辑按钮事件
    $("#edit-resource").click(function () {
        var editResources = $table.bootstrapTable('getSelections');
        if (editResources.length !== 1) {
            Global.show_error_message("错误选择提示", "请选择一份资源以供编辑信息")
        } else {
            app.Resource.id = editResources[0].id;
            app.Resource.name = editResources[0].name;
            app.Resource.url = editResources[0].url;
            app.Resource.permissionMark = editResources[0].permissionMark;
            app.Resource.enabled = editResources[0].enabled;
            app.Resource.orderIndex = editResources[0].orderIndex;
            app.Resource.remark = editResources[0].remark;
            app.Resource.systemCode.selected = editResources[0].systemCode;
            $("#editResource").dialog("open");

        }
    })

    //监听删除按钮事件
    $("#delete-resource").click(function () {
        var deleteResources = $table.bootstrapTable('getSelections');
        if (deleteResources.length === 0) {
            Global.show_error_message("错误选择提示", "请选择资源以供删除")
        } else {
            $.SmartMessageBox({
                title: "<i class='fa fa-minus-square-o' style='color:red'></i> 删除资源信息？",
                content: "是否删除当前所选资源信息？",
                buttons: '[取消][确认]'
            }, function (ButtonPressed) {
                if (ButtonPressed === "确认") {
                    var deleteIds = "";
                    for (var idRow in deleteResources) {
                        deleteIds += deleteResources[idRow].id + ",";
                    }
                    deleteIds = deleteIds.substr(0, deleteIds.length - 1);
                    axios.post('/oauth2/resource/api/delete?ids=' + deleteIds)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $table.bootstrapTable("refresh");
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
            })
        }
    })

    //添加界面弹出
    $("#addResource").dialog({
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 添加新资源</h4></div>",
        autoOpen: false,
        width: 550,
        resizable: false,
        modal: true,
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp;确认",
            "class": "btn btn-primary",
            click: function () {
                $("#resourceAdd").trigger("click");

            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp;取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    })

    //编辑界面弹出
    $("#editResource").dialog({
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 编辑资源</h4></div>",
        autoOpen: false,
        width: 600,
        resizable: false,
        modal: true,
        buttons: [{
            html: "<i class='fa fa-life-saver'></i>&nbsp;确认",
            "class": "btn btn-primary",
            click: function () {
                $("#resourceEdit").trigger("click");

            }
        }, {
            html: "<i class='fa fa-step-backward'></i>&nbsp;取消",
            "class": "btn btn-default",
            click: function () {
                app.Resource.id = " ";
                app.Resource.name = " ";
                app.Resource.url = " ";
                app.Resource.permissionMark = " ";
                app.Resource.orderIndex = " ";
                app.Resource.remark = " ";
                $(this).dialog("close");
            }
        }]
    })


    //请求系统代码下拉框数据
    axios.post('/oauth2/systemModule/api/find/modules/enabled', {})
        .then(function (response) {
            if (response.data.length > 0) {
                app.Resource.systemCode = response.data;
                var $selectSystemCode = response.data;
                app.Resource.systemCode.selected = $selectSystemCode[0].systemCode;//默认给下拉菜单选中第一个
                for (var i = 0; i < $selectSystemCode.length; i++) {
                    $('#systemCode-selector-add,#systemCode-selector-edit').append("<option value=" + $selectSystemCode[i].systemCode + ">" + $selectSystemCode[i].name + "</option>");
                }
            }
        })
        .catch(function (error) {
            if (error.response)
                Global.show_error_msg(error.response.data.message)
            else
                Global.show_error_msg(error)
        });
}


page_function();