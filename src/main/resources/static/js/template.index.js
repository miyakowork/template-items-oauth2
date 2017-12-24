;!function () {

    loginDateTime();

    setInterval('clock()', 1000);
    setInterval('clock()', 1000);

}();

$(function () {
    var leftAppMenus = new Vue({
        el: "#left-panel",
        data: {
            systemCode: 'SYS_BASE',
            user: {},
            defaultRoleId: null,
            menuModuleList: [],
            defaultMenuModuleId: '',
            menuList: []
        },
        computed: {
            currentRoleId: function () {
                return this.defaultRoleId || this.user.defaultRoleId;
            }
        },
        methods: {
            showModule: function () {
                $('#shortcut').slideDown(200);
            },
            changeRole: function () {
                var that = this;
                $.post("/oauth2/user/api/findCurrentUserRoles?systemCode=" + that.systemCode, function (roles) {
                    var html = '<div class="layui-container" style="width: 100%;padding: 15px;">';
                    for (var i = 0; i < roles.length; i++) {
                        var style;
                        var text = roles[i].cnName;
                        var roleId = roles[i].id;
                        if (i % 5 === 0) {
                            style = 'border-radius: 50px !important;margin-left: 0;';
                        } else {
                            style = 'border-radius: 50px !important;';
                        }
                        var current = 'layui-btn-primary';
                        if (Number(that.currentRoleId) === roles[i].id) {
                            current = 'layui-btn-disabled';
                        }
                        html += '<button onclick="exchangeRole(this,' + roleId + ');" class="layui-btn layui-btn-sm margin-bottom-10 ' + current + '" style="' + style + '">' + text + '</button>';
                    }
                    html += '</div>';
                    layer.open({
                        type: 1,
                        title: '切换用户角色',
                        area: ['480px', '300px'],
                        skin: 'layui-layer-demo', //样式类名
                        shadeClose: true, //开启遮罩关闭
                        content: html
                    });
                })
            },
            init: function () {
                var that = this;
                $.getJSON("/oauth2/user/api/info", function (userInfo) {
                    if (userInfo !== null) {
                        that.user = userInfo;
                        $.getJSON('/oauth2/getPermissionsByRoleId?roleId=' + that.user.defaultRoleId, function (permissionMarks) {
                            window.permissions = permissionMarks;
                        });
                        $.getJSON('/oauth2/getRoleNamesByUserId?userId=' + that.user.id, function (rNames) {
                            window.roleNames = rNames;
                        });
                        $.getJSON('/oauth2/menuModule/api/find/enables?systemModuleCode=' + that.systemCode, function (menuModules) {
                            that.menuModuleList = menuModules;
                            new Vue({
                                el: "#shortcut",
                                data: {
                                    modules: that.menuModuleList
                                }
                            });
                            if (CookieUtils.get(Global.key.LEFT_NAV_MODULE_ID) !== null && !isNaN(CookieUtils.get(Global.key.LEFT_NAV_MODULE_ID))) {
                                that.defaultMenuModuleId = CookieUtils.get(Global.key.LEFT_NAV_MODULE_ID);
                            } else {
                                that.defaultMenuModuleId = menuModules.length > 0 ? menuModules[0].id : '';
                                CookieUtils.del(Global.key.LEFT_NAV_MODULE_ID);
                                CookieUtils.set(Global.key.LEFT_NAV_MODULE_ID, that.defaultMenuModuleId, '7d');
                            }
                            $.getJSON('/oauth2/menu/api/getMenuListIndex', {
                                systemCode: that.systemCode,
                                menuModuleId: that.defaultMenuModuleId
                            }, function (leftMenus) {
                                that.menuList = toTree(leftMenus, 0);
                                location.href = "/#/";
                            })
                        })
                    }
                });
            }
        },
        created: function () {
            this.init();
        },
        mounted: function () {
            switchRoleTips();
            switchMenuModuleTips();
        }
    });
});


/**
 * 登录时间
 */
function loginDateTime() {
    var day = new Date().getDate();
    var hour = new Date().getHours();
    $("#login-dt").html(new Date().getFullYear()
        + "-"
        + ((new Date().getMonth() + 1) < 10 ? "0" + (new Date().getMonth() + 1) : (new Date().getMonth() + 1))
        + "-"
        + (day < 10 ? ("0" + day) : day)
        + "&nbsp;"
        + (hour < 10 ? ("0" + hour) : hour)
        + ":"
        + (new Date().getMinutes() < 10 ? "0" + new Date().getMinutes() : new Date().getMinutes())
        + ":"
        + new Date().getSeconds());
}


/**
 * 数字时钟效果
 */
function clock() {
    var time = new Date();//获取系统当前时间
    var year = time.getFullYear();
    var month = time.getMonth() + 1;
    var date = time.getDate();//系统时间月份中的日
    var day = time.getDay();//系统时间中的星期值
    var weeks = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
    var week = weeks[day];//显示为星期几
    var hour = time.getHours();
    var minutes = time.getMinutes();
    var seconds = time.getSeconds();
    if (month < 10) {
        month = "0" + month;
    }
    if (date < 10) {
        date = "0" + date;
    }
    if (hour < 10) {
        hour = "0" + hour;
    }
    if (minutes < 10) {
        minutes = "0" + minutes;
    }
    if (seconds < 10) {
        seconds = "0" + seconds;
    }

    var timeRunner = document.getElementById("tp-date");
    if (timeRunner) {
        timeRunner.innerHTML = year + "年" + month + "月" + date + "日&nbsp;"
            + week
            + "&nbsp;" + hour + ":" + minutes + ":" + seconds
            + "&nbsp;";
    }
}

/**
 * 菜单数组递归形成树结构
 * @param menuList
 * @param parentId
 */
function toTree(menuList, parentId) {
    var result = [], temp;
    for (var i = 0; i < menuList.length; i++) {
        if (menuList[i].parentId === parentId) {
            var obj = menuList[i];
            temp = toTree(menuList, menuList[i].id);
            if (temp.length > 0) {
                obj.childMenus = temp;
            }
            result.push(obj);
        }
    }
    return result;
}

/**
 * 切换角色的提示信息
 */
function switchRoleTips() {
    var __changeRoleIndex;
    var changeRole = $("#changeRole");
    changeRole.hover(function () {
        __changeRoleIndex = layer.tips('点我切换角色', this, {
            tips: [1, '#c41e31'],
            time: 3000
        });
    }, function () {
        layer.close(__changeRoleIndex)
    });
}

/**
 * 切换菜单模块的提示信息
 */
function switchMenuModuleTips() {
    var __Index;
    var changeRole = $("#changeMenuModule");
    changeRole.hover(function () {
        __Index = layer.tips('点我切换菜单模块', this, {
            tips: [1, '#c41e31'],
            time: 3000
        });
    }, function () {
        layer.close(__Index)
    });
}

/**
 * 切换角色
 * @param roleId
 */
function exchangeRole(elem, roleId) {
    if (!$(elem).hasClass("layui-btn-disabled")) {
        window.location.href = "/?roleId=" + roleId;
    }
}

/**
 * 是否含有此权限
 * @param permission
 * @returns {boolean}
 */
function hasPermission(permission) {
    return window.permissions.indexOf(permission) > -1;
}

/**
 *判断是否有其中之一的权限
 * @param permissions 逗号隔开
 */
function hasAnyPermission(permissions) {
    var r = false;
    var p = permissions.split(",");
    for (var i = 0; i < p.length; i++) {
        var obj = p[i];
        if (window.permissions.indexOf(obj) > -1) {
            return true;
        }
    }
    return r;
}

/**
 * 是否含有此角色
 * @param rName
 * @returns {boolean}
 */
function hasRole(rName) {
    return window.roleNames.indexOf(rName) > -1;
}

/**
 *判断是否有其中之一的角色
 * @param rNames 逗号隔开
 */
function hasAnyRole(rNames) {
    var r = false;
    var p = rNames.split(",");
    for (var i = 0; i < p.length; i++) {
        var obj = p[i];
        if (window.roleNames.indexOf(obj) > -1) {
            return true;
        }
    }
    return r;
}