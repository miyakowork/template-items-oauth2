pageSetUp();

var page_function = function () {
    //加载左侧角色树
    loadSystemModuleTree();
};


//加载左侧树结构
var loadSystemModuleTree = function () {
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
            onClick: loadRoleTree
        }
    };

    $.get("/oauth2/system-module/api/find/modules/enabled/moduleTree", function (json) {
        $.fn.zTree.init($("#systemModuleTree"), settings, json)
    })
};

//加载中间一栏的角色树
function loadRoleTree(event, treeId, treeNode) {
    $("#selectSystemModuleInTree").text(treeNode.name);
    $("#roleTreeTitle").text("（"+treeNode.name+"）");
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
            onClick: loadPrivilegeTree
        }
    };

    $.get("/oauth2/role/api/selectRole?id=0&systemModuleCode=" + treeNode.other, function (json) {
        $.fn.zTree.init($("#roleTree"), settings, json)
    })
}

//加载第三列的权限树，异步加载
function loadPrivilegeTree() {
    
}
// load related plugins
page_function();