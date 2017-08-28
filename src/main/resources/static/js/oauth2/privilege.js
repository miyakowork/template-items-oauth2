pageSetUp();

var page_function = function () {
    loadSystemModuleTree();//加载左侧角色树
};


//加载左侧树结构
function loadSystemModuleTree() {
    var settings = {
        data: {
            keep: {
                leaf: true
            },
            simpleData: {
                enable: true,
                rootPId: 0
            }
        },
        view: {
            selectedMulti: false
        },
        callback: {
            onClick: loadRoleTree
        }
    };
    $.get("/oauth2/system-module/api/find/modules/enabled/moduleTree", function (json) {
        $.fn.zTree.init($("#systemModuleTree"), settings, json)
    })
}

//加载中间一栏的角色树
function loadRoleTree(event, treeId, treeNode) {
    $("#selectSystemModuleInTree").text(treeNode.name);
    $("#roleTreeTitle").text("（" + treeNode.name + "）");
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
        callback: {
            onClick: loadPrivilegeTree,
            beforeExpand: beforeExpand,
            onExpand: onExpand
        }
    };
    $.get("/oauth2/role/api/selectRole?systemModuleCode=" + treeNode.other, function (treeData) {
        for (var node in treeData) {
            treeData[node].open = false;
        }
        $.fn.zTree.init($("#roleTree"), settings, treeData)
    })
}

//加载第三列的树，先加载模块，而后异步加载权限资源
function loadPrivilegeTree(event, treeId, treeNode) {
    var $systemModuleTree = $.fn.zTree.getZTreeObj("systemModuleTree");
    var nodes = $systemModuleTree.getSelectedNodes();
    var $roleTree = $.fn.zTree.getZTreeObj("roleTree");
    var roleTreeSelectedNodes = $roleTree.getSelectedNodes();
    $roleTree.expandNode(treeNode, null, null, null, true);
    $("#resModuleTreeTitle").text("（" + treeNode.name + "）");
    var settings = {
        data: {
            simpleData: {
                enable: true,
                rootPId: 0
            }
        },
        check: {
            enable: true
        },
        async: {
            enable: true,
            autoParam: ['id=resourceModuleId'],
            otherParam: {
                roleId: roleTreeSelectedNodes[0].id
            },
            url: '/oauth2/privilege/api/getAjaxPrivilegeData'
        },
        view: {
            selectedMulti: false,
            fontCss: function (treeId, treeNode) {
                if (treeNode.pId === 0) {
                    return {
                        color: '#848484'
                    }
                }
                if (treeNode.checked === true) {
                    return {
                        'font-weight': 'bold'
                    }
                } else {
                    return {
                        'font-weight': 'normal'
                    }
                }
            }
        },
        callback: {
            onClick: function (event, treeId, treeNode) {
                var treeObj = $.fn.zTree.getZTreeObj("resModuleTree");
                treeObj.checkNode(treeNode, !treeNode.checked, true);
                treeObj.expandNode(treeNode, null, null, null, true);
                if (treeNode.other === "page_privilege" || treeNode.other === "operation_privilege") {//如果是勾选权限则设置权限，如果点击资源模块则不做操作
                    setPrivilege(event, treeId, treeNode);
                }
            },
            onCheck: function (event, treeId, treeNode) {
                setPrivilege(event, treeId, treeNode);
            },
            beforeExpand: beforeExpand,
            onExpand: onExpand
        }
    };
    $.get("/oauth2/resModule/api/resModuleTree?systemModuleCode=" + nodes[0].other, function (treeData) {
        for (var treeNode in treeData) {
            treeData[treeNode].isParent = true;
            treeData[treeNode].nocheck = true;
        }
        $.fn.zTree.init($("#resModuleTree"), settings, treeData);
    })
}

//权限资源树上每勾选/取消勾选的时候的操作
function setPrivilege(event, treeId, treeNode) {
    var treeObj = $.fn.zTree.getZTreeObj(treeId);
    var sNodes = treeObj.getChangeCheckedNodes();//  得到权限树勾选改编的节点的集合

    var resourceIds = new Array(sNodes.length);
    for (var i = 0; i < sNodes.length; i++) {
        resourceIds[i] = sNodes[i].resourceId;
    }

    treeObj.refresh();

    $.ajax({
        type: "post",
        dataType: 'json',
        success: function (resp) {
            if (resp.code === TF.status_code.success) {
                layer.msg(resp.message, {
                    time: 1000
                })
            } else {
                TF.show_error_msg(resp.message)
            }
        },
        data: {
            checked: treeNode.checked,
            roleId: $.fn.zTree.getZTreeObj("roleTree").getSelectedNodes()[0].id,
            resourceIds: resourceIds
        },
        url: "/oauth2/privilege/api/setPrivilege"
    });
}


// load related plugins
page_function();