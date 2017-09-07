pageSetUp();

var app, $selectedModule;
// page_function
var page_function = function () {

    var $table = $("#role-table");

    //取消勾选角色，并刷新树和表格内容
    var $roleTree = $("#refreshRoleTree");
    $roleTree.click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("roleTree");
        treeObj.cancelSelectedNode();
        var nodes = treeObj.getCheckedNodes(true);
        if (nodes.length === 0) {
            layer.msg("并没有选择父角色，取消勾选无效！");
            return;
        }
        for (var i = 0, l = nodes.length; i < l; i++) {
            treeObj.checkNode(nodes[i], false, true);
        }
        Global.reInitTable($table, {
            url: "/oauth2/role/api/list",
            toolbar: '#role-toolbar',
            queryParams: query_params,
            filterControl: true
        })
    });

    var tipsIndex;
    $roleTree.hover(function () {
        tipsIndex = layer.tips($(this).attr("title"), '#refreshRoleTree');
    }, function () {
        layer.close(tipsIndex);
    });


    var query_params = function (params) {
        return {
            limit: params.limit,
            offset: params.offset,
            order: params.order,
            sort: params.sort,
            parentId: getParentIdOnSort,
            name: $("input.bootstrap-table-filter-control-name").val(),
            systemCode: $selectedModule.val(),
            cnName: $("input.bootstrap-table-filter-control-cnName").val(),
            selectEnabled: $("select.bootstrap-table-filter-control-enabled").val()
        };
    };

    app = new Vue({
        el: "#role_dialog",
        data: {
            error: {
                nameError: false,
                nameErrorMsg: '',
                cnNameError: false,
                cnNameErrorMsg: '',
                orderError: false,
                orderErrorMsg: '',
                parentIdError: false,
                parentIdErrorMsg: ''
            },
            role: {
                id: '',
                name: '',
                cnName: '',
                parentId: null,
                enabled: true,
                orderIndex: null,
                remark: '',
                systemCode: {
                    selected: '',
                    options: []
                },
            }
        },
        methods: {
            //添加界面提交操作
            handleAddSubmit: function () {
                this.$vuerify.clear()//清空之前的验证结果信息
                var check_result = this.$vuerify.check()// 手动触发校验所有数据
                var $errs = this.$vuerify.$errors

                app.error.nameError = Boolean($errs.name)
                app.error.orderError = Boolean($errs.orderIndex)
                app.error.cnNameError = Boolean($errs.cnName)
                app.error.cnNameErrorMsg = $errs.cnName
                app.error.nameErrorMsg = $errs.name
                app.error.orderErrorMsg = $errs.orderIndex

                if (!check_result) {
                    Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var datas = app.role
                    for (var data in datas) {
                        if (data === "systemCode")
                            continue
                        params.append(data, datas[data])
                    }
                    params.append('systemCode', $selectedModule.val())

                    axios.post('/oauth2/role/api/add', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $("#addRole").dialog("close");
                                $table.bootstrapTable("refresh");
                                var treeObj = $.fn.zTree.getZTreeObj("roleTree");
                                treeObj.destroy();
                                loadRoleTree();
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

                app.error.nameError = Boolean($errs.name)
                app.error.orderError = Boolean($errs.orderIndex)
                app.error.cnNameError = Boolean($errs.cnName)
                app.error.cnNameErrorMsg = $errs.cnName
                app.error.nameErrorMsg = $errs.name
                app.error.orderErrorMsg = $errs.orderIndex

                if (!check_result) {
                    Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    params.append("id", app.role.id)
                    params.append("name", app.role.name)
                    params.append("cnName", app.role.cnName)
                    params.append("parentId", app.role.parentId)
                    params.append("enabled", app.role.enabled)
                    params.append("orderIndex", app.role.orderIndex)
                    params.append("remark", app.role.remark)
                    params.append("systemCode", $selectedModule.val())
                    axios.post('/oauth2/role/api/edit', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $("#editRole").dialog("close");
                                $table.bootstrapTable("refresh");
                                var treeObj = $.fn.zTree.getZTreeObj("roleTree");
                                treeObj.destroy();
                                loadRoleTree();
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

            name: {
                test: function () {
                    return String(app.role.name).length > 0
                },
                message: '角色名称不能为空'
            },
            cnName: {
                test: function () {
                    return String(app.role.cnName).length > 1
                },
                message: '角色中文名不能为空且不能过短'
            },

            orderIndex: {
                test: function () {
                    return !isNaN(app.role.orderIndex)
                },
                message: '排序索引不能为空且必须为数字'
            }
        }
    });

    //监听添加按钮点击事件
    $("#add-role").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("roleTree");
        var nodes = treeObj.getCheckedNodes(true);

        $("#sca").val($("#select-modules").find("option:selected").text());
        app.role.name = '';
        app.role.cnName = '';
        app.role.remark = '';
        app.role.orderIndex = 0;
        app.role.enabled = true;

        app.error.nameError = false;
        app.error.nameErrorMsg = '';
        app.error.cnNameError = false;
        app.error.cnNameErrorMsg = '';
        app.error.orderError = false;
        app.error.orderErrorMsg = '';
        app.error.parentIdError = false;
        app.error.parentIdErrorMsg = '';

        if (nodes.length === 0) {
            app.role.parentId = 0;
            layer.confirm('即将添加一级角色节点！<br/>若要添加其它级请在左侧选择父角色节点！', function (index) {
                layer.close(index);
                $("#addRole").dialog("open");
            });
        } else {
            app.role.parentId = nodes[0].id;
            $("#addRole").dialog("open");
        }
    });

    //监听编辑按钮点击事件
    $("#edit-role").click(function () {
        var editUsers = $table.bootstrapTable('getSelections');
        if (editUsers.length !== 1) {
            Global.show_error_message("错误选择提示", "请在角色树中选择父级角色以添加子角色")
        } else {
            $("#scb").val($("#select-modules").find("option:selected").text());
            app.role.id = editUsers[0].id;
            app.role.name = editUsers[0].name;
            app.role.parentId = editUsers[0].parentId;
            app.role.enabled = editUsers[0].enabled;
            app.role.orderIndex = editUsers[0].orderIndex;
            app.role.remark = editUsers[0].remark;
            app.role.cnName = editUsers[0].cnName;
            app.role.systemCode.selected = editUsers[0].systemCode;
            app.error.nameError = false;
            app.error.nameErrorMsg = '',
                app.error.cnNameError = false;
            app.error.cnNameErrorMsg = '',
                app.error.orderError = false;
            app.error.orderErrorMsg = '';
            app.error.parentIdError = false;
            app.error.parentIdErrorMsg = '';

            $("#editRole").dialog("open");
        }
    })

    //添加弹出框操作
    $("#addRole").dialog({
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 添加新角色</h4></div>",
        autoOpen: false,
        width: 600,
        resizable: false,
        modal: true,
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp;确认",
            "class": "btn btn-primary",
            click: function () {
                $("#doAddRole").trigger("click");
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
    $("#editRole").dialog({
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 编辑角色信息</h4></div>",
        autoOpen: false,
        width: 600,
        resizable: false,
        modal: true,
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp;确认",
            "class": "btn btn-primary",
            click: function () {
                $("#edit").trigger("click");
            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp;取消",
            "class": "btn btn-default",
            click: function () {
                app.role.id = "";
                app.role.name = "";
                app.role.parentId = "";
                app.role.orderIndex = 0;
                app.role.remark = "";
                $(this).dialog("close");
            }
        }]
    });

    //编辑界面修改上级角色弹出树
    $("#editGetPId").click(function () {
        layer.open({
            type: 2,
            area: ['300px', '400px'],
            title: [$('#select-modules').find("option:selected").text() + ' - (双击选择)  ', 'text-align:center;'],
            fixed: true,
            resize: false,
            offset: '200px',
            scrollbar: false,
            content: '/oauth2/role/tree'
        })
    })

    //获取下拉框内容
    axios.post('/oauth2/systemModule/api/find/modules/enabled', {})
        .then(function (response) {
            if (response && response.status === 200) {
                app.role.systemCode = response.data;
                var $selectSystemCode = app.role.systemCode;
                $selectedModule = $("input[name=selectedModule]");
                if (response.data.length > 0) {
                    app.role.systemCode.selected = $selectSystemCode[0].systemCode;
                    for (var i = 0; i < $selectSystemCode.length; i++) {
                        $('#select-modules').append("<option value=" + $selectSystemCode[i].systemCode + ">" + $selectSystemCode[i].name + "</option>");
                    }
                    $selectedModule.val($selectSystemCode[0].systemCode);
                } else {
                    $selectedModule.val("");
                }
            }
            //循环完select之后加载左侧角色树
            loadRoleTree();
            //循环完之后加载表格
            Global.initTable($table, {
                url: "/oauth2/role/api/list",
                toolbar: '#role-toolbar',
                queryParams: function (params) {
                    var opt = query_params(params);
                    opt.systemCode = $selectedModule.val();
                    return opt;
                },
                filterControl: true
            });
        })
        .catch(function (error) {
            if (error.response)
                Global.show_error_msg(error.response.data.message)
            else
                Global.show_error_msg(error)
        });


    //监听左侧树更改模块的事件
    $("#select-modules").on("change", function () {
        var treeObj = $.fn.zTree.getZTreeObj("roleTree");
        treeObj.destroy();
        $selectedModule.val($(this).val());
        loadRoleTree();
        Global.reInitTable($table, {
            url: "/oauth2/role/api/list",
            toolbar: '#role-toolbar',
            queryParams: function (params) {
                var opt = query_params(params);
                opt.systemCode = $selectedModule.val();
                return opt;
            },
            filterControl: true
        })
    })

};

//加载左侧树
function loadRoleTree() {
    var settings = {
        data: {
            simpleData: {
                enable: true,
                rootPId: 0
            }
        },
        view: {
            selectedMulti: false
        },
        check: {
            enable: true,
            chkStyle: 'radio',
            radioType: 'all'
        },
        callback: {
            onClick: function (event, treeId, treeNode) {
                var treeObj = $.fn.zTree.getZTreeObj("roleTree");
                treeObj.checkNode(treeNode, true, false);
                treeObj.expandNode(treeNode, null, null, null, true);
                var $table = $("#role-table");
                var opt = {
                    url: "/oauth2/role/api/list",
                    silent: true,
                    query: {
                        parentId: treeNode.id,
                        name: $("input.bootstrap-table-filter-control-name").val(),
                        systemCode: $selectedModule.val()
                    }
                };
                $table.bootstrapTable('refresh', opt);
            },
            beforeExpand: beforeExpand,
            onExpand: onExpand
        }
    };
    $.get("/oauth2/role/api/selectRole?systemModuleCode=" + $selectedModule.val(), function (treeData) {
        for (var node in treeData) {
            treeData[node].open = false;
        }
        $.fn.zTree.init($("#roleTree"), settings, treeData)
    });
}

//点击排序页面不变
function getParentIdOnSort() {
    if ($.fn.zTree.getZTreeObj("roleTree") !== null) {
        if ($.fn.zTree.getZTreeObj("roleTree").getSelectedNodes().length === 0) {
            return 0;
        } else
            return $.fn.zTree.getZTreeObj("roleTree").getSelectedNodes()[0].id
    }
    else return 0;
}

//格式化根节点
function parentNameFormatter(val) {
    return (val === null || val === "-") ? "根节点" : val;
}


// load related plugins
page_function();
