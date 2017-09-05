;!function () {

    loginDateTime();

    setInterval('clock()', 1000);
    setInterval('clock()', 1000);

    new Vue({
        el: "#left-panel",
        data: {}
    });

}();


/**
 * 登录时间
 */
function loginDateTime() {
    var day = new Date().getDate();
    $("#login-dt").html(new Date().getFullYear()
        + "-"
        + ((new Date().getMonth() + 1) < 10 ? "0" + (new Date().getMonth() + 1) : (new Date().getMonth() + 1))
        + "-"
        + (day < 10 ? ("0" + day) : day)
        + "&nbsp;"
        + new Date().getHours()
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

