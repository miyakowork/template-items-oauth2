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
                $.post("/oauth2/user/api/findCurrentUserRoles", function (roles) {
                    var html =
                        '<div class="layui-container padding-10" style=" word-wrap: break-word;\n' +
                        '            word-break: break-all;">' +
                        '<button class="layui-btn layui-btn-small layui-btn-primary" style="display: inline-block;float: left;">测试阿娜牛</button>' +
                        '</div>'
                    layer.open({
                        type: 1,
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 0, //不显示关闭按钮
                        anim: 2,
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
    var changeRole = $("#show-shortcut");
    changeRole.hover(function () {
        __Index = layer.tips('点我切换菜单模块', this, {
            tips: [1, '#c41e31'],
            time: 3000
        });
    }, function () {
        layer.close(__Index)
    });
}