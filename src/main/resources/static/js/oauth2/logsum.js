pageSetUp();

//截止时间设置默认值
var $endTime = $("#endTime")
$endTime.attr("value", getCurrentDate());

var oldEndTime = $endTime.val();

//部门id设置默认值
var departmentId = 0;


var page_function = function () {

    load_departmentTree();

    load_loginSumChart();

    //监听上一周期点击事件
    $("#preDate").click(function () {
        $endTime.val(setDate($endTime.val(), $("#dateNumSelector").find("option:selected").val()));
        load_loginSumChart();
    });

    //监听下一周期点击事件
    $("#nextDate").click(function () {
        var addResult = setDate($endTime.val(), -$("#dateNumSelector").find("option:selected").val());
        if (addResult > getCurrentDate()) {
            Global.show_error_message("错误消息提示", "查询日期大于当前日期", 3000)
        } else {
            $endTime.val(addResult);
            load_loginSumChart();
        }
    });

    //监听截止时间点击事件
    laydate.render({
        elem: '#endTime'
        , format: 'yyyy-MM-dd'
        , theme: '#a90329'
        , max: (new Date()).format("yyyy-MM-dd")
        , done: function (value, date, endDate) {
            if (oldEndTime !== value && value !== "") {
                load_loginSumChart();
                oldEndTime = value;
            }
        }
    })
    ;

};

//获取当前时间用户初始化截止时间
function getCurrentDate() {
    var date = new Date();
    var year = date.getFullYear();
    var month = '';
    if (date.getMonth() > 9) {
        month = date.getMonth() + 1;
    } else {
        month = date.getMonth() + 1;
        month = month < 10 ? ("0" + month) : month;
    }
    var day = date.getDate();
    day = day < 10 ? ("0" + day) : day;
    return year + "-" + month + "-" + day;
}

//更新截止时间
function setDate(date, days) {
    if (days === undefined || days === '') {
        days = 0;
    }
    var d1 = new Date(date);
    d1.setDate(d1.getDate() - days);
    var month = d1.getMonth() + 1;
    var day = d1.getDate();
    return d1.getFullYear() + '-' + getFormatDate(month) + '-' + getFormatDate(day);
}


// 格式化截止时间显示：日期月份/天的显示，如果是1位数，则在前面加上'0'
function getFormatDate(arg) {
    if (arg === undefined || arg === '') {
        return '';
    }
    var re = arg + '';
    if (re.length < 2) {
        re = '0' + re;
    }
    return re;
}


//加载右侧图
var load_loginSumChart = function () {

    var myChart = echarts.init(document.getElementById('chartContainer'));
    myChart.setOption({
        title: {
            text: '用户登录统计',
            subtext: '各部门用户登录统计图'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['人次', '人数']
        },
        calculable: true,
        xAxis: {
            data: []
        },
        yAxis: {},
        series: [
            {
                name: '人次',
                type: 'bar',
                data: [],
                markPoint: {
                    data: [
                        {type: 'max', name: '最大值'},
                        {type: 'min', name: '最小值'}
                    ]
                },
                markLine: {
                    data: [
                        {type: 'average', name: '平均值'}
                    ]
                }
            },
            {
                name: '人数',
                type: 'bar',
                data: [],
                markPoint: {
                    data: [
                        {type: 'max', name: '最大值'},
                        {type: 'min', name: '最小值'}
                    ]
                },
                markLine: {
                    data: [
                        {type: 'average', name: '平均值'}
                    ]
                }
            }
        ]
    });
    $.post('/oauth2/loginsum/api/charts',
        {
            endTime: $endTime.val(),
            num: $("#dateNumSelector").find("option:selected").val(),
            deptId: departmentId
        }
    ).done(function (data) {
        myChart.setOption({
            xAxis: {
                data: data.loginDate
            },
            series: [
                {
                    name: '人次',
                    data: data.loginSum
                },
                {
                    name: '人数',
                    data: data.loginMount
                }
            ]
        })
    })
};

//加载左侧树结构
var load_departmentTree = function () {
    var settings = {
        data: {
            simpleData: {
                enable: true,
                rootPId: 0
            }
        },
        check: {
            enable: true,
            chkStyle: "radio",
            radioType: "all"
        },
        async: {
            enable: true,
            url: "/oauth2/department/api/selectDepartment",
            autoParam: ["id"]
        },
        view: {
            selectedMulti: false
        },
        callback: {
            onClick: function (event, treeId, treeNode) {
                departmentId = treeNode.id;
                load_loginSumChart();
            }
        }
    };
    $.get("/oauth2/department/api/selectDepartment?id=0", function (json) {
        $.fn.zTree.init($("#DepartmentTree"), settings, json.data)
    })

};


loadScript("/static/js/libs/vue/axios.min.js", function () {
    loadScript("/static/js/libs/vue/url-search-params.min.js", function () {
        loadScript("static/js/libs/echarts.common.min.js", page_function())
    })
})