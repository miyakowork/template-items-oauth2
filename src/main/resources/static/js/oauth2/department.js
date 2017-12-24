var department;
var tableColumns = [
    {checkbox: true, field: "itemChecks"},
    {field: "id", width: 150, title: "ID", align: "center", visible: false},
    {
        field: "name",
        sortable: true,
        title: "部门名称",
        filterControl: "input",
        filterControlPlaceholder: "输入部门名称",
        align: "center"
    },
    {
        field: "parentName",
        sortName: "parent_name",
        sortable: true,
        formatter: "parentNameFormatter",
        title: "上级部门",
        align: "center"
    },
    {field: "parentId", visible: false, title: "上级部门ID", align: "center"},
    {
        field: "enabled",
        title: "是否可用",
        formatter: "enabledFormatter",
        filterControl: "select",
        filterData: "url:/oauth2/common/select",
        align: "center"
    },
    {
        field: "orderIndex",
        sortName: "order_index",
        sortable: true,
        title: "排序",
        visible: false,
        align: "center"
    },
    {
        field: "updateDate",
        sortName: "update_date",
        sortable: true,
        title: "修改时间",
        visible: false,
        formatter: "date_formatter",
        align: "center"
    },
    {
        field: "createDate",
        sortName: "create_date",
        sortable: true,
        formatter: "date_formatter",
        title: "创建日期",
        visible: false,
        align: "center"
    },
    {
        field: "updateName",
        title: "修改人",
        visible: false,
        align: "center"
    },
    {
        field: "createName",
        title: "创建人",
        visible: false,
        align: "center"
    }, {
        field: "remark",
        sortable: true,
        title: "备注",
        align: "center"
    }
];

// page_function
var page_function = function () {

    department = new Vue({
        el: "#department",
        computed: {
            $table: function () {
                return $("#department-table");
            }
        },
        data: {
            showDel: false,
            tipsIndex: '',//左侧树那个重置按钮的提示弹出层的index
            tableOptions: {
                url: '/oauth2/department/api/list',
                toolbar: '#department-toolbar',
                queryParams: function (params) {
                    return {
                        limit: params.limit,
                        offset: params.offset,
                        order: params.order,
                        sort: params.sort,
                        parentId: getParentIdOnSort(),
                        name: $("input.bootstrap-table-filter-control-name").val(),
                        enabled: $(".bootstrap-table-filter-control-enabled").val()
                    };
                },
                filterControl: true,
                columns: tableColumns
            },
            model: {
                id: '',
                name: '',
                parentId: null,
                parentName: null,
                enabled: true,
                orderIndex: 0,
                remark: ''
            },
            functions: {
                add: function () {
                    department.$vuerify.clear();
                    Global.resetObject(department.model);

                    var treeObj = $.fn.zTree.getZTreeObj("DepartmentTree");
                    var nodes = treeObj.getCheckedNodes(true);
                    if (nodes.length === 0) {
                        department.model.parentId = 0;
                        department.model.parentName = "根节点";
                        layer.confirm('即将添加一级部门节点！<br/>若要添加其它级请在左侧选择上级部门节点！', function (index) {
                            layer.close(index);
                            $("#addDepartment").dialog("open");
                        });
                    } else {
                        department.model.parentId = nodes[0].id;
                        department.model.parentName = nodes[0].name;
                        $("#addDepartment").dialog("open");
                    }
                },
                edit: function () {
                    department.$vuerify.clear();
                    var editDept = department.$table.bootstrapTable('getSelections');
                    if (editDept.length !== 1) {
                        Global.show_error_message("错误选择提示", "请选择一个部门来予以修改")
                    } else {
                        department.model.id = editDept[0].id;
                        department.model.name = editDept[0].name;
                        department.model.parentId = editDept[0].parentId;
                        department.model.parentName = editDept[0].parentId === 0 ? "部门根节点" : editDept[0].parentName;
                        department.model.enabled = editDept[0].enabled;
                        department.model.orderIndex = editDept[0].orderIndex;
                        department.model.remark = editDept[0].remark;
                        $("#editDepartment").dialog("open");
                    }
                },
                fetch: function () {
                    layer.open({
                        type: 2,
                        area: ['300px', '400px'],
                        title: ['选择上级部门(双击选定)', 'text-align:center;'],
                        fixed: true,
                        resize: false,
                        offset: '200px',
                        content: '/oauth2/department/tree'
                    })
                }
            }
        },
        methods: {
            //添加界面提交操作
            handleAddSubmit: function () {
                this.$vuerify.clear()//清空之前的验证结果信息
                var check_result = this.$vuerify.check()// 手动触发校验所有数据

                if (!check_result) {
                    Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var departments = department.model;
                    for (var data in departments) {
                        params.append(data, departments[data])
                    }
                    axios.post('/oauth2/department/api/add', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $("#addDepartment").dialog("close");
                                department.$table.bootstrapTable("refresh");
                                loadDepartmentTree();
                            } else {
                                Global.show_error_msg(response.data.message)
                            }
                        })
                        .catch(function (error) {
                            Global.handleAxiosError(error);
                        });
                }

            },

            //编辑界面提交操作
            handleEditSubmit: function () {
                this.$vuerify.clear();//清空之前的验证结果信息
                var check_result = this.$vuerify.check();// 手动触发校验所有数据

                if (!check_result) {
                    Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    params.append("id", department.model.id);
                    params.append("name", department.model.name);
                    params.append("parentId", department.model.parentId);
                    params.append("enabled", department.model.enabled);
                    params.append("orderIndex", department.model.orderIndex);
                    params.append("remark", department.model.remark);
                    axios.post('/oauth2/department/api/edit', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $("#editDepartment").dialog("close");
                                Global.resetObject(department.model, {bool: true});
                                loadDepartmentTree();
                                department.$table.bootstrapTable("refresh");
                            } else {
                                Global.show_error_msg(response.data.message)
                            }
                        })
                }
            },

            //取消勾选部门树，并刷新树和表格
            resetCheck: function () {
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
                Global.reInitTable(department.$table, {
                    url: "/oauth2/department/api/list",
                    toolbar: '#department-toolbar',
                    queryParams: function (params) {
                        return {
                            limit: params.limit,
                            offset: params.offset,
                            order: params.order,
                            sort: params.sort,
                            parentId: getParentIdOnSort(),
                            name: $("input.bootstrap-table-filter-control-name").val(),
                            enabled: $(".bootstrap-table-filter-control-enabled").val()
                        };
                    },
                    filterControl: true,
                    checkboxHeader: true,
                    columns: tableColumns
                })
            },

            showTips: function ($event) {
                department.tipsIndex = layer.tips($($event.target).attr("title"), $event.target);
            },
            hideTips: function ($event) {
                layer.close(department.tipsIndex);
            }
        },
        vuerify: {
            name: {
                test: function () {
                    return String(department.model.name).length > 0;
                },
                message: '部门名称不能为空'
            },
            parentId: {
                test: function () {
                    return department.model.parentId !== null;
                },
                message: '上级部门ID不能为空'
            },
            parentName: {
                test: function () {
                    return department.model.parentName !== null;
                },
                message: '上级部门名称不能为空'
            },
            orderIndex: {
                test: function () {
                    return String(department.model.orderIndex).length > 0 && !isNaN(department.model.orderIndex);
                },
                message: '排序索引不能为空'
            },
            enabled: {
                test: function () {
                    return department.model.enabled !== null;
                },
                message: "必须二选一"
            }
        }
    });
    loadDepartmentTree();

//添加弹出框操作
    Global.smartDialog({
        id: "addDepartment",
        title: "添加新部门",
        confirm: function () {
            $("#departmentAdd").trigger("click");
        }
    });

//编辑弹出框操作
    Global.smartDialog({
        id: "editDepartment",
        title: "编辑部门信息",
        confirm: function () {
            $("#departmentEdit").trigger("click");
        }
    });

};

//加载左侧树结构
function loadDepartmentTree() {
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
            selectedMulti: false
        },
        callback: {
            onClick: function (event, treeId, treeNode) {
                var treeObj = $.fn.zTree.getZTreeObj("DepartmentTree");
                treeObj.checkNode(treeNode, true, false);
                var opt = {
                    url: "/oauth2/department/api/list",
                    silent: true,
                    query: {
                        parentId: treeNode.id,
                        name: $("input.bootstrap-table-filter-control-name").val()
                    }
                };
                department.$table.bootstrapTable('refresh', opt);
            }
        }
    };
    $.get("/oauth2/department/api/selectDepartment", function (json) {
        $.fn.zTree.init($("#DepartmentTree"), settings, json)
    })

}

pageSetUp();

//格式化上级部门显示方式
function parentNameFormatter(val) {
    return val === null || val === "-" ? "部门根节点" : val;
}

//获取左侧的部门树上选中的部门，当做要添加部门的父id
function getParentIdOnSort() {
    if ($.fn.zTree.getZTreeObj("DepartmentTree") !== null) {
        if ($.fn.zTree.getZTreeObj("DepartmentTree").getSelectedNodes().length > 0)
            return $.fn.zTree.getZTreeObj("DepartmentTree").getSelectedNodes()[0].id;
        else return 0
    }
    return 0
}

// load related plugins
page_function();