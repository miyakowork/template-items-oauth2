pageSetUp();

var $selectedModuleMenu = $("input[name=selectedModuleMenu]");
var $table = $("#menu-table");
var app;

var page_function = function () {
    //取消勾选角色，并刷新树和表格内容
    var $roleTree = $("#refreshRoleTreeMenu");
    $roleTree.click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("roleTreeMenu");
        treeObj.cancelSelectedNode();
        var nodes = treeObj.getCheckedNodes(true);
        if (nodes.length === 0) {
            layer.msg("并没有勾选角色，取消勾选无效！");
            return;
        }
        for (var i = 0, l = nodes.length; i < l; i++) {
            treeObj.checkNode(nodes[i], false, true);
        }
    });

    var tipsIndexMenu;
    $roleTree.hover(function () {
        tipsIndexMenu = layer.tips($(this).attr("title"), '#refreshRoleTreeMenu');
    }, function () {
        layer.close(tipsIndexMenu);
    });

    //获取下拉框内容
    axios.post('/oauth2/systemModule/api/find/modules/enabled', {})
        .then(function (response) {
            if (response && response.status === 200) {
                var $selectSystemCode = response.data;
                if (response.data.length > 0) {
                    for (var i = 0; i < $selectSystemCode.length; i++) {
                        $('#select-modules-menu').append("<option value=" + $selectSystemCode[i].systemCode + ">" + $selectSystemCode[i].name + "</option>");
                    }
                    //默认选择
                    $selectedModuleMenu.val($selectSystemCode[0].systemCode);
                    app.menu.systemCode = $selectSystemCode[0].systemCode;
                    app.menu.systemModuleName = $selectSystemCode[0].name;
                } else {
                    $selectedModuleMenu.val("");
                    app.menu.systemCode = "";
                    app.menu.systemModuleName = "";
                }
            }
            //循环完select之后加载左侧角色树
            loadRoleTreeMenu();
        })
        .catch(function (error) {
            Global.handleAxiosError(error);
        });

    //监听左侧树更改模块的事件
    $("#select-modules-menu").on("change", function () {
        var treeObj = $.fn.zTree.getZTreeObj("roleTreeMenu");
        treeObj.destroy();
        app.menu.systemCode = $(this).val();
        $selectedModuleMenu.val($(this).val());
        app.menu.systemModuleName = $(this).find("option:selected").text();
        loadRoleTreeMenu();
    });

    app = new Vue({
        el: "#menu_dialog",
        data: {
            hide: {
                isUrlHidden: true,
                isOnclickHidden: true,
                isTargetHidden: true,
                isResourceIdHidden: false,
            },
            menu: {
                id: '',
                name: '',
                menuType: {
                    selected: '1',
                    options: [
                        {text: '内置权限菜单', value: '1'},
                        {text: '外部链接菜单', value: '2'},
                        {text: '脚本事件菜单', value: '3'},
                        {text: '目录级别菜单', value: '4'}
                    ]
                },
                resourceId: '',
                systemCode: '',
                systemModuleName: '',
                icon: '',
                iconLarger: '',
                href: '',
                onclick: '',
                target: '',
                roleId: '',
                roleName: '',
                menuModule: {
                    selected: "",
                    options: []
                },
                parentId: '',
                parentName: '',
                enabled: true,
                orderIndex: 0,
                remark: ''
            }
        },
        methods: {
            chooseMenuType: function (value) {
                app.menu.href = "";
                app.$vuerify.clear();
                if (value === "1") {
                    app.hide.isUrlHidden = true;
                    app.hide.isOnclickHidden = true;
                    app.hide.isTargetHidden = true;
                    app.hide.isResourceIdHidden = false;
                } else if (value === "2") {
                    app.hide.isUrlHidden = false;
                    app.hide.isOnclickHidden = true;
                    app.hide.isTargetHidden = false;
                    app.hide.isResourceIdHidden = true;
                } else if (value === "3") {
                    app.hide.isUrlHidden = true;
                    app.hide.isOnclickHidden = false;
                    app.hide.isTargetHidden = true;
                    app.hide.isResourceIdHidden = true;
                } else if (value === "4") {
                    app.hide.isUrlHidden = true;
                    app.hide.isOnclickHidden = true;
                    app.hide.isTargetHidden = true;
                    app.hide.isResourceIdHidden = true;
                    app.menu.href = "#";
                }
            },
            isHasError: function (errorMsg) {
                return Boolean(errorMsg);
            },
            handleAddMenuSubmit: function () {
                this.$vuerify.clear();//清空之前的验证结果信息
                var check_result = this.$vuerify.check();// 手动触发校验所有数据

                if (!check_result) {
                    Global.show_error_message("错误消息提示", "请修正表单错误信息之后再提交", 3000)
                } else {
                    var params = new URLSearchParams();
                    var datas = app.menu;
                    for (var data in datas) {
                        if (data === "menuType" || data === "menuModule")
                            continue;
                        params.append(data, datas[data])
                    }
                    params.append("menuType", app.menu.menuType.selected);
                    params.append("menuModuleId", app.menu.menuModule.selected);
                    axios.post('/oauth2/menu/api/add', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $("#addMenu").dialog("close");
                                $table.bootstrapTable("refresh");
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
            handleEditMenuSubmit: function () {
                this.$vuerify.clear();//清空之前的验证结果信息
                var hasError = false;
                if (app.menu.name === "") {
                    hasError = true;
                    app.errors.name = "菜单名字不能为空";
                }
                if (app.menu.orderIndex === "") {
                    hasError = true;
                    app.errors.orderIndex = "排序字段不能为空";
                }
                if (app.menu.enabled === "") {
                    hasError = true;
                    app.errors.enabled = "必须选择是否可用"
                }

                if (!hasError) {
                    var params = new URLSearchParams();
                    params.append("id", app.menu.id);
                    params.append("name", app.menu.name);
                    params.append("icon", app.menu.icon);
                    params.append("iconLarger", app.menu.iconLarger);
                    params.append("orderIndex", app.menu.orderIndex);
                    params.append("enabled", app.menu.enabled);
                    params.append("remark", app.menu.remark);
                    params.append("parentId", app.menu.parentId);
                    axios.post('/oauth2/menu/api/edit', params)
                        .then(function (response) {
                            if (response.data.code === Global.status_code.success) {
                                layer.msg(response.data.message);
                                $("#editMenu").dialog("close");
                                $table.bootstrapTable("refresh");
                            } else {
                                Global.show_error_msg(response.data.message)
                            }
                        })
                } else {
                    Global.show_error_msg("请修改错误之后在提交");
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
                    return String(app.menu.name).length > 0
                },
                message: '菜单名称不能为空'
            },
            resourceId: {
                test: function () {
                    if (app.menu.menuType.selected === '1') {
                        return String(app.menu.resourceId).length > 0;
                    }
                    return true;
                },
                message: "菜单类型为内置权限菜单的时必须选择资源"
            },
            systemCode: {
                test: function () {
                    return String(app.menu.systemCode).length > 0;
                },
                message: "系统模块代码不能为空"
            },
            href: {
                test: function () {
                    if (app.menu.menuType.selected === "1" || app.menu.menuType.selected === "2" || app.menu.menuType.selected === "4") {
                        return String(app.menu.href).length > 0;
                    }
                    return true;
                }, message: "菜单类型不为脚本(js)事件时，href不能为空"
            },
            onclick: {
                test: function () {
                    if (app.menu.menuType.selected === "3") {
                        return String(app.menu.onclick).length > 0;
                    }
                    return true;
                },
                message: "菜单类型为脚本事件时，onclick属性不能为空"
            },
            roleId: {
                test: function () {
                    return String(app.menu.roleId).length > 0;
                },
                message: "角色ID不能为空"
            },
            parentId: {
                test: function () {
                    return String(app.menu.parentId).length > 0;
                },
                message: "必须选择上级菜单"
            },
            orderIndex: {
                test: function () {
                    return app.menu.orderIndex !== "" && app.menu.orderIndex !== null;
                },
                message: "排序字段不能为空"
            },
            enabled: {
                test: function () {
                    return app.menu.enabled !== "" && app.menu.enabled !== null;
                },
                message: "必须填写可用或者不可用"
            }
        }
    });

    //监听菜单模块下拉框更改
    $("#menu-selector-add").on("change", function () {
        app.menu.parentId = "";
        app.menu.parentName = "";
    });

    //监听添加按钮点击事件
    $("#add-menu").click(function () {
        var $roleTree = $.fn.zTree.getZTreeObj("roleTreeMenu");
        var checkedNodes = $roleTree.getCheckedNodes(true);
        if (checkedNodes.length < 1) {
            Global.show_error_msg("请先在左侧角色树勾选一个角色");
        } else {
            //获取菜单模块下拉框内容
            axios.post('/oauth2/menuModule/api/find/enables?systemModuleCode=' + app.menu.systemCode, {})
                .then(function (response) {
                    if (response.data.length > 0) {
                        app.menu.menuModule = response.data;
                        var $selectMenuModule = app.menu.menuModule;
                        app.menu.menuModule.selected = $selectMenuModule[0].id;//默认给下拉菜单选中第一个
                        var $menuSelector = $('#menu-selector-add');
                        $menuSelector.html("");
                        for (var i = 0; i < $selectMenuModule.length; i++) {
                            $menuSelector.append("<option value=" + $selectMenuModule[i].id + ">" + $selectMenuModule[i].name + "</option>");
                        }
                    }
                });

            app.$vuerify.clear();
            for (var f in app.menu) {
                if (f === "menuType") {
                }
                else if (f === "enabled")
                    app.menu[f] = true;
                else if (f === "orderIndex")
                    app.menu[f] = 0;
                else if (f !== "systemCode" && f !== "systemModuleName")
                    app.menu[f] = "";
            }
            if (app.menu.menuType.selected === "4") {
                app.menu.href = "#";
            }
            app.menu.roleId = checkedNodes[0].id;
            app.menu.roleName = checkedNodes[0].name;
            $("#addMenu").dialog("open");
        }
    });

    //监听编辑按钮点击事件
    $("#edit-menu").click(function () {
        app.$vuerify.clear();
        var selectedMenu = $table.bootstrapTable("getSelections");
        if (selectedMenu.length === 0) {
            Global.show_error_msg("请选择一项菜单进行编辑");
        } else {
            app.menu.id = selectedMenu[0].id;
            app.menu.icon = selectedMenu[0].icon;
            app.menu.name = selectedMenu[0].name;
            app.menu.parentId = selectedMenu[0].parentId;
            app.menu.menuModule.selected = selectedMenu[0].menuModuleId;
            app.menu.roleId = selectedMenu[0].roleId;
            app.menu.iconLarger = selectedMenu[0].iconLarger;
            app.menu.enabled = selectedMenu[0].enabled;
            app.menu.remark = selectedMenu[0].remark;
            app.menu.orderIndex = selectedMenu[0].orderIndex;
            $("#editMenu").dialog("open");
        }
    });

    //添加弹出框操作
    $("#addMenu").dialog({
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 添加新菜单</h4></div>",
        autoOpen: false,
        width: 800,
        resizable: false,
        modal: true,
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp;确认",
            "class": "btn btn-primary",
            click: function () {
                $("#doAddMenu").trigger("click");
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
    $("#editMenu").dialog({
        title: "<div class='widget-header'><h4><i class='icon-ok'></i> 编辑菜单</h4></div>",
        autoOpen: false,
        width: 600,
        resizable: false,
        modal: true,
        buttons: [{
            html: "<i class='fa fa-plus-square-o'></i>&nbsp;确认",
            "class": "btn btn-primary",
            click: function () {
                $("#doEditMenu").trigger("click");
            }
        }, {
            html: "<i class='fa fa-times'></i>&nbsp;取消",
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    })

    //删除
    $("#delete-menu").click(function () {
        var ss = $table.bootstrapTable('getSelections');
        if (ss.length === 0) {
            Global.show_error_message("错误选择", "请至少选择一项进行禁用操作")
        } else {
            Global.deleteItems($table, "/oauth2/menu/api/delete", "name");
        }
    });
};

//加载左侧树
function loadRoleTreeMenu() {
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
                var treeObj = $.fn.zTree.getZTreeObj("roleTreeMenu");
                treeObj.checkNode(treeNode, true, false);
                // treeObj.expandNode(treeNode, null, null, null, true);
                $table.bootstrapTable("destroy");
                initTable();
            },
            beforeExpand: beforeExpand,
            onExpand: onExpand
        }
    };
    $.get("/oauth2/role/api/selectRole?systemModuleCode=" + $selectedModuleMenu.val(), function (treeData) {
        treeData[0].checked = true;
        for (var node in treeData) {
            treeData[node].open = false;
        }
        $.fn.zTree.init($("#roleTreeMenu"), settings, treeData);
        var treeObj = $.fn.zTree.getZTreeObj("roleTreeMenu");
        //默认选择第一个
        var firstNode = treeObj.getNodes()[0];
        treeObj.selectNode(firstNode);
        $table.bootstrapTable("destroy");
        initTable();
    });

}

//选择上级菜单
function checkParentMenu() {
    layer.open({
        type: 2,
        area: ['300px', '400px'],
        title: [' 上级菜单选择- (双击选择)  ', 'text-align:center;'],
        fixed: true,
        resize: false,
        offset: '200px',
        scrollbar: false,
        content: '/oauth2/menu/parentTree'
    })
}

//选择资源
function checkResource() {
    layer.open({
        type: 2,
        title: "资源列表",
        area: ['400px', '550px'],
        fixed: true,
        resize: false,
        offset: '200px',
        content: "/oauth2/menu/resourceSelect"
    })
}

//表格显示字体图标
function iconFormatter(value) {
    return "<i class='" + value + "'></i>";
}

//表格显示菜单类型描述

function menuTypeFormatter(value) {
    return value === "1" ? "<label class='label label-info bg-color-magenta'>内置权限</label>" :
        value === "2" ? "<label class='label label-danger'> 外部链接</label>" :
            value === "3" ? "<label class='label label-success'>脚本事件</label>" :
                "<label class='label label-primary'>目录级别</label>";
}

//初始化表格
function initTable() {
    $table.bootstrapTable({
        url: '/oauth2/menu/api/list',
        toolbar: '#menu-toolbar',
        cache: false,
        method: "post",
        queryParams: function () {
            var treeObj = $.fn.zTree.getZTreeObj("roleTreeMenu");
            var checked = treeObj.getCheckedNodes(true)[0];
            return {
                roleId: checked.id
            }
        },
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",//post方式一定得改成这种contentType,默认是application/json
        height: Global.getHeight(),
        showColumns: true,//是否显示 内容列下拉框
        showRefresh: true,
        treeView: true,
        treeId: "id",
        treeField: "name",
        treeRootLevel: 0,
        clickToSelect: true,
        singleSelect: true,
        filterControl: true,
        columns: [
            {checkbox: "true"},
            {field: "name", title: "菜单名称", filterControl: "input", filterControlPlaceholder: "输入菜单名称"},
            {field: "icon", title: "菜单图标", align: "center", formatter: "iconFormatter"},
            {field: "id", title: "菜单ID", align: "center", visible: false},
            {field: "parentId", title: "上级菜单ID", align: "center", visible: false},
            {field: "menuType", title: "菜单类型", align: "center", formatter: "menuTypeFormatter"},
            {field: "href", title: "菜单链接", align: "center"},
            {field: "orderIndex", title: "菜单排序", align: "center", sortable: true},
            {field: "enabled", title: "是否可用", align: "center", formatter: "enabledFormatter"},
            {field: "remark", title: "菜单备注", align: "center", visible: false}
        ]
    });
}

// load related plugins
loadScript("/static/js/plugin/bootstrap-table/extensions/tree-grid/bootstrap-table-tree-grid.js", page_function());