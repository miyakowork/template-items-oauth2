pageSetUp();

var app;

// page_function
var page_function = function () {

    load_departmentTree();

    var $table = $("#table");

    //搜索控件显影的监听事件
    $("#department-search-control").on("click", function () {
        window.__customControls___ = $(this).find("input[type=checkbox]").prop("checked");
        TF.reInitTable($table, {
            url: "/department/api/list",
            toolbar: '#department-toolbar',
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
            parentId: getParentIdOnSort(),
            name: $("input.bootstrap-table-filter-control-name").val(),
            enabled: $("#enabledSelector option:selected").val()
        };
    };

    $table.bootstrapTable({
        sidePagination: "server",
        url: "/department/api/list",
        toolbar: '#department-toolbar',
        showRefresh: true,
        method: 'post',
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",//post方式一定得改成这种contentType
        queryParams: query_params,
        height: getHeight(),
        sortName: 'id',//第一次进页面默认的排序字段
        sortOrder: 'asc',
        idField: "id",
        uniqueId: 'id',
        checkboxHeader: true,
        clickToSelect: true,
        showColumns: true,
        silentSort: false,
        maintainSelected: true,
        striped: true,
        cache: false,
        pagination: true,
        paginationLoop: false,
        pageList: '[5,10,25,50,100]',
        escape: true,
        filterControl: true,
        filterShowClear: true,
        searchTimeOut: 1000
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
                    axios.post('/department/api/add', params)
                        .then(function (response) {
                            if (response.data.code == TF.STATUS_CODE.SUCCESS) {
                                layer.msg(response.data.message);
                                setTimeout(function () {
                                    $("#addDepartment").dialog("close");
                                    $table.bootstrapTable("refresh");
                                    load_departmentTree();

                                }, 1000)
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
                    axios.post('/department/api/edit', params)
                        .then(function (response) {
                            if (response.data.code == TF.STATUS_CODE.SUCCESS) {
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
                    return String(app.OauthDepartment.name).length >= 0
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


    $(window).resize(function () {
        $table.bootstrapTable('resetView', {
            height: getHeight()
        });
    })

    //监听添加按钮点击事件
    $("#add-department").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("DepartmentTree");
        var nodes = treeObj.getCheckedNodes(true);
        if (nodes.length == 0) {
            TF.show_error_message("错误选择提示", "请选择部门以添加子部门")
        } else {
            app.OauthDepartment.parentId = nodes[0].id;
            app.OauthDepartment.name = '';
            app.OauthDepartment.remark = '';
            $("#addDepartment").dialog("open");

        }
    })

    //监听编辑按钮点击事件
    $("#edit-department").click(function () {
        var editUsers = $table.bootstrapTable('getSelections');
        if (editUsers.length != 1) {
            TF.show_error_message("错误选择提示", "请选择部门以供编辑信息")
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
                $("#edit").trigger("click");

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
            content: 'department/tree'
        })
    })


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
        async: {
            enable: true,
            url: "/department/api/selectDepartment",
            autoParam: ["id"]
        },
        view: {
            selectedMulti: false,
        },
        callback: {
            onClick: function (event, treeId, treeNode) {
                var $table = $("#table");
                var opt = {
                    url: "/department/api/list",
                    silent: true,
                    query: {
                        parentId: treeNode.id,
                        name: $("input[name=name]").val()
                    }
                };
                $table.bootstrapTable('refresh', opt);
            }
        }
    };
    $.get("/department/api/selectDepartment?id=0", function (json) {
        $.fn.zTree.init($("#DepartmentTree"), settings, json.data)
    })

};

function search() {
    var opt = {
        url: "/department/api/list",
        silent: true,
        query: {
            parentId: $.fn.zTree.getZTreeObj("DepartmentTree") !== null ? $.fn.zTree.getZTreeObj("DepartmentTree").getSelectedNodes()[0].id : 0,
            name: $("input.bootstrap-table-filter-control-name").val(),
            enabled: $("#enabledSelector option:selected").val()
        }
    }
    $("#table").bootstrapTable('refresh', opt);
}

//获取高度
function getHeight() {
    return $(window).height() - $('header').outerHeight(true)
        - $('div.page-footer').outerHeight(true)
        - $('#ribbon').outerHeight(true)
        - 25
}

/**
 * 格式化是否可用一列显示方式
 * @param val
 */
function enabledFormatter(val) {
    return val ? "<label class='label label-success'>可用</label>" : "<label class='label label-danger'>不可用</label>";
}

/**
 * 格式化上级部门显示方式
 * @param val
 */
function parentNameFormatter(val) {
    return val === null || val === "-" ? "根节点" : val;
}

/**
 * 格式化日期显示方式
 * @param date
 */
function date_formatter(date) {
    return date.year + "-" + date.monthValue + "-" + date.dayOfMonth + " " + date.hour + ":" + date.minute + ":" + date.second;
}

function getParentIdOnSort() {
    if ($.fn.zTree.getZTreeObj("DepartmentTree") !== null) {
        if ($.fn.zTree.getZTreeObj("DepartmentTree").getSelectedNodes().length > 0)
            return $.fn.zTree.getZTreeObj("DepartmentTree").getSelectedNodes()[0].id
        else return 0
    }
    return 0
}

// load related plugins

loadScript("/static/js/libs/vue/axios.min.js", function () {
    loadScript("/static/js/libs/vue/vuerify.min.js", function () {
        loadScript("/static/js/libs/vue/url-search-params.min.js", page_function())
    })
})