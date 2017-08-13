pageSetUp();

var app;
// page_function
var page_function = function () {
    var $table = $("#privilegeSort-table");
    //搜索控件显影的监听事件
    $("#privilegeSort-search-control").on("click", function () {
        window.__customControls___ = $(this).find("input[type=checkbox]").prop("checked");
        TF.reInitTable($table, {
            url: "/oauth2/privilegeSort/api/list",
            toolbar: '#privilegeSort-toolbar',
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
            enabled: $("select[name=enabled1]").val(),
            moduleId: getParentIdOnSort,
            resourceName: $("input.bootstrap-table-filter-control-resourceName").val(),
        };
    };


    app = new Vue({
        el: "#bigprivilegepage",
        data: {
            error: {
                nameError: false,
                nameErrorMsg: '',
                orderError: false,
                orderErrorMsg: '',
                parentIdError: false,
                parentIdErrorMsg: '',
                resourceIdError: false,
                resourceIdErrorMsg: ''
            },
            PrivilegePage: {
                id: '',
                resourceId: '',
                resourceModuleId: '',
                name: '',
                enabled: 'true',
                orderIndex: '0',
                remark: ''
            }
        },
        methods: {
            //添加界面提交操作
            handleAddSubmit: function () {
                this.$vuerify.clear();   //清之前的验证结果信息
                var check_result = this.$vuerify.check()// 手动触发校验所有数据
                var $errs = this.$vuerify.$errors
                app.error.orderError = Boolean($errs.orderIndex)
                app.error.enabledError = Boolean($errs.enabled)
                app.error.orderErrorMsg = $errs.orderIndex
                app.error.enabledErrorMsg = $errs.enabled
                app.error.resourceIdError = Boolean($errs.resourceId)
                app.error.resourceIdErrorMsg = $errs.resourceId
                if (!check_result) {
                    TF.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var privilegepage = app.PrivilegePage
                    for (var data in privilegepage) {
                        params.append(data, privilegepage[data])
                    }
                    axios.post('/oauth2/privilegeSort/api/add', params)
                        .then(function (response) {
                            if (response.data.code === TF.STATUS_CODE.SUCCESS) {

                                layer.msg(response.data.message);
                                $("#addprivilegepage").dialog("close");
                                $table.bootstrapTable('refresh');
                                load_privilegepageTree();

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
                this.$vuerify.clear();   //清之前的验证结果信息
                var check_result = this.$vuerify.check()// 手动触发校验所有数据
                var $errs = this.$vuerify.$errors
                app.error.nameError = Boolean($errs.name)
                app.error.orderError = Boolean($errs.orderIndex)
                app.error.enabledError = Boolean($errs.enabled)
                app.error.nameErrorMsg = $errs.name
                app.error.orderErrorMsg = $errs.orderIndex
                app.error.enabledErrorMsg = $errs.enabled
                app.error.resourceIdError = Boolean($errs.resourceId)
                app.error.resourceIdErrorMsg = $errs.resourceId
                if (!check_result) {
                    TF.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var privilegepage = app.PrivilegePage
                    params.append("id", app.PrivilegePage.id)
                    params.append("resourceId", app.PrivilegePage.resourceId)
                    params.append("resourceModuleId", app.PrivilegePage.resourceModuleId)
                    params.append("enabled", app.PrivilegePage.enabled)
                    params.append("orderIndex", app.PrivilegePage.orderIndex)
                    params.append("remark", app.PrivilegePage.remark)
                    axios.post('/oauth2/privilegeSort/api/edit', params)
                        .then(function (response) {
                            if (response.data.code === TF.STATUS_CODE.SUCCESS) {
                                layer.msg(response.data.message);
                                $("#editprivilegepage").dialog("close");
                                load_privilegepageTree();
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
                    return String(app.PrivilegePage.name).length > 0
                },
                message: '模块名称不能为空'
            },
            parentId: {
                test: function () {
                    return String(app.PrivilegePage.parentId).length > 0
                },
                message: '资源模块不能为空'
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
                message: '请选择资源ID'

            }
        }
    });

    //监听添加按钮点击事件
    $("#add-privilegepage").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("privilegepageTree");
        var nodes = treeObj.getCheckedNodes(true);
        if (nodes.length === 0) {
            TF.show_error_message("错误选择提示", "请勾选资源模块再添加");
        }
        else {
            app.PrivilegePage.name = nodes[0].name;
            app.PrivilegePage.resourceModuleId = nodes[0].id;
            app.PrivilegePage.enabled = true;
            app.PrivilegePage.resourceId = '';
            app.PrivilegePage.id = '';
            app.PrivilegePage.orderIndex = 0;
            app.PrivilegePage.remark = '';
            app.error.nameError = false;
            app.error.nameErrorMsg = '';
            app.error.orderError = false;
            app.error.orderErrorMsg = '';
            app.error.parentIdError = false;
            app.error.parentIdErrorMsg = '';
            app.error.resourceIdError = false;
            app.error.resourceIdErrorMsg = '';
            $("#addprivilegepage").dialog("open");
        }
    });

    //监听编辑按钮点击事件
    $("#edit-privilegepage").click(function () {
        var editUsers = $table.bootstrapTable('getSelections');
        if (editUsers.length !== 1) {
            TF.show_error_message("错误选择提示", "请选择一位用户以供编辑信息")
        } else {
            app.PrivilegePage.id = editUsers[0].id;
            app.PrivilegePage.resourceId = editUsers[0].resourceId;
            app.PrivilegePage.resourceModuleId = editUsers[0].resourceModuleId;
            app.PrivilegePage.name = editUsers[0].name;
            app.PrivilegePage.enabled = editUsers[0].enabled;
            app.PrivilegePage.orderIndex = editUsers[0].orderIndex;
            app.PrivilegePage.remark = editUsers[0].remark;
            app.error.nameError = false;
            app.error.nameErrorMsg = '';
            app.error.orderError = false;
            app.error.orderErrorMsg = '';
            app.error.parentIdError = false;
            app.error.parentIdErrorMsg = '';

            app.error.resourceIdError = false;
            app.error.resourceIdErrorMsg = '';

            $("#editprivilegepage").dialog("open");
        }
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
                $("#add").trigger("click");

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
                $("#edit").trigger("click");
            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp;取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    })

    //编辑界面修改模块资源弹出树
    $("#editGetPId").click(function () {
        layer.open({
            type: 2,
            area: ['300px', '400px'],
            title: ['选择模块资源，双击选择', 'text-align:center;'],
            fixed: true,
            resize: false,
            offset: '200px',
            content: 'privilegepage/tree'
        })
    })

    //获取下拉框内容
    axios.post('/oauth2/system-module/api/find/modules/enabled', {})
        .then(function (response) {
            if (response && response.status === 200) {
                var $selectedModule = $("input[name=selectedModulePs]");
                var $selectModuleControl = $('#select-modules-ps');
                if (response.data.length > 0) {
                    var systemModules = response.data;
                    $selectModuleControl.append("<option value=''>全部系统模块</option>");
                    for (var i = 0; i < systemModules.length; i++) {
                        $selectModuleControl.append("<option value=" + systemModules[i].systemCode + ">" + systemModules[i].name + "</option>");
                    }
                    $selectedModule.val("");
                }
            }
            //循环完select之后加载左侧角色树
            load_privilegepageTree();
            //循环完之后加载表格
            TF.initTable($table, {
                url: "/oauth2/privilegeSort/api/list",
                toolbar: '#privilegeSort-toolbar',
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
                TF.show_error_msg(error.response.data.message)
            else
                TF.show_error_msg(error)
        });


};

//获取资源模块id
function getParentIdOnSort() {
    if ($.fn.zTree.getZTreeObj("privilegepageTree") !== null) {
        if ($.fn.zTree.getZTreeObj("privilegepageTree").getSelectedNodes().length === 0) {
            return 0;
        } else
            return $.fn.zTree.getZTreeObj("privilegepageTree").getSelectedNodes()[0].id
    }
    else return 0;
}

//加载左侧树结构
var load_privilegepageTree = function () {
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
                if (treeNode.isParent) {
                    TF.show_error_message("错误消息提示", "请选择资源模块", 3000);
                }
                else {
                    var $table = $("#privilegeSort-table");
                    var opt = {
                        url: "/oauth2/privilegeSort/api/list",
                        silent: true,
                        query: {
                            moduleId: treeNode.id
                        }
                    };
                    $table.bootstrapTable('refresh', opt);
                }
            }
        }
    };
    $.get("/oauth2/privilegeSort/api/selectMenuModuleTree", function (json) {
        $.fn.zTree.init($("#privilegepageTree"), settings, json);
    })
};

function parentNameFormatter(val) {
    return val === null || val === "-" ? "根节点" : val;
}

// load related plugins
page_function();