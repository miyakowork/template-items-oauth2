/**
 * 封装此框架对应的相关前端js方法
 * Created By wuwenbin on 2017/5/5
 */
var layer = layui.layer;
var laydate = layui.laydate;

var Global = {

    key: {
        check_box: 'itemChecks',
        LEFT_NAV_MODULE_ID: "__left_nav_menu_module_id__"
    },

    common: {
        search_trigger_time: 1000,
    },
    /**
     * ajax常量
     */
    template: {
        ajax_req_type: 'POST',
        ajax_req_dataType: 'json',
        ajax_req_contentType: 'application/json'
    },

    /**
     * 框架请求状态码
     */
    status_code: {
        success: 200,
        error: 500,
        sleep: 250,
        timeout: 301
    },


    /**
     * 加载路由页面
     */
    load_router: function () {
        $("body").on("click", "a[data-jump-href]", function () {
            var router = $(this).data("jump-href");
            window.location.hash = String(router);
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
        Global.show_error_message("错误信息提示", content, 3000);
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
     * @param tableId
     * @param layDateOptions
     */
    activeLaydatePicker: function (element, tableId, layDateOptions) {
        layDateOptions.show = true;
        layDateOptions.trigger = "click";
        layDateOptions.calendar = true;
        if (layDateOptions.range !== undefined) {
            if (layDateOptions.range) {
                layDateOptions.range = "~";
            }
        }
        if (layDateOptions.elem === undefined) {
            layDateOptions.elem = element;
        }
        if (layDateOptions.theme === undefined) {
            layDateOptions.theme = "#a90329";
        }
        if (layDateOptions.value === undefined) {
            layDateOptions.value = new Date();
        }
        //如果日期搜索between匹配模式，即有2个，则查询做如下的操作
        var key = $(element).closest("th[data-field]").data("field");
        var $table = $("table#" + tableId);
        var $dateControl = $(".fixed-table-body .bootstrap-table-filter-control-" + key);
        layDateOptions.done = function (value, date) {
            $dateControl.val(value);
            window.__searchValues[key] = value;
            setTimeout(function () {
                $table.bootstrapTable('refresh');
            }, Global.common.search_trigger_time);
        };

        laydate.render(layDateOptions)
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
        if (mainOptions.clickToSelect === undefined) {
            mainOptions.clickToSelect = true;//	设置true 将在点击行时，自动选择rediobox 和 checkbox
        }
        if (mainOptions.singleSelect === undefined) {
            mainOptions.singleSelect = false;
        }
        if (mainOptions.cardView === undefined) {
            mainOptions.cardView = false;//设置为 true将显示card视图，适用于移动设备。否则为table试图，适用于pc
            mainOptions.showToggle = false;//是否显示 切换试图（table/card）按钮
        }

        var opt = {
            height: Global.getHeight(),
            striped: true,//设置为 true 会有隔行变色效果
            // method: 'post',//默认是get
            cache: false,//设置为 false 禁用 AJAX 数据缓存
            // contentType: "application/x-www-form-urlencoded; charset=UTF-8",//post方式一定得改成这种contentType,默认是application/json
            pagination: true,
            paginationLoop: false,
            sidePagination: "server",
            pageList: '[1,5,10,25,50,100,150,200,500,1000]',
            selectItemName: Global.key.check_box,//radio or checkbox 的字段名
            escape: true,
            searchTimeOut: Global.common.search_trigger_time,//触发搜索时间，此处为1秒
            // searchTimeout: 0,//触发搜索延迟时间，我们不要延迟所说义设置为0秒
            trimOnSearch: false,//设置为 true 将允许空字符搜索
            idField: "id",
            uniqueId: "id",
            maintainSelected: true,//设置为 true 在点击分页按钮或搜索按钮时，将记住checkbox的选择项
            showColumns: true,//是否显示 内容列下拉框
            showRefresh: true,
            showMultiSort: true,//多列排序
            filterShowClear: true,//Set true to add a button to clear all the controls added by this plugin.
            onColumnSwitch: function (field, checked) {
                //清除搜索的文本
                $.each($table.bootstrapTable("getOptions").valuesFilterControl, function (i, item) {
                    item.value = '';
                });
                //清除搜索的日期
                $(".bootstrap-laydate").val("");
                window.__searchValues = {};
                $table.bootstrapTable("refresh");
            }
        };

        //组装options参数
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
        Global.initTable($table, mainOptions);
    },

    /**
     * 切换表格搜索控件显示/隐藏
     */
    toggleTableSearch: function () {
        var $header = $("div.bootstrap-table>div.fixed-table-container>div.fixed-table-header");
        if (window.__customControls___) {
            $header.css("height", "75px");
        } else {
            $header.css('height', '37px');
        }
    },

    /**
     * 通用的删除方法
     * 使用此方法的前提条件是，表格的主键id字段是id，不能是其他字符串
     * 另外就是传递到后台的参数一定为ids，也不能是其他字符串
     * @param $table
     * @param url
     * @param showName
     */
    deleteItems: function ($table, url, showName) {
        var selectItems = $table.bootstrapTable("getSelections");
        var ids = "", showNames = "";
        for (var item in selectItems) {
            ids += selectItems[item].id + ",";
            showNames += selectItems[item][showName] + "，"
        }
        ids = ids.substr(0, ids.length - 1);
        showNames = showNames.substr(0, showNames.length - 1);
        $.SmartMessageBox({
            title: "<i class='fa fa-minus-square-o' style='color:red'></i> 确定要删除选中的项目吗？",
            content: "<p>删除将不可恢复，你确定要删除所有选择的吗？</p><p>即将要删除的项目：[" + showNames + "]</p>",
            buttons: '[取消][确认]'
        }, function (ButtonPressed) {
            if (ButtonPressed === "确认") {
                axios.post(url + "?ids=" + ids)
                    .then(function (response) {
                        if (response.data.code === Global.status_code.success) {
                            layer.msg(response.data.message);
                            $table.bootstrapTable("refresh");
                        } else {
                            Global.show_error_msg(response.data.message)
                        }
                    })
                    .catch(function (error) {
                        Global.handleAxiosError(error)
                    });
            }

        });
    },

    /**
     * 表格列表页面获取高度
     * @returns {number}
     */
    getHeight: function () {
        return $(window).height() - $('header').outerHeight(true)
            - $('div.page-footer').outerHeight(true)
            - $('#ribbon').outerHeight(true)
    },

    /**
     * 新增数据，弹出对话框的时候，需要把上次填写的数据给清除，并且初始化数据
     * @param object
     * @param init 把对象初始化所对应的值，每种类型都有默认为“”、0、false、[]以及null
     */
    resetObject: function (object, init) {
        init = arguments[1] ? arguments[1] : {};
        if (init.str === undefined)
            init.str = "";
        if (init.num === undefined)
            init.num = 0;
        if (init.bool === undefined)
            init.bool = false;
        if (init.arr === undefined)
            init.arr = [];

        for (var obj in object) {
            if (typeof(object[obj]) !== "object" || object[obj] instanceof Array) {
                if (typeof(object[obj]) === "string")
                    object[obj] = init.str;
                else if (typeof(object[obj]) === "number")
                    object[obj] = init.num;
                else if (typeof(object[obj]) === "boolean")
                    object[obj] = init.bool;
                else if (object[obj] instanceof Array)
                    object[obj] = init.arr;
                else Object[obj] = null;
            } else {
                this.resetObject(object[obj], init);
            }
        }
    },

    /**
     * 处理axios的error返回
     * @param error
     */
    handleAxiosError: function (error) {
        if (error.response)
            Global.show_error_msg(error.response.data.message);
        else if (error.request)
            Global.show_error_msg(error.request);
        else
            Global.show_error_msg(error.message);
    },

    smartDialog: function (options) {
        if (options.id === undefined) {
            Global.show_error_msg("请为添加/编辑对话框添加ID属性");
            return false;
        }
        if (options.width === undefined)
            options.width = 600;
        if (options.autoOpen === undefined)
            options.autoOpen = false;
        if (options.resizable === undefined)
            options.resizable = false;
        if (options.modal === undefined)
            options.modal = true;
        if (options.title === undefined)
            options.title = "添加";
        if (options.confirm === undefined || (typeof options.confirm) !== "function") {
            Global.show_error_msg("没有添加确认的执行方法");
            return false;
        }
        if (options.cancel === undefined || (typeof options.cancel) !== "function") {
            options.cancel = function () {
                $("#" + options.id).dialog("close");
            };
        }
        $("#" + options.id).dialog({
            autoOpen: options.autoOpen,
            width: options.width,
            resizable: options.resizable,
            modal: options.modal,
            title: "<div class='widget-header'><h4><i class='icon-ok'></i> " + options.title + "</h4></div>",
            buttons: [{
                html: "<i class='fa fa-plus-square-o'></i>&nbsp; 确定",
                "class": "btn btn-info",
                click: function () {
                    options.confirm();
                }
            }, {
                html: "<i class='fa fa-times'></i>&nbsp; 取消",
                "class": "btn btn-default",
                click: function () {
                    options.cancel();
                }
            }]
        })
    }


};

//页面初始化之后脚本操作
$(function () {

    if (navigator.userAgent.indexOf('Mac OS') !== -1) {
        $(".fixed-navigation nav>ul").css("padding-right", "32px");
    }

    //bootstrap-table中文化
    $.extend($.fn.bootstrapTable.defaults, $.fn.bootstrapTable.locales['zh-CN']);


//初始化dialog的html形式的title
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


//监听高度resize事件动态改变table的大小以及重载zTree树，以配合显示
//表格的id一定要为xxxx-table的形式，否则监听事件无效
    $(window).resize(function () {
        var $table = $("table[id$='-table']");
        if ($table.length > 0) {
            $table.bootstrapTable('resetView', {
                height: Global.getHeight()
            });
        }
    });

    //搜索控件的显隐
    $.root_.on("click", "[id$='-search-control']", function () {
        window.__customControls___ = $(this).find("input[type=checkbox]").prop("checked");
        Global.toggleTableSearch();
    });

//菜单模块隐藏
    $(document).on("click", "body", function (event) {
        if ($(event.target).attr("id") !== "show-shortcut" && $(event.target).parent("a").attr("id") !== "show-shortcut") {
            $("#shortcut").slideUp(200);
        }
    })
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

//所有含有表格页面的如果需要格式化显示日期的可以使用格式化日期显示方式
function date_formatter(date) {
    var resD = '';
    if (date instanceof Object) {
        resD = date.year + "-"
            + (date.monthValue < 10 ? ("0" + date.monthValue) : date.monthValue) + "-"
            + (date.dayOfMonth < 10 ? ("0" + date.dayOfMonth) : date.dayOfMonth) + " ";
        if (date.hour >= 0 && date.minute >= 0 && date.second >= 0) {
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

//格式化是否可用一列显示方式
function enabledFormatter(val, row, index) {
    return val ? "<label class='label label-success'>可用</label>" : "<label class='label label-danger'>不可用</label>";
}

//预先给window增加属性
window.__searchValues = {};
window.__customControls___ = true;

//全局设置axios请求头
axios.defaults.headers['X-Requested-With'] = 'XMLHttpRequest';
//全局拦截axios的异常
axios.interceptors.response.use(function (response) {
    return response;
}, function (err) {
    if (err && err.response) {
        Global.show_error_msg(err.response.data.message);
    } else if (err.request) {
        Global.show_error_msg(err.request);
    } else {
        Global.show_error_msg(err.message);
    }
    return Promise.reject(err);
});

//全局ajax拦截处理
$(document).ajaxSuccess(function (event, xhr, options) {
    var respTxt = String(xhr.responseText);
    var data = {};
    try {
        data = eval('(' + respTxt + ')');
    } catch (error) {
        //说明不是json对象
    }
    if (data.code) {
        if (data.code === 301) {
            if (options.type === "POST") {
                Global.show_error_msg(data.message || "登录超时，请重新登录");
            } else if (options.type === "GET") {
                layer.msg(data.message || "登录超时，请重新登录")
            }
        } else if (data.code !== 200) {
            if (options.type === "POST") {
                Global.show_error_msg(data.message || "请求发生错误，请稍后重试");
            } else if (options.type === "GET") {
                layer.msg(data.message || "请求发生错误，请稍后重试")
            }
        }
    }
});

$(document).ajaxError(function (event, xhr, options, exc) {
    if (xhr.responseJSON !== undefined && xhr.responseJSON) {
        var resp = xhr.responseJSON;
        var status = resp.data.status;
        var errorMsg = resp.data.error;
        var exceptionMsg = resp.data.exception;
        Global.show_error_msg("请求发生异常！<br/>状态码：" + status + "<br/>错误信息：" + errorMsg + "<br/>异常信息：" + exceptionMsg);
    }
});

//重置错误提示
function resetError(error) {
    for (var err in error) {
        if (error[err] === false || error[err] === "")
            continue;
        if (err.indexOf("Msg") > -1) {
            error[err] = '';
        } else {
            error[err] = false;
        }
    }
}

//zTree保持展开单一路径
var curExpandNode = null;

function beforeExpand(treeId, treeNode) {
    var pNode = curExpandNode ? curExpandNode.getParentNode() : null;
    var treeNodeP = treeNode.parentTId ? treeNode.getParentNode() : null;
    var zTree = $.fn.zTree.getZTreeObj(treeId);
    for (var i = 0, l = !treeNodeP ? 0 : treeNodeP.children.length; i < l; i++) {
        if (treeNode !== treeNodeP.children[i]) {
            zTree.expandNode(treeNodeP.children[i], false);
        }
    }
    while (pNode) {
        if (pNode === treeNode) {
            break;
        }
        pNode = pNode.getParentNode();
    }
    if (!pNode) {
        singlePath(treeId, treeNode);
    }

}

function singlePath(treeId, newNode) {
    if (newNode === curExpandNode) return;

    var zTree = $.fn.zTree.getZTreeObj(treeId),
        rootNodes, tmpRoot, tmpTId, i, j, n;

    if (!curExpandNode) {
        tmpRoot = newNode;
        while (tmpRoot) {
            tmpTId = tmpRoot.tId;
            tmpRoot = tmpRoot.getParentNode();
        }
        rootNodes = zTree.getNodes();
        for (i = 0, j = rootNodes.length; i < j; i++) {
            n = rootNodes[i];
            if (n.tId !== tmpTId) {
                zTree.expandNode(n, false);
            }
        }
    } else if (curExpandNode && curExpandNode.open) {
        if (newNode.parentTId === curExpandNode.parentTId) {
            zTree.expandNode(curExpandNode, false);
        } else {
            var newParents = [];
            while (newNode) {
                newNode = newNode.getParentNode();
                if (newNode === curExpandNode) {
                    newParents = null;
                    break;
                } else if (newNode) {
                    newParents.push(newNode);
                }
            }
            if (newParents !== null) {
                var oldNode = curExpandNode;
                var oldParents = [];
                while (oldNode) {
                    oldNode = oldNode.getParentNode();
                    if (oldNode) {
                        oldParents.push(oldNode);
                    }
                }
                if (newParents.length > 0) {
                    zTree.expandNode(oldParents[Math.abs(oldParents.length - newParents.length) - 1], false);
                } else {
                    zTree.expandNode(oldParents[oldParents.length - 1], false);
                }
            }
        }
    }
    curExpandNode = newNode;
}

function onExpand(event, treeId, treeNode) {
    curExpandNode = treeNode;
}

var CookieUtils = {
    getMsec: function (DateStr) {
        var timeNum = DateStr.substring(0, DateStr.length - 1) * 1; //时间数量
        var timeStr = DateStr.substring(DateStr.length - 1, DateStr.length); //时间单位前缀，如h表示小时

        if (timeStr === "s") //20s表示20秒
        {
            return timeNum * 1000;
        }
        else if (timeStr === "h") //12h表示12小时
        {
            return timeNum * 60 * 60 * 1000;
        }
        else if (timeStr === "d") {
            return timeNum * 24 * 60 * 60 * 1000; //30d表示30天
        }
    },
    /**
     * 调用示例：CookieUtils.set("xx","xx",30d);
     * 上述表示存储时间为30day
     * @param name
     * @param value
     * @param time
     */
    set: function (name, value, time) {
        var msec = this.getMsec(time); //获取毫秒
        var exp = new Date();
        exp.setTime(exp.getTime() + msec * 1);
        document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
    },
    get: function (name) {
        var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)"); //正则匹配
        if (arr = document.cookie.match(reg)) {
            return unescape(arr[2]);
        }
        else {
            return null;
        }
    },
    del: function (name) {
        var exp = new Date();
        exp.setTime(exp.getTime() - 1);
        var cval = this.get(name);
        if (cval !== null) {
            document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
        }
    }
};
