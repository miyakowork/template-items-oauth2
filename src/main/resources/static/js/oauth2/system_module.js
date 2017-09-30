pageSetUp();

var systemModule = new Vue({
    el: "#system-module",
    computed: {
        $table: function () {
            return $("#resModule-table");
        }
    },
    data: {
        showDel: true,
        tableOptions: {
            url: "/oauth2/systemModule/api/list",
            toolbar: '#systemModule-toolbar',
            filterControl: true,
            queryParams: function (params) {
                return {
                    limit: params.limit,
                    offset: params.offset,
                    order: params.order,
                    sort: params.sort,
                    name: $("input.bootstrap-table-filter-control-name").val(),
                    systemCode: $("input.bootstrap-table-filter-control-systemCode").val(),
                    enabled: $("select.bootstrap-table-filter-control-enabled").val()
                };
            },
            columns: [
                {checkbox: true},
                {field: "id", sortable: true, width: 100, title: "ID", align: "center", visible: false},
                {
                    field: "name",
                    sortable: true,
                    title: "系统名称",
                    filterControl: "input",
                    filterControlPlaceholder: "输入系统名称",
                    align: "center"
                },
                {
                    field: "indexUrl",
                    title: "系统首页地址",
                    align: "center"
                },
                {
                    field: "systemCode",
                    sortName: "system_code",
                    sortable: true,
                    filterControl: "input",
                    filterControlPlaceholder: "输入系统代码",
                    title: "系统代码",
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
                    title: "备注",
                    align: "center"
                }
            ]
        },
        model: {
            id: '',
            name: '',
            indexUrl: '',
            systemCode: '',
            enabled: false,
            orderIndex: 0,
            remark: ''
        },
        functions: {
            add: function () {
                systemModule.$vuerify.clear();
                Global.resetObject(systemModule.model);
                $('#addSystemModule').dialog('open');
            },
            edit: function () {
                systemModule.$vuerify.clear();
                if (systemModule.$table.bootstrapTable('getSelections').length > 1) {
                    Global.show_error_msg("只能选择一条信息进行编辑")
                } else if (systemModule.$table.bootstrapTable('getSelections').length < 1) {
                    Global.show_error_msg("请选择您想要编辑的信息")
                }
                else {
                    var selectItems = systemModule.$table.bootstrapTable('getSelections');
                    var selectItem = selectItems[0];
                    systemModule.model.id = selectItem.id;
                    systemModule.model.name = selectItem.name;
                    systemModule.model.indexUrl = selectItem.indexUrl;
                    systemModule.model.systemCode = selectItem.systemCode;
                    systemModule.model.enabled = selectItem.enabled;
                    systemModule.model.orderIndex = selectItem.orderIndex;
                    systemModule.model.remark = selectItem.remark;
                    $('#editSystemModule').dialog('open');
                }
            },
            del: function () {
                var $selectedEdit = systemModule.$table.bootstrapTable("getSelections");
                if ($selectedEdit === null || $selectedEdit.length === 0) {
                    Global.show_error_msg("请选择删除对象")
                }
                else {
                    Global.deleteItems(systemModule.$table, "/oauth2/systemModule/api/delete", "name");
                }
            }
        }
    },
    methods: {
        handleSubmit_add: function () {
            this.$vuerify.clear();//清空之前的验证结果信息
            var check_result = this.$vuerify.check();// 手动触发校验所有数据
            if (!check_result) {
                Global.show_error_msg("请修正表单错误信息之后再提交")
            } else {
                var params = new URLSearchParams();
                var datas = systemModule.model
                for (var data in datas) {
                    params.append(data, datas[data])
                }
                axios.post('/oauth2/systemModule/api/add', params)
                    .then(function (response) {
                        if (response.data.code === Global.status_code.success) {
                            layer.msg(response.data.message);
                            $("#addSystemModule").dialog("close");
                            systemModule.$table.bootstrapTable('refresh');
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
                Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
            } else {
                var params = new URLSearchParams();
                var datas = systemModule.model;
                for (var data in datas) {
                    params.append(data, datas[data])
                }
                axios.post('/oauth2/systemModule/api/edit', params)
                    .then(function (response) {
                        if (response.data.code === Global.status_code.success) {
                            layer.msg(response.data.message);
                            $("#editSystemModule").dialog("close");
                            systemModule.$table.bootstrapTable('refresh');
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
                return String(systemModule.model.name).length > 0
            },
            message: '名字长度不能为空'
        },
        orderIndex: {
            test: function () {
                return !isNaN(systemModule.model.orderIndex)
            },
            message: '不能为空且必须为数字'
        },
        systemCode: {
            test: function () {
                return String(systemModule.model.systemCode).length > 3;
            },
            message: '不能为空且不能过短'
        },
        enabled: {
            test: function () {
                return systemModule.model.enabled !== null;
            },
            message: "必须二选一"
        },
        indexUrl: {
            test: function () {
                return systemModule.model.indexUrl.length !== 0;
            },
            message: "系统首页不能为空"
        }
    }
});

// page_function
var page_function = function () {

    //添加面板属性设置
    Global.smartDialog({
        id: "addSystemModule",
        title: "添加系统模块",
        confirm: function () {
            $("#sa").trigger("click");
        }
    });

    //编辑面板属性设置
    Global.smartDialog({
        id: "editSystemModule",
        title: "编辑系统模块",
        confirm: function () {
            $("#sa_edit").trigger("click");
        }
    });

};

// load related plugins
page_function();
