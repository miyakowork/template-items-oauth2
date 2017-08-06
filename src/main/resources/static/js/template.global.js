/**
 * 封装此框架对应的相关前端js方法
 * Created By wuwenbin on 2017/5/5
 */

var TF = {

        TEXT: {
            CHECKBOX_NAME: 'itemChecks'
        },

        COMMON: {
            SEARCH_TRIGGER_TIME: 1000,

        },
        /**
         * ajax常量
         */
        TEMPLATE: {
            AJAX_REQUEST_TYPE: 'POST',
            AJAX_REQUEST_DATA_TYPE: 'json',
            AJAX_REQUEST_CONTENT_TYPE: 'application/json'
        },

        /**
         * 框架请求状态码
         */
        STATUS_CODE: {
            SUCCESS: 200,
            ERROR: 500,
            SLEEP: 250,
            TIMEOUT: 301
        },

        /**
         *本框架通用ajax请求
         * @param _url
         * @param _data
         * @returns {{}}
         */
        temp_ajax: function (_url, _data) {
            var _obj = {};
            if (!_url) {
                _obj.code = 406;
                _obj.message = "the request URL must not be null!";
                return _obj;
            }
            $.ajax({
                url: _url,
                type: this.TEMPLATE.AJAX_REQUEST_TYPE,
                dataType: this.TEMPLATE.AJAX_REQUEST_DATA_TYPE,
                data: _data || {},
                async: true,
                success: function (successJson) {
                    _obj = successJson;
                },
                error: function (errorJson) {
                    _obj = errorJson.responseJSON
                }
            })
            return _obj;
        },

        /**
         * 路由上通过js跳转另一个路由
         * @param _url
         * @param _$container
         */
        jump_func_router: function (_url) {
            loadURL(_url, $("#content"));
        },

        /**
         * 加载路由页面
         */
        load_router: function () {
            $("body").on("click", "a[data-jump-href]", function () {
                var router = $(this).data("jump-href");
                window.location.hash = router;
            })
        },

        /**
         * 错误消息提示
         * @param title
         * @param content
         * @param timeout
         */
        show_error_message: function (title, content, timeout) {
            $.smallBox({
                title: title || "错误提示信息",
                content: '<p>' + content + '</p>' || '<p>请修正错误信息之后再提交</p><br/>',
                color: "#b94a48",
                timeout: timeout || 3000,
                icon: "fa fa-times"
            });
        },

        /**
         *显示错误信息提示
         * @param content
         */
        show_error_msg: function (content) {
            TF.show_error_message("错误信息提示", content, 5000);
        },

        /**
         * 确认选择提示框
         * @param title
         * @param content
         * @param callback
         */
        show_confirm_msg: function (title, content, callback) {
            $.SmartMessageBox({
                title: title,
                content: content,
                buttons: '[取消][确定]'
            }, callback);
        },

        /**
         * 获取项目根路径
         * @returns {string}
         */
        getRootPath: function () {
            //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
            var curWwwPath = window.document.location.href;
            //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
            var pathName = window.document.location.pathname;
            var pos = curWwwPath.indexOf(pathName);
            //获取主机地址，如： http://localhost:8083
            var localhostPaht = curWwwPath.substring(0, pos);
            //获取带"/"的项目名，如：/uimcardprj
            var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
            return (localhostPaht + projectName);
        },

        /**
         * 页面上运行的时钟
         */
        dateTimerRunner: function () {
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

            //var newDate = year+"年"+month+"月"+date+"日"+week+hour+":"+minutes+":"+seconds;
            var timeRunner = document.getElementById("tp-date");
            if (timeRunner) {
                timeRunner.innerHTML = year + "年" + month + "月" + date + "日&nbsp;"
                    + week
                    + "&nbsp;" + hour + ":" + minutes + ":" + seconds
                    + "&nbsp;";
            }

        },

        /**
         * 显示日期
         */
        showLoginDT: function () {
            $("#login-dt").html(new Date().getFullYear()
                + "-"
                + (new Date().getMonth() + 1)
                + "-"
                + new Date().getDate()
                + "&nbsp;"
                + new Date().getHours()
                + ":"
                + new Date().getMinutes()
                + ":"
                + new Date().getSeconds());
        },

        /**
         * 判断是否为中文
         * @param str
         * @returns {boolean}
         */
        isChinese: function (str) {
            return /^[\u3220-\uFA29]+$/.test(str);
        },

        /**
         * 激活laydate
         * @param element
         * @param otherOptions
         */
        activeLaydatePicker: function (element, tableId, otherOptions) {
            var options = {
                elem: element
            };

            //组装laydate的options参数
            options.extend = function (obj) {
                for (var o in obj) {
                    this[o] = obj[o]
                }
            };

            options.extend(otherOptions);

            //如果日期搜索between匹配模式，即有2个，则查询做如下的操作
            var key = $(element).closest("th[data-field]").data("field");
            var $table = $("table#" + tableId);
            var $bodyStart = $(".fixed-table-body .bootstrap-table-filter-control-" + key + "-start");
            var $bodyEnd = $(".fixed-table-body .bootstrap-table-filter-control-" + key + "-end");
            var $dateControl = $(".fixed-table-body .bootstrap-table-filter-control-" + key);

            if ($(element).hasClass("date-filter-control-end")) {
                options.choose = function (dates) {
                    if ($bodyStart.val() === "") {
                        layer.msg("请先选择开始日期，再选择结束日期，否则不会触发搜索");
                        $bodyEnd.val("");
                        return;
                    }
                    $bodyEnd.val(dates);

                    window.__searchValues.start = $bodyStart.val();
                    window.__searchValues.end = $bodyEnd.val();

                    setTimeout(function () {
                        $table.bootstrapTable('refresh');
                    }, TF.COMMON.SEARCH_TRIGGER_TIME);
                }
            }

            else if ($(element).hasClass("date-filter-control-start")) {
                options.choose = function (dates) {
                    $bodyStart.val(dates);
                    layer.msg("请继续选择结束日期以触发搜索")
                }
            }

            else if ($(element).hasClass("date-filter-control-single")) {
                options.choose = function (dates) {
                    $dateControl.val(dates);

                    window.__searchValues.single = $dateControl.val();

                    setTimeout(function () {
                        $table.bootstrapTable('refresh');
                    }, TF.COMMON.SEARCH_TRIGGER_TIME);
                };
            }

            laydate(options)
        },

        /**
         * 组装日期的查询传递到后台的参数的方法（between匹配模式）
         * @param field data-field的属性
         * @returns {string}
         */
        datepickerSearch: function (field) {
            var $th = $("div.fixed-table-header").find("th[data-field=" + field + "]");
            if ($th.find(".date-filter-control-start").length > 0 || $th.find(".date-filter-control-end").length > 0) {
                var start = $th.find(".bootstrap-table-filter-control-" + field + "-start").val();
                var end = $th.find(".bootstrap-table-filter-control-" + field + "-end").val();
                //如果是为between匹配模式，则需要两个日期都要不为空
                if (start !== "" && end !== "")
                    return start + "," + end;
                return "";
            } else {
                var date = $th.find(".bootstrap-table-filter-control-" + field).val();
                return date;
            }
        },
        /**
         * 初始化table，只需要填写主要参数，不需要填很多参数
         * @param $table
         * @param mainOptions  options
         */
        initTable: function ($table, mainOptions) {
            var opt = {
                height: TF.getHeight(),
                striped: true,//设置为 true 会有隔行变色效果
                method: 'post',
                cache: false,//设置为 false 禁用 AJAX 数据缓存
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",//post方式一定得改成这种contentType
                pagination: true,
                paginationLoop: false,
                sidePagination: "server",
                pageList: '[1,5,10,25,50,100,150,200,500,1000]',
                selectItemName: this.CHECKBOX_NAME,//radio or checkbox 的字段名
                escape: true,
                searchTimeOut: TF.COMMON.SEARCH_TRIGGER_TIME,
                trimOnSearch: false,//设置为 true 将允许空字符搜索
                showToggle: true,//是否显示 切换试图（table/card）按钮
                idField: "id",
                uniqueId: "id",
                clickToSelect: true,//	设置true 将在点击行时，自动选择rediobox 和 checkbox
                maintainSelected: true,//设置为 true 在点击分页按钮或搜索按钮时，将记住checkbox的选择项
                showColumns: true,//是否显示 内容列下拉框
                showRefresh: true,
                showMultiSort: true,//多列排序
                filterShowClear: true//Set true to add a button to clear all the controls added by this plugin.
            };
            //组装laydate的options参数
            opt.extend = function (obj) {
                for (var o in obj) {
                    this[o] = obj[o]
                }
            };

            opt.extend(mainOptions);
            $table.bootstrapTable(opt);
        }

        ,

        /**
         * 重新载入table
         * @param $table
         * @param mainOptions
         */
        reInitTable: function ($table, mainOptions) {
            $table.bootstrapTable("destroy");
            TF.initTable($table, mainOptions);
        }
        ,
        /**
         * 表格列表页面获取高度
         * @returns {number}
         */
        getHeight: function () {
            return $(window).height() - $('header').outerHeight(true)
                - $('div.page-footer').outerHeight(true)
                - $('#ribbon').outerHeight(true)
        }
    }
;


/**
 * 页面加载完之后初始化加载脚本
 */
$(function () {

    //bootstrap-table中文化
    $.extend($.fn.bootstrapTable.defaults, $.fn.bootstrapTable.locales['zh-CN']);

    //时钟
    setInterval('TF.dateTimerRunner()', 1000);

    //页脚的时间
    TF.showLoginDT();

    var index;
    var menuModuleMini = true;
    var $changeModule = $("#change-module");
    $changeModule.hover(function () {
        index = layer.tips('切换菜单模块展示方式', this, {
            tips: [2, '#fb3c4a'],
            time: 3000
        });
    }, function () {
        layer.close(index)
    });

    $changeModule.click(function () {
        if (menuModuleMini) {
            $("span.menu-module-text").hide();
            menuModuleMini = false;
        } else {
            $("span.menu-module-text").show();
            menuModuleMini = true
        }
    });


    /**
     * 初始化dialog的html形式的title
     */
    if ($.ui) {
        $.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
            _title: function (title) {
                if (!this.options.title) {
                    title.html("&#160;");
                } else {
                    title.html(this.options.title);
                }
            }
        }));
    }

    /**
     * 监听高度resize事件动态改变table的大小
     * 表格的id一定要为xxxx-table的形式，否则监听事件无效
     */
    $(window).resize(function () {
        var $table = $("table[id$='-table']");
        if ($table.length > 0) {
            $table.bootstrapTable('resetView', {
                height: TF.getHeight()
            });
        }

    });


});

//日期格式化显示
Date.prototype.format = function (format) {
    var date = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "h+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "S+": this.getMilliseconds()
    };
    if (/(y+)/i.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    }
    for (var k in date) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1
                ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
        }
    }
    return format;
};

/**
 * 所有含有表格页面的如果需要格式化显示日期的可以使用格式化日期显示方式
 *
 * @param date
 */
function date_formatter(date) {
    var resD = '';
    if (date instanceof Object) {
        resD = date.year + "-"
            + (date.monthValue < 10 ? ("0" + date.monthValue) : date.monthValue) + "-"
            + (date.dayOfMonth < 10 ? ("0" + date.dayOfMonth) : date.dayOfMonth) + " ";
        if (date.hour && date.minute && date.second) {
            resD += (date.hour < 10 ? ("0" + date.hour) : date.hour) + ":"
                + (date.minute < 10 ? ("0" + date.minute) : date.minute) + ":"
                + (date.second < 10 ? ("0" + date.second) : date.second);
        }
        return resD;
    }
    else if (date !== null && date !== "") {
        var d = new Date();
        d.setTime(date);
        return d.toLocaleString()
    }
    return "不合法的日期";
}

/**
 * 格式化是否可用一列显示方式
 * @param val
 */
function enabledFormatter(val) {
    return val ? "<label class='label label-success'>可用</label>" : "<label class='label label-danger'>不可用</label>";
}

//预先给window增加属性
window.__searchValues = {
    start: '',
    end: '',
    single: ''
}