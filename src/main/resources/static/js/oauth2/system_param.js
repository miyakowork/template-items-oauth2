pageSetUp();

var systemParam = new Vue({
    el: "#system-param",
    computed: {
        $table: function () {
            return $("#systemParam-table");
        }
    },
    data: {
        showDel: true,
        tableOptions: {
            url: "/oauth2/systemParam/api/list",
            toolbar: '#systemParam-toolbar',
            queryParams: function (params) {
                return {
                    limit: params.limit,
                    offset: params.offset,
                    order: params.order,
                    sort: params.sort,
                    name: $("input.bootstrap-table-filter-control-name").val(),
                    value: $("input.bootstrap-table-filter-control-value").val(),
                    selectEnabled: $(".bootstrap-table-filter-control-enabled").val()
                };
            },
            filterControl: true,
            columns: [
                {checkbox: true},
                {field: "id", sortable: true, width: 100, title: "ID", align: "center"},
                {
                    field: "name",
                    sortable: true,
                    title: "名称",
                    filterControl: "input",
                    filterControlPlaceholder: "输入名称",
                    align: "center"
                },
                {
                    field: "value",
                    sortable: true,
                    title: "值",
                    filterControl: "input",
                    filterControlPlaceholder: "输入值",
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
            value: '',
            enabled: true,
            orderIndex: 0,
            remark: ''
        },
        functions: {
            add: function () {
                systemParam.$vuerify.clear();
                Global.resetObject(systemParam.model);
                $('#add_sys_param_dialog').dialog('open');
            },
            edit: function () {
                systemParam.$vuerify.clear();
                //判断是否只选中一条信息
                if (systemParam.$table.bootstrapTable('getSelections').length > 1) {
                    Global.show_error_msg("只能选择一条信息进行编辑")
                } else if (systemParam.$table.bootstrapTable('getSelections').length < 1) {
                    Global.show_error_msg("请选择您想要编辑的信息")
                }
                //将选中的信息自动显示
                else {
                    //获取选中的对象
                    var $editSystemParam = systemParam.$table.bootstrapTable('getSelections')[0];
                    //把获取到的对象赋值给当前页面上的元素
                    systemParam.model.id = $editSystemParam.id;
                    systemParam.model.name = $editSystemParam.name;
                    systemParam.model.enabled = $editSystemParam.enabled;
                    systemParam.model.value = $editSystemParam.value;
                    systemParam.model.orderIndex = $editSystemParam.orderIndex;
                    systemParam.model.remark = $editSystemParam.remark;
                    $('#edit_sys_param_dialog').dialog('open');
                }
            },
            del: function () {
                var selectItems = systemParam.$table.bootstrapTable('getSelections');
                if (selectItems.length === 0) {
                    Global.show_error_msg("请至少选择一项进行删除")
                } else {
                    Global.deleteItems(systemParam.$table, "/oauth2/systemParam/api/delete", "name");
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
                var datas = systemParam.model
                for (var data in datas) {
                    params.append(data, datas[data])
                }
                axios.post('/oauth2/systemParam/api/add', params)
                    .then(function (response) {
                        if (response.data.code === Global.status_code.success) {
                            layer.msg(response.data.message);
                            $('#add_sys_param_dialog').dialog('close');
                            systemParam.$table.bootstrapTable('refresh');
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
            return false;
        },
        handleSubmit_edit: function () {
            this.$vuerify.clear();//清空之前的验证结果信息
            var check_result = this.$vuerify.check();// 手动触发校验所有数据

            if (!check_result) {
                Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
            } else {
                var params = new URLSearchParams();
                var datas = systemParam.model
                for (var data in datas) {
                    params.append(data, datas[data])
                }
                axios.post('/oauth2/systemParam/api/edit', params)
                    .then(function (response) {
                        if (response.data.code === Global.status_code.success) {
                            layer.msg(response.data.message);
                            $('#edit_sys_param_dialog').dialog('close');
                            systemParam.$table.bootstrapTable('refresh');
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
            return false;
        }
    },
    vuerify: {
        name: {
            test: function () {
                return String(systemParam.model.name).length > 0
            },
            message: '名字长度不能为空且不能过短'
        },
        value: {
            test: function () {
                return String(systemParam.model.value).length > 0
            },
            message: '值不能为空'
        },
        orderIndex: {
            test: function () {
                return !isNaN(systemParam.model.orderIndex)
            },
            message: '不能为空且必须为数字'
        },
        enabled: {
            test: function () {
                return systemParam.model.enabled !== null;
            },
            message: "必须二选一"
        }
    }

});

// page_function
var page_function = function () {

    //添加dialog
    Global.smartDialog({
        id: "add_sys_param_dialog",
        title: "添加系统参数",
        confirm: function () {
            $("#systemParamAdd").trigger("click");
        }
    });

    //编辑系统参数dialog
    Global.smartDialog({
        id: "edit_sys_param_dialog",
        title: "编辑系统参数",
        confirm: function () {
            $("#systemParamEdit").trigger("click");
        }
    });


};


page_function();
