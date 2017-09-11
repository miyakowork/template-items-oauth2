;!function () {

    loginDateTime();

    setInterval('clock()', 1000);
    setInterval('clock()', 1000);

}();

var vm = new Vue({
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
        init: function () {
            var that = this;
            $.getJSON("/oauth2/user/api/info", function (resp) {
                if (resp.code === Global.status_code.success) {
                    that.user = resp.data;
                    $.getJSON('/oauth2/menuModule/api/find/enables?systemModuleCode=' + that.systemCode, function (menuModules) {
                        that.menuModuleList = menuModules;
                        that.defaultMenuModuleId = menuModules.length > 0 ? menuModules[0].id : '';
                        $.getJSON('/oauth2/menu/api/getMenuListIndex', {
                            roleId: that.currentRoleId,
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
    }
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


