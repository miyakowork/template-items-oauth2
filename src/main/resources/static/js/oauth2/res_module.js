pageSetUp();

var resModule = new Vue({
    el: "#res-module",
    computed: {
        $table: function () {
            return $("#resModule-table");
        }
    },
    data: {
        showDel: true,
        tableOptions: {
            url: '/oauth2/resModule/api/list',
            toolbar: '#resModule-toolbar',
            queryParams: function (params) {
                return {
                    limit: params.limit,
                    offset: params.offset,
                    order: params.order,
                    sort: params.sort,
                    name: $(".bootstrap-table-filter-control-name").val(),
                    systemCode: $(".bootstrap-table-filter-control-systemModuleName").val(),
                    selectEnabled: $(".bootstrap-table-filter-control-enabled").val()
                };
            },
            filterControl: true,
            columns: [
                {checkbox: true},
                {field: "id", sortable: true, width: 100, title: "ID", align: "center", visible: false},
                {
                    field: "name",
                    sortable: true,
                    title: "资源模块名称",
                    filterControl: "input",
                    filterControlPlaceholder: "输入名称",
                    align: "center"
                },
                {
                    field: "systemModuleName",
                    sortName: "system_code",
                    sortable: true,
                    filterControl: "select",
                    filterData: "url:/oauth2/systemModule/select",
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
            remark: '',
            systemCode: {
                selected: '',
                options: []
            }
        },
        default: {addSystemModuleCode: ''},
        functions: {
            add: function () {
                resModule.$vuerify.clear();
                Global.resetObject(resModule.model);
                resModule.model.systemCode.selected = resModule.default.addSystemModuleCode;
                $('#add_res_module_dialog').dialog('open');
            },
            edit: function () {
                resModule.$vuerify.clear();
                if (resModule.$table.bootstrapTable('getSelections').length > 1) {
                    Global.show_error_msg("只能选择一条信息进行编辑")
                } else if (resModule.$table.bootstrapTable('getSelections').length < 1) {
                    Global.show_error_msg("请选择您想要编辑的信息")
                } else {
                    var $editResModule = resModule.$table.bootstrapTable('getSelections')[0];       //获取选中的对象
                    //把获取到的对象赋值给当前页面上的元素
                    resModule.model.id = $editResModule.id;
                    resModule.model.name = $editResModule.name;
                    resModule.model.enabled = $editResModule.enabled;
                    resModule.model.orderIndex = $editResModule.orderIndex;
                    resModule.model.remark = $editResModule.remark;
                    resModule.model.systemCode.selected = $editResModule.systemCode;
                    $('#edit_res_module_dialog').dialog('open');
                }
            },
            del: function () {
                var selectItems = resModule.$table.bootstrapTable('getSelections');
                if (selectItems.length === 0) {
                    Global.show_error_message("错误选择", "请至少选择一项进行删除")
                } else {
                    Global.deleteItems(resModule.$table, "/oauth2/resModule/api/delete", "name");
                }
            }
        }
    },
    methods: {
        handleSubmit_add: function () {
            this.$vuerify.clear()//清空之前的验证结果信息
            var check_result = this.$vuerify.check()// 手动触发校验所有数据

            if (!check_result) {
                Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
            } else {
                var params = new URLSearchParams();
                var datas = resModule.model
                for (var data in datas) {
                    if (data === "systemCode")
                        continue
                    params.append(data, datas[data])
                }
                params.append('systemCode', resModule.model.systemCode.selected);
                axios.post('/oauth2/resModule/api/add', params)
                    .then(function (response) {
                        if (response.data.code === Global.status_code.success) {
                            layer.msg(response.data.message);
                            $('#add_res_module_dialog').dialog('close');
                            resModule.$table.bootstrapTable('refresh');
                        } else {
                            Global.show_error_msg(response.data.message)
                        }
                    })
                    .catch(function (error) {
                        Global.handleAxiosError(error)
                    });
            }
            return false;
        },
        handleSubmit_edit: function () {
            this.$vuerify.clear()//清空之前的验证结果信息
            var check_result = this.$vuerify.check()// 手动触发校验所有数据

            if (!check_result) {
                Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
            } else {
                var params = new URLSearchParams();
                var datas = resModule.model
                for (var data in datas) {
                    if (data === "systemCode")
                        continue
                    params.append(data, datas[data])
                }
                params.append("systemCode", resModule.model.systemCode.selected)
                axios.post('/oauth2/resModule/api/edit', params)
                    .then(function (response) {
                        if (response.data.code === Global.status_code.success) {
                            layer.msg(response.data.message);
                            $('#edit_res_module_dialog').dialog('close');
                            resModule.$table.bootstrapTable('refresh');
                        } else {
                            Global.show_error_msg(response.data.message)
                        }
                    })
                    .catch(function (error) {
                        Global.handleAxiosError(error)
                    });
            }
            return false;
        }
    },
    vuerify: {
        name: {
            test: function () {
                return String(resModule.model.name).length >= 2
            },
            message: '名字长度不能为空且不能过短'
        },
        enabled: {
            test: function () {
                return resModule.model.enabled !== null;
            },
            message: "必须二选一"
        },
        systemCode: {
            test: function () {
                return String(resModule.model.systemCode.selected).length > 0
            },
            message: "系统代码不能为空"
        },
        orderIndex: {
            test: function () {
                return !isNaN(resModule.model.orderIndex)
            },
            message: '不能为空且必须为数字'
        }
    }
});

// page_function
var page_function = function () {
    //添加对话框
    Global.smartDialog({
        id: "add_res_module_dialog",
        title: "添加资源模块",
        confirm: function () {
            $("#resModuleAdd").trigger("click");
        }
    });
    //编辑对话框
    Global.smartDialog({
        id: "edit_res_module_dialog",
        title: "编辑资源模块",
        confirm: function () {
            $("#resModuleEdit").trigger("click");
        }
    });

    getSelectContent();
};


//获取下拉框内容
function getSelectContent() {
    axios.post('/oauth2/systemModule/api/find/modules/enabled', {})
        .then(function (response) {
            if (response.data.length > 0) {
                resModule.model.systemCode = response.data;
                var $selectSystemCode = resModule.model.systemCode;
                resModule.model.systemCode.selected = $selectSystemCode[0].systemCode;
                resModule.default.addSystemModuleCode = $selectSystemCode[0].systemCode;
                for (var i = 0; i < $selectSystemCode.length; i++) {
                    $('#resource-module-selector-add,#resource-module-selector-edit').append("<option value=" + $selectSystemCode[i].systemCode + ">" + $selectSystemCode[i].name + "</option>");
                }
            }
        })
        .catch(function (error) {
            Global.handleAxiosError(error)
        });
}

// load related plugins
page_function();
