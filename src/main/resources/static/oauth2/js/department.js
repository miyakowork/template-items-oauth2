pageSetUp();

var app;

// page_function
var page_function = function () {

    load_departmentTree();

    var $table = $("#department-table");

    //搜索控件显影的监听事件
    $("#department-search-control").on("click", function () {
        window.__customControls___ = $(this).find("input[type=checkbox]").prop("checked");
        TF.toggleTableSearch(false);
    });

    var query_params = function (params) {
        return {
            limit: params.limit,
            offset: params.offset,
            order: params.order,
            sort: params.sort,
            parentId: getParentIdOnSort(),
            name: $("input.bootstrap-table-filter-control-name").val(),
            enabled: $(".bootstrap-table-filter-control-enabled").val()
        };
    };

    //加载表格
    TF.initTable($table, {
        url: "/oauth2/department/api/list",
        toolbar: '#department-toolbar',
        queryParams: query_params,
        filterControl: true
    });


    app = new Vue({
        el: "#bigDepartment",
        data: {
            error: {
                nameError: false,
                nameErrorMsg: '',
                orderError: false,
                orderErrorMsg: '',
                parentIdError: false,
                parentIdErrorMsg: '',
                enabledError: false,
                enabledErrorMsg: '',
            },
            OauthDepartment: {
                id: '',
                name: '',
                parentId: null,
                enabled: true,
                orderIndex: '0',
                remark: ''
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
                app.error.enabledError = Boolean($errs.enabled)
                app.error.nameErrorMsg = $errs.name
                app.error.orderErrorMsg = $errs.orderIndex
                app.error.enabledErrorMsg = $errs.enabled

                if (!check_result) {
                    TF.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var departments = app.OauthDepartment
                    for (var data in departments) {
                        params.append(data, departments[data])
                    }
                    axios.post('/oauth2/department/api/add', params)
                        .then(function (response) {
                            if (response.data.code === TF.STATUS_CODE.SUCCESS) {
                                layer.msg(response.data.message);
                                $("#addDepartment").dialog("close");
                                $table.bootstrapTable("refresh");
                                load_departmentTree();
                            } else {
                                TF.show_error_msg(response.data.message)
                            }
                        })
                        .catch(function (error) {
                            TF.show_error_msg(error.response.data.message)
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
                app.error.enabledError = Boolean($errs.enabled)
                app.error.nameErrorMsg = $errs.name
                app.error.orderErrorMsg = $errs.orderIndex
                app.error.enabledErrorMsg = $errs.enabled

                if (!check_result) {
                    TF.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    app.OauthDepartment.parentId = $("#pIdByTree").val()
                    var params = new URLSearchParams();
                    var departments = app.OauthDepartment
                    params.append("id", app.OauthDepartment.id)
                    params.append("name", app.OauthDepartment.name)
                    params.append("parentId", app.OauthDepartment.parentId)
                    params.append("enabled", app.OauthDepartment.enabled)
                    params.append("orderIndex", app.OauthDepartment.orderIndex)
                    params.append("remark", app.OauthDepartment.remark)
                    axios.post('/oauth2/department/api/edit', params)
                        .then(function (response) {
                            if (response.data.code === TF.STATUS_CODE.SUCCESS) {
                                layer.msg(response.data.message);
                                $("#editDepartment").dialog("close");

                                app.OauthDepartment.id = "";
                                app.OauthDepartment.name = "";
                                app.OauthDepartment.parentId = "";
                                app.OauthDepartment.orderIndex = 0;
                                app.OauthDepartment.remark = "";
                                load_departmentTree();
                                $table.bootstrapTable("refresh");

                            } else {
                                TF.show_error_msg(response.data.message)
                            }
                        })
                        .catch(function (error) {
                            TF.show_error_msg(error.response.data.message)
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
                    return String(app.OauthDepartment.name).length > 0
                },
                message: '部门名称不能为空'
            },
            parentId: {
                test: function () {
                    return String(app.OauthDepartment.parentId).length > 0
                },
                message: '上级部门不能为空'
            },
            orderIndex: {
                test: function () {
                    return String(app.OauthDepartment.orderIndex).length > 0
                },
                message: '排序索引不能为空'
            }
        }
    });

    //监听添加按钮点击事件
    $("#add-department").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("DepartmentTree");
        var nodes = treeObj.getCheckedNodes(true);

        app.OauthDepartment.name = '';
        app.OauthDepartment.remark = '';

        app.error.nameError = false;
        app.error.orderError = false;
        app.error.enabledError = false;

        app.error.nameErrorMsg = '';
        app.error.orderErrorMsg = '';
        app.error.enabledErrorMsg = '';

        if (nodes.length === 0) {
            app.OauthDepartment.parentId = 0;
            layer.confirm('即将添加一级部门节点！<br/>若要添加其它级请在左侧选择上级部门节点！', function (index) {
                layer.close(index);
                $("#addDepartment").dialog("open");
            });
        } else {
            app.OauthDepartment.parentId = nodes[0].id;
            $("#addDepartment").dialog("open");
        }
    })

    //监听编辑按钮点击事件
    $("#edit-department").click(function () {
        app.OauthDepartment.name = '';
        app.OauthDepartment.remark = '';

        app.error.nameError = false;
        app.error.orderError = false;
        app.error.enabledError = false;

        app.error.nameErrorMsg = '';
        app.error.orderErrorMsg = '';
        app.error.enabledErrorMsg = '';
        var editUsers = $table.bootstrapTable('getSelections');
        if (editUsers.length !== 1) {
            TF.show_error_message("错误选择提示", "请选择一个部门来予以修改")
        } else {
            app.OauthDepartment.id = editUsers[0].id;
            app.OauthDepartment.name = editUsers[0].name;
            app.OauthDepartment.parentId = editUsers[0].parentId;
            app.OauthDepartment.enabled = editUsers[0].enabled;
            app.OauthDepartment.orderIndex = editUsers[0].orderIndex;
            app.OauthDepartment.remark = editUsers[0].remark;

            $("#editDepartment").dialog("open");

        }
    })

    //添加弹出框操作
    $("#addDepartment").dialog({
        title: "<div class='widget-header'><h4><i class='icon-ok'></i>添加新部门</h4></div>",
        autoOpen: false,
        width: 600,
        resizable: false,
        modal: true,
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp;确认",
            "class": "btn btn-primary",
            click: function () {
                $("#departmentAdd").trigger("click");
            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp;取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    });

    //编辑弹出框操作
    $("#editDepartment").dialog({
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 编辑部门信息</h4></div>",
        autoOpen: false,
        width: 600,
        resizable: false,
        modal: true,
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp;确认",
            "class": "btn btn-primary",
            click: function () {
                $("#departmentEdit").trigger("click");

            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp;取消",
            "class": "btn btn-default",
            click: function () {
                app.OauthDepartment.id = "";
                app.OauthDepartment.name = "";
                app.OauthDepartment.parentId = "";
                app.OauthDepartment.orderIndex = 0;
                app.OauthDepartment.remark = "";
                $(this).dialog("close");
            }
        }]
    })

    //编辑界面修改上级部门弹出树
    $("#editGetPId").click(function () {
        layer.open({
            type: 2,
            area: ['300px', '400px'],
            title: ['选择上级部门(双击选定)', 'text-align:center;'],
            fixed: true,
            resize: false,
            offset: '200px',
            content: '/oauth2/department/tree'
        })
    })

    var $refreshDepartmentTree = $("#refreshDepartmentTree");
    var tipsIndex;
    $refreshDepartmentTree.hover(function () {
        tipsIndex = layer.tips($(this).attr("title"), '#refreshDepartmentTree');
        $(this).addClass("fa-spin");
    }, function () {
        $(this).removeClass("fa-spin");
        layer.close(tipsIndex);
    });

    //取消勾选部门树，并刷新树和表格
    $refreshDepartmentTree.click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("DepartmentTree");
        treeObj.cancelSelectedNode();
        var nodes = treeObj.getCheckedNodes(true);
        if (nodes.length === 0) {
            layer.msg("并没有选择父部门，取消勾选无效！");
            return;
        }
        for (var i = 0, l = nodes.length; i < l; i++) {
            treeObj.checkNode(nodes[i], false, true);
        }
        TF.reInitTable($table, {
            url: "/oauth2/department/api/list",
            toolbar: '#department-toolbar',
            queryParams: query_params,
            filterControl: true
        })
    });
};

//加载左侧树结构
var load_departmentTree = function () {
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
        view: {
            selectedMulti: false,
        },
        callback: {
            onClick: function (event, treeId, treeNode) {
                var treeObj = $.fn.zTree.getZTreeObj("DepartmentTree");
                treeObj.checkNode(treeNode, true, false);
                var $table = $("#department-table");
                var opt = {
                    url: "/oauth2/department/api/list",
                    silent: true,
                    query: {
                        parentId: treeNode.id,
                        name: $("input.bootstrap-table-filter-control-name").val(),
                    }
                };
                $table.bootstrapTable('refresh', opt);
            }
        }
    };
    $.get("/oauth2/department/api/selectDepartment", function (json) {
        $.fn.zTree.init($("#DepartmentTree"), settings, json)
    })

};


/**
 * 格式化上级部门显示方式
 * @param val
 */
function parentNameFormatter(val) {
    return val === null || val === "-" ? "根节点" : val;
}


function getParentIdOnSort() {
    if ($.fn.zTree.getZTreeObj("DepartmentTree") !== null) {
        if ($.fn.zTree.getZTreeObj("DepartmentTree").getSelectedNodes().length > 0)
            return $.fn.zTree.getZTreeObj("DepartmentTree").getSelectedNodes()[0].id
        else return 0
    }
    return 0
}

// load related plugins,如果需要额外的js
//则使用loadScript("*.js",function(){
// loadScript("*.js",page_function()
// });
// 类似的嵌套脚本
page_function();