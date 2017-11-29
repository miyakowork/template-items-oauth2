pageSetUp();

var app;
var $selectedModule = $("input[name=selectedModulePs]");
var $table = $("#privilegePage-table");
var query_params = function (params) {
    return {
        limit: params.limit,
        offset: params.offset,
        order: params.order,
        sort: params.sort,
        enabled: $(".bootstrap-table-filter-control-enabled").val(),
        moduleId: getResourceModuleId,
        resourceName: $("input.bootstrap-table-filter-control-resourceName").val()
    };
};

// page_function
var page_function = function () {

    app = new Vue({
        el: "#bigPrivilegepage",
        data: {
            error: {
                nameError: false,
                nameErrorMsg: '',
                orderError: false,
                orderErrorMsg: '',
                resourceIdError: false,
                resourceIdErrorMsg: '',
                resourceModuleNameError: false,
                resourceModuleNameErrorMsg: '',
                resourceModuleIdError: false,
                resourceModuleIdErrorMsg: ''
            },
            PrivilegePage: {
                id: '',
                resourceId: '',
                name: '',
                resourceModuleId: '',
                resourceModuleName: '',
                enabled: 'true',
                orderIndex: '0',
                remark: ''
            },
            privilegeOperation: {
                operationName: '',
                resourceId: '',
                pagePrivilegeId: '',
                operationType: {
                    selected: '',
                    options: []
                },
                enabled: true,
                remark: '',
                orderIndex: 0
            },
            poError: {
                operationNameError: false,
                operationNameErrorMsg: "",
                resourceIdError: false,
                resourceIdErrorMsg: '',
                pagePrivilegeIdError: false,
                pagePrivilegeIdErrorMsg: '',
                orderError: false,
                orderErrorMsg: ''
            }
        },
        methods: {
            //添加界面提交操作
            handleAddSubmit: function () {
                this.$vuerify.clear();   //清之前的验证结果信息
                var check_result = this.$vuerify.check();// 手动触发校验所有数据
                var $errs = this.$vuerify.$errors;
                app.error.orderError = Boolean($errs.orderIndex);
                app.error.enabledError = Boolean($errs.enabled);
                app.error.orderErrorMsg = $errs.orderIndex;
                app.error.enabledErrorMsg = $errs.enabled;
                app.error.resourceIdError = Boolean($errs.resourceId);
                app.error.resourceIdErrorMsg = $errs.resourceId;
                app.error.nameError = Boolean($errs.nameError);
                app.error.nameErrorMsg = $errs.nameError;
                app.error.resourceModuleIdError = Boolean($errs.resourceModuleId);
                app.error.resourceModuleIdErrorMsg = $errs.resourceModuleId;
                app.error.resourceModuleNameError = Boolean($errs.resourceModuleName);
                app.error.resourceModuleNameErrorMsg = $errs.resourceModuleName;
                if (!check_result) {
                    Global.show_error_message("请修正表单错误信息之后再提交");
                } else {
                    var params = new URLSearchParams();
                    var privilegepage = app.PrivilegePage
                    for (var data in privilegepage) {
                        params.append(data, privilegepage[data])
                    }
                    axios.post('/oauth2/privilegePage/api/add', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $("#addprivilegepage").dialog("close");
                                $table.bootstrapTable('refresh');
                            } else {
                                Global.show_error_msg(response.data.message)
                            }
                        })
                }

            },

            //编辑界面提交操作
            handleEditSubmit: function () {
                this.$vuerify.clear();   //清之前的验证结果信息
                var check_result = this.$vuerify.check();// 手动触发校验所有数据
                var $errs = this.$vuerify.$errors;
                app.error.nameError = Boolean($errs.name)
                app.error.orderError = Boolean($errs.orderIndex)
                app.error.enabledError = Boolean($errs.enabled)
                app.error.nameErrorMsg = $errs.name;
                app.error.orderErrorMsg = $errs.orderIndex;
                app.error.enabledErrorMsg = $errs.enabled;
                app.error.resourceIdError = Boolean($errs.resourceId);
                app.error.resourceIdErrorMsg = $errs.resourceId;
                app.error.resourceModuleIdError = Boolean($errs.resourceModuleId);
                app.error.resourceModuleIdErrorMsg = $errs.resourceModuleId;
                app.error.resourceModuleNameError = Boolean($errs.resourceModuleName);
                app.error.resourceModuleNameErrorMsg = $errs.resourceModuleName;
                if (!check_result) {
                    Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    params.append("id", app.PrivilegePage.id);
                    params.append("name", app.PrivilegePage.name);
                    params.append("resourceId", app.PrivilegePage.resourceId);
                    params.append("resourceModuleId", app.PrivilegePage.resourceModuleId);
                    params.append("enabled", app.PrivilegePage.enabled);
                    params.append("orderIndex", app.PrivilegePage.orderIndex);
                    params.append("remark", app.PrivilegePage.remark);
                    axios.post('/oauth2/privilegePage/api/edit', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $("#editprivilegepage").dialog("close");
                                $table.bootstrapTable("refresh");
                            } else {
                                Global.show_error_msg(response.data.message)
                            }
                        })
                }
            },

            //添加操作级权限
            handleAddOperationSubmit: function () {
                resetError(app.poError);
                if (String(app.privilegeOperation.operationName).length === 0) {
                    app.poError.operationNameError = true;
                    app.poError.operationNameErrorMsg = "操作权限名称不能为空";
                }
                if (String(app.privilegeOperation.resourceId).length === 0) {
                    app.poError.resourceIdError = true;
                    app.poError.resourceIdErrorMsg = "必须选择资源";
                }
                if (String(app.privilegeOperation.orderIndex).length === 0) {
                    app.poError.orderError = true;
                    app.poError.orderErrorMsg = "排序索引不能为空";
                }
                if (!app.poError.operationNameError && !app.poError.resourceIdError && !app.poError.pagePrivilegeIdError && !app.poError.orderError) {
                    var params = new URLSearchParams();
                    var po = app.privilegeOperation;
                    for (var data in po) {
                        if (data === 'operationType') continue;
                        params.append(data, po[data])
                    }
                    params.append("operationTypeId", app.privilegeOperation.operationType.selected);
                    axios.post('/oauth2/privilegeOperation/api/add', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $("#addprivilegeoperation").dialog("close");
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

                } else {
                    Global.show_error_msg("请更正表单错误之后再提交！");
                }
            }
        },
        computed: {
            errors: function () {
                return this.$vuerify.$errors // 错误信息会在 $vuerify.$errors 内体现
            }
        },
        vuerify: {
            name: {
                test: function () {
                    return String(app.PrivilegePage.name).length > 0
                },
                message: '页面权限资源名称不能为空'
            },
            orderIndex: {
                test: function () {
                    return String(app.PrivilegePage.orderIndex).length > 0
                },
                message: '排序索引不能为空'
            },
            resourceId: {

                test: function () {
                    return String(app.PrivilegePage.resourceId).length > 0
                },
                message: '请选择资源'

            },
            resourceModuleName: {
                test: function () {
                    return String(app.PrivilegePage.resourceModuleName).length > 0
                },
                message: "资源模块不能为空"
            },
            resourceModuleId: {
                test: function () {
                    return String(app.PrivilegePage.resourceModuleId).length > 0
                },
                message: "资源模块不能为空"
            }
        }
    });

    //监听添加按钮点击事件
    $("#add-privilegepage").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("privilegepageTree");
        var nodes = treeObj.getCheckedNodes(true);
        if (nodes.length === 0) {
            Global.show_error_msg("请现在左侧勾选资源模块");
        }
        else {
            app.PrivilegePage.resourceModuleName = nodes[0].name + "（其他模块请在左侧重新勾选）";
            app.PrivilegePage.resourceModuleId = nodes[0].id;
            app.PrivilegePage.enabled = true;
            app.PrivilegePage.resourceId = '';
            app.PrivilegePage.name = '';
            app.PrivilegePage.orderIndex = 0;
            app.PrivilegePage.remark = '';
            resetError(app.error);
            $("#addprivilegepage").dialog("open");
        }
    });

    //监听编辑按钮点击事件
    $("#edit-privilegepage").click(function () {
        var editUsers = $table.bootstrapTable('getSelections');
        if (editUsers.length !== 1) {
            Global.show_error_message("错误选择提示", "请选择一条记录来编辑");
        } else {
            app.PrivilegePage.id = editUsers[0].id;
            app.PrivilegePage.resourceId = editUsers[0].resourceId;
            app.PrivilegePage.resourceModuleId = editUsers[0].resourceModuleId;
            app.PrivilegePage.resourceModuleName = editUsers[0].resourceModuleName;
            app.PrivilegePage.name = editUsers[0].name;
            app.PrivilegePage.enabled = editUsers[0].enabled;
            app.PrivilegePage.orderIndex = editUsers[0].orderIndex;
            app.PrivilegePage.remark = editUsers[0].remark;
            resetError(app.error)

            $("#editprivilegepage").dialog("open");
        }
    })


    //添加弹出框操作
    $("#addprivilegeoperation").dialog({
        title: "<div class='widget-header'><h4><i class='icon-ok'></i>添加页面内操作级权限资源</h4></div>",
        autoOpen: false,
        width: 600,
        resizable: false,
        modal: true,
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp;确认",
            "class": "btn btn-primary",
            click: function () {
                $("#doAddPrivilegeOperation").trigger("click");

            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp;取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    })

    //添加弹出框操作
    $("#addprivilegepage").dialog({
        title: "<div class='widget-header'><h4><i class='icon-ok'></i>添加新页面权限</h4></div>",
        autoOpen: false,
        width: 600,
        resizable: false,
        modal: true,
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp;确认",
            "class": "btn btn-primary",
            click: function () {
                $("#doAddPrivilegePage").trigger("click");

            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp;取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    })

    //编辑弹出框操作
    $("#editprivilegepage").dialog({
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 编辑页面权限模块</h4></div>",
        autoOpen: false,
        width: 600,
        resizable: false,
        modal: true,
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp;确认",
            "class": "btn btn-primary",
            click: function () {
                $("#doEditPrivilegePage").trigger("click");
            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp;取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    })

    //删除
    $("#delete-privilegepage").click(function () {
        var ss = $table.bootstrapTable('getSelections');
        if (ss.length === 0) {
            Global.show_error_message("错误选择", "请至少选择一项进行禁用操作")
        } else {
            Global.deleteItems($table, "/oauth2/privilegePage/api/delete", "name");
        }
    });

    //获取下拉框内容
    axios.post('/oauth2/systemModule/api/find/modules/enabled', {})
        .then(function (response) {
            if (response && response.status === 200) {
                var $selectModuleControl = $('#select-modules-ps');
                if (response.data.length > 0) {
                    var systemModules = response.data;
                    $selectModuleControl.append("<option value=''>全部系统平台</option>");
                    for (var i = 0; i < systemModules.length; i++) {
                        $selectModuleControl.append("<option value=" + systemModules[i].systemCode + ">" + systemModules[i].name + "</option>");
                    }
                    $selectedModule.val("");
                }
            }
            //循环完select之后加载左侧角色树
            load_privilegePageTree();
        })
        .catch(function (error) {
            if (error.response)
                Global.show_error_msg(error.response.data.message)
            else
                Global.show_error_msg(error)
        });

    //获取操作权限类型下拉框内容
    axios.post('/oauth2/operationPrivilegeType/api/find/operationType/enabled', {})
        .then(function (response) {
            if (response.data.length > 0) {
                app.privilegeOperation.operationType = response.data;
                var $selectType = app.privilegeOperation.operationType;
                app.privilegeOperation.operationType.selected = $selectType[0].id;//默认给下拉菜单选中第一个
                var $typeSelect = $('#privilegeOperation-typeId-add');
                for (var i = 0; i < $selectType.length; i++) {
                    $typeSelect.append("<option value=" + $selectType[i].id + ">" + $selectType[i].name + "</option>");
                }
            }
        })
        .catch(function (error) {
            if (error.response)
                Global.show_error_msg(error.response.data.message)
            else
                Global.show_error_msg(error)
        });

    //监听下拉框改变而来改变左侧的资源模块树
    $("#select-modules-ps").on("change", function () {
        var treeObj = $.fn.zTree.getZTreeObj("privilegepageTree");
        treeObj.destroy();
        $selectedModule.val($(this).val());
        load_privilegePageTree();
    });

    //取消勾选资源模块，并刷新树和表格内容
    var $resModuleTree = $("#refreshResModuleTree");
    $resModuleTree.click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("privilegepageTree");
        treeObj.cancelSelectedNode();
        var nodes = treeObj.getCheckedNodes(true);
        if (nodes.length === 0) {
            layer.msg("没有勾选资源模块，取消勾选无效！");
            return;
        }
        for (var i = 0, l = nodes.length; i < l; i++) {
            treeObj.checkNode(nodes[i], false, true);
        }
        Global.reInitTable($table, {
            url: "/oauth2/privilegePage/api/list",
            toolbar: '#privilegePage-toolbar',
            queryParams: function (params) {
                return {
                    limit: params.limit,
                    offset: params.offset,
                    order: params.order,
                    sort: params.sort
                };
            },
            clickToSelect: false,
            filterControl: true
        })
    });

    var tipsIndex;
    $resModuleTree.hover(function () {
        tipsIndex = layer.tips($(this).attr("title"), '#refreshResModuleTree');
    }, function () {
        layer.close(tipsIndex);
    });

    //获取资源
    $("#getResource,#reGetResource,#getResourceInOp").click(function () {
        layer.open({
            type: 2,
            title: "资源列表",
            area: ['850px', '550px'],
            fixed: true,
            resize: false,
            offset: '200px',
            content: "/oauth2/privilegePage/resourceSelect"
        })
    });

};

//获取资源模块id
function getResourceModuleId() {
    if ($.fn.zTree.getZTreeObj("privilegepageTree") !== null) {
        if ($.fn.zTree.getZTreeObj("privilegepageTree").getSelectedNodes().length === 0) {
            return "";
        } else
            return $.fn.zTree.getZTreeObj("privilegepageTree").getSelectedNodes()[0].id
    }
    else return "";
}

//表格的操作栏
function operation_formatter(value, row, index) {
    return "<button class='btn btn-xs btn-primary add-po' onclick='addPo(" + row.id + ")'>添加</button>&nbsp;" +
        "<button class='btn btn-warning btn-xs pp' onclick='pp(" + row.id + ")'>管理</button>";
}

//表格每一行中的添加操作级权限的按钮
function addPo(id) {
    var treeObj = $.fn.zTree.getZTreeObj("privilegepageTree");
    var nodes = treeObj.getCheckedNodes(true);
    if (nodes.length === 0) {
        Global.show_error_msg("请先在左侧资源模块树上勾选模块")
    } else {
        app.privilegeOperation.pagePrivilegeId = id;
        app.privilegeOperation.resourceId = '';
        app.privilegeOperation.operationName = '';
        resetError(app.poError);
        $("#addprivilegeoperation").dialog("open");
    }
}

//页面内按钮级权限
function pp(id) {
    event.preventDefault();
    $("#poInPageId").val(id);
    layer.open({
        type: 2,
        title: '页面内操作级权限管理',
        content: '/oauth2/privilegeOperation',
        area: ['1030px', '560px']
    });
}


//加载左侧树结构
var load_privilegePageTree = function () {
    var settings = {
        data: {
            simpleData: {
                enable: true,
                rootPId: 0
            }
        },
        check: {
            enable: true,
            chkStyle: "radio",
            radioType: "all"
        },
        callback: {
            onClick: function (event, treeId, treeNode) {
                var treeObj = $.fn.zTree.getZTreeObj("privilegepageTree");
                treeObj.checkNode(treeNode, true, false);

                var $table = $("#privilegePage-table");
                var opt = {
                    url: "/oauth2/privilegePage/api/list",
                    silent: true,
                    query: {
                        moduleId: treeNode.id
                    }
                };
                $table.bootstrapTable('refresh', opt);
            }
        }
    };
    $.get("/oauth2/resModule/api/resModuleTree?systemModuleCode=" + $selectedModule.val(), function (json) {
        $.fn.zTree.init($("#privilegepageTree"), settings, json);
        var treeObj = $.fn.zTree.getZTreeObj("privilegepageTree");
        var nodes = treeObj.getNodes();
        if (nodes.length > 0) {
            treeObj.selectNode(nodes[0]);//默认选中第一个
            treeObj.checkNode(nodes[0], true, true);//默认勾选中第一个
        }
        //树加载完加载表格,加载全部页面级权限的资源，不区分资源模块模块
        if ($table) {
            $table.bootstrapTable("destroy");
        }
        Global.initTable($table, {
            url: "/oauth2/privilegePage/api/list",
            toolbar: '#privilegePage-toolbar',
            clickToSelect: false,
            queryParams: query_params,
            filterControl: true
        });
    })
};

// load related plugins
page_function();
