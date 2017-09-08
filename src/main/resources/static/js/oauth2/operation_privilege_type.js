pageSetUp();

var operationPrivilegeType = new Vue({
    el: "#operation-privilege-type",
    computed: {
        $table: function () {
            return $("#operationPrivilegeType-table");
        }
    },
    data: {
        showDel: false,
        tableOptions: {
            url: '/oauth2/operationPrivilegeType/api/list',
            toolbar: '#operationPrivilegeType-toolbar',
            queryParams: function (params) {
                return {
                    limit: params.limit,
                    offset: params.offset,
                    order: params.order,
                    sort: params.sort,
                    name: $("input.bootstrap-table-filter-control-name").val(),
                    enabled: $(".bootstrap-table-filter-control-enabled").val()
                };
            },
            filterControl: true,
            columns: [
                {checkbox: true},
                {field: "id", sortable: true, width: 200, title: "ID", align: "center"},
                {
                    field: "name",
                    sortable: true,
                    title: "名称",
                    filterControl: "input",
                    filterControlPlaceholder: "输入名称",
                    align: "center"
                },

                {
                    field: "enabled",
                    title: "是否可用",
                    formatter: "enabledFormatter",
                    filterControl: "select",
                    filterData: "url:/oauth2/common/select",
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
                    field: "updateUserName",
                    title: "修改人",
                    visible: false,
                    align: "center"
                },
                {
                    field: "createUserName",
                    title: "创建人",
                    visible: false,
                    align: "center"
                },
                {
                    field: "orderIndex",
                    sortName: "order_index",
                    sortable: true,
                    title: "排序",
                    visible: false,
                    align: "center"
                }, {
                    field: "remark",
                    sortable: true,
                    title: "备注",
                    align: "center"
                }
            ]
        },
        model: {
            id: '',
            name: '',
            enabled: true,
            orderIndex: 0,
            remark: ''
        },
        functions: {
            add: function () {
                operationPrivilegeType.$vuerify.clear();
                Global.resetObject(operationPrivilegeType.model);
                $('#opt_privilege_add_dialog').dialog('open');
            },
            edit: function () {
                operationPrivilegeType.$vuerify.clear();
                if (operationPrivilegeType.$table.bootstrapTable('getSelections').length > 1) {
                    Global.show_error_msg("只能选择一条信息进行编辑")
                } else if (operationPrivilegeType.$table.bootstrapTable('getSelections').length < 1) {
                    Global.show_error_msg("请选择您想要编辑的信息")
                }
                else {
                    var selectItems = operationPrivilegeType.$table.bootstrapTable('getSelections');
                    var selectItem = selectItems[0];
                    operationPrivilegeType.model.id = selectItem.id;
                    operationPrivilegeType.model.name = selectItem.name;
                    operationPrivilegeType.model.enabled = selectItem.enabled;
                    operationPrivilegeType.model.orderIndex = selectItem.orderIndex;
                    operationPrivilegeType.model.remark = selectItem.remark;
                    $('#opt_privilege_edit_dialog').dialog('open');
                    return false;
                }
            }
        }
    },
    methods: {
        handleSubmit_add: function () {
            this.$vuerify.clear();//清空之前的验证结果信息
            var check_result = this.$vuerify.check();// 手动触发校验所有数据

            if (!check_result) {
                Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
            } else {
                var params = new URLSearchParams();
                var datas = operationPrivilegeType.model;
                for (var data in datas) {
                    params.append(data, datas[data])
                }
                axios.post('/oauth2/operationPrivilegeType/api/add', params)
                    .then(function (response) {
                        if (response.data.code === Global.status_code.success) {
                            layer.msg(response.data.message);
                            $("#opt_privilege_add_dialog").dialog("close");
                            operationPrivilegeType.$table.bootstrapTable('refresh');
                        } else {
                            Global.show_error_msg(response.data.message)
                        }
                    })
                    .catch(function (error) {
                        Global.handleAxiosError(error);
                    });
            }
            return false;
        },
        handleSubmit_edit: function () {
            this.$vuerify.clear();//清空之前的验证结果信息
            var check_result = this.$vuerify.check();// 手动触发校验所有数据

            if (!check_result) {
                Global.show_error_msg("请修正表单错误信息之后再提交");
            } else {
                var params = new URLSearchParams();
                var datas = operationPrivilegeType.model;
                for (var data in datas) {
                    params.append(data, datas[data])
                }
                axios.post('/oauth2/operationPrivilegeType/api/edit', params)
                    .then(function (response) {
                        if (response.data.code === Global.status_code.success) {
                            layer.msg(response.data.message);
                            $("#opt_privilege_edit_dialog").dialog("close");
                            operationPrivilegeType.$table.bootstrapTable('refresh');
                        } else {
                            Global.show_error_msg(response.data.message)
                        }
                    })
                    .catch(function (error) {
                        Global.handleAxiosError(error);
                    });
            }
            return false;
        }
    },
    vuerify: {
        name: {
            test: function () {
                return String(operationPrivilegeType.model.name).length > 0
            },
            message: '名字长度不能为空'
        },
        orderIndex: {
            test: function () {
                return !isNaN(operationPrivilegeType.model.orderIndex);
            },
            message: '不能为空且必须为数字'
        },
        enabled: {
            test: function () {
                return operationPrivilegeType.model.enabled !== null;
            },
            message: "必须二选一"
        }
    }
});

// page_function
var page_function = function () {

    //添加面板属性设置
    Global.smartDialog({
        id: "opt_privilege_add_dialog",
        title: "添加操作级权限类型模块",
        confirm: function () {
            $("#doOptAdd").trigger("click");
        }
    });

    //编辑面板属性设置
    Global.smartDialog({
        id: "opt_privilege_edit_dialog",
        title: "编辑操作级权限类型",
        confirm: function () {
            $("#doOptEdit").trigger("click");
        }
    });


};

// load related plugins
page_function();