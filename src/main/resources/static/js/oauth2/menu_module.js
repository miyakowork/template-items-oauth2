pageSetUp();

var menuModule = new Vue({
    el: "#menu-module",
    computed: {
        $table: function () {
            return $("#menu-module-table");
        }
    },
    data: {
        showDel: true,
        tableOptions: {
            url: "/oauth2/menuModule/api/list",
            toolbar: '#menu-module-toolbar',
            queryParams: function (params) {
                return {
                    limit: params.limit,
                    offset: params.offset,
                    order: params.order,
                    sort: params.sort,
                    name: $("input.bootstrap-table-filter-control-name").val(),
                    systemCodeName: $(".bootstrap-table-filter-control-systemCode").val(),
                    enabled: $(".bootstrap-table-filter-control-enabled").val()
                };
            },
            filterControl: true,
            columns: [
                {checkbox: true},
                {field: "id", visible: false, width: 150, title: "菜单ID", align: "center"},
                {
                    field: "name",
                    width: 150,
                    title: "菜单模块名称",
                    filterControl: "input",
                    filterControlPlaceholder: "输入菜单模块名",
                    align: "center"
                },
                {
                    field: "systemCode",
                    sortName: "system_code",
                    title: "所属系统模块编码",
                    filterControl: "select",
                    filterData: "url:/oauth2/systemModule/select",
                    align: "center"
                },
                {field: "iconLarger", title: "菜单模块大图标", align: "center"},
                {field: "iconMini", title: "菜单模块字体图标", align: "center", formatter: "iconMiniFormatter"},
                {
                    field: "enabled",
                    formatter: "enabledFormatter",
                    title: "是否可用",
                    filterControl: "select",
                    filterData: "url:/oauth2/common/select",
                    align: "center"
                },
                {
                    field: "updateUsername",
                    visible: false,
                    title: "更新人",
                    align: "center"
                },
                {
                    field: "updateDate",
                    visible: false,
                    formatter: "date_formatter",
                    title: "更新时间",
                    align: "center"
                },
                {
                    field: "createUsername",
                    visible: false,
                    title: "创建人",
                    align: "center"
                },
                {
                    field: "createDate",
                    visible: false,
                    formatter: "date_formatter",
                    title: "创建时间",
                    align: "center"
                },
                {field: "orderIndex", sortName: "order_index", title: "排序", align: "center"},
                {field: "remark", title: "备注", align: "center"}
            ]
        },
        model: {
            id: '',
            name: '',
            systemCode: {
                selected: '',
                options: []
            },
            enabled: true,
            orderIndex: 0,
            remark: '',
            iconLarger: '',
            iconMini: ''
        },
        default: {
            addSystemModuleCode: ''
        },
        functions: {
            add: function () {
                menuModule.$vuerify.clear();
                Global.resetObject(menuModule.model);
                menuModule.model.systemCode.selected = menuModule.default.addSystemModuleCode;
                $("#add_menumodule_dialog").dialog('open');
            },
            edit: function () {
                menuModule.$vuerify.clear();
                var selectItems = menuModule.$table.bootstrapTable('getSelections');
                if (selectItems.length === 1) {
                    menuModule.model.id = selectItems[0].id;
                    menuModule.model.systemCode.selected = selectItems[0].systemCode;
                    menuModule.model.name = selectItems[0].name;
                    menuModule.model.enabled = selectItems[0].enabled;
                    menuModule.model.orderIndex = selectItems[0].orderIndex;
                    menuModule.model.remark = selectItems[0].remark;
                    menuModule.model.systemCode.selected = selectItems[0].systemCode;
                    menuModule.model.iconLarger = selectItems[0].iconLarger;
                    menuModule.model.iconMini = selectItems[0].iconMini;
                    $('#edit_menumodule_dialog').dialog('open');
                } else {
                    Global.show_error_message("错误选择", "请选择一条记录进行编辑")
                }
            },
            del: function () {
                var selectItems = menuModule.$table.bootstrapTable('getSelections');
                if (selectItems.length === 0) {
                    Global.show_error_message("错误选择", "请至少选择一项进行禁用操作")
                } else {
                    Global.deleteItems(menuModule.$table, "/oauth2/menuModule/api/delete", "name");
                }
            }
        }
    },
    methods: {
        submit_add: function () {
            this.$vuerify.clear();//清空之前的验证结果信息
            var check_result = this.$vuerify.check();// 手动触发校验所有数据
            if (!check_result) {
                Global.show_error_msg("请修正表单错误信息之后再提交");
            } else {
                var params = new URLSearchParams();
                var datas = menuModule.model;
                for (var data in datas) {
                    if (data === "systemCode")
                        continue;
                    params.append(data, datas[data])
                }
                params.append("systemCode", menuModule.model.systemCode.selected);

                axios.post('/oauth2/menuModule/api/add', params)
                    .then(function (response) {
                        if (response.data.code === Global.status_code.success) {
                            layer.msg(response.data.message);
                            $("#add_menumodule_dialog").dialog("close");
                            menuModule.$table.bootstrapTable("refresh");
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
        submit_edit: function () {
            this.$vuerify.clear();//清空之前的验证结果信息
            var check_result = this.$vuerify.check();// 手动触发校验所有数据

            if (!check_result) {
                Global.show_error_msg("请修正表单错误信息之后再提交");
            } else {
                var params = new URLSearchParams();
                var datas = menuModule.model;
                for (var data in datas) {
                    if (data === "systemCode") {
                        continue;
                    }
                    params.append(data, datas[data])
                }
                params.append("systemCode", datas.systemCode.selected)
                axios.post(' /oauth2/menuModule/api/edit', params)
                    .then(function (response) {
                        if (response.data.code === Global.status_code.success) {
                            layer.msg(response.data.message);
                            $("#edit_menumodule_dialog").dialog("close");
                            menuModule.$table.bootstrapTable('refresh');
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
                return String(menuModule.model.name).length > 0
            },
            message: '名字长度不能为空'
        },
        enabled: {
            test: function () {
                return menuModule.model.enabled !== null;
            },
            message: "必须二选一"
        },
        systemCode: {
            test: function () {
                return String(menuModule.model.systemCode.selected).length > 0
            },
            message: "系统代码不能为空"
        },
        orderIndex: {
            test: function () {
                return !isNaN(menuModule.model.orderIndex) && String(menuModule.model.orderIndex).length > 0
            },
            message: '不能为空且必须为数字'
        }
    }
});

// page_function
var page_function = function () {

    Global.smartDialog({
        id: "add_menumodule_dialog",
        title: "添加菜单模块",
        confirm: function () {
            $("#menuModuleAdd").trigger("click");
        }
    });

    Global.smartDialog({
        id: "edit_menumodule_dialog",
        title: "编辑菜单模块",
        confirm: function () {
            $("#menuModuleEdit").trigger("click");
        }
    });

    getSelectContent($('#menumodule-selector-add,#menumodule-selector-edit'));
};


//列中显示字体图标
function iconMiniFormatter(value) {
    if (value === null || value === "")
        return "-";
    return "<i class='" + value + "'></i>";
}

//获取下拉框内容
function getSelectContent($selector) {
    axios.post('/oauth2/systemModule/api/find/modules/enabled', {})
        .then(function (response) {
            if (response.data.length > 0) {
                menuModule.model.systemCode = response.data;
                var $selectSystemCode = menuModule.model.systemCode;
                menuModule.model.systemCode.selected = $selectSystemCode[0].systemCode;//默认给下拉菜单选中第一个
                menuModule.default.addSystemModuleCode = $selectSystemCode[0].systemCode;
                for (var i = 0; i < $selectSystemCode.length; i++) {
                    $selector.append("<option value=" + $selectSystemCode[i].systemCode + ">" + $selectSystemCode[i].name + "</option>");
                }
            }
        })
        .catch(function (error) {
            Global.handleAxiosError(error);
        });
}

// load related plugins
page_function();
