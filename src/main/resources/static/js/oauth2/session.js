pageSetUp();

var page_function = function () {

    var $table = $("#session-table");

    //搜索控件显影的监听事件
    $("#session-search-control").on("click", function () {
        window.__customControls___ = $(this).find("input[type=checkbox]").prop("checked");
        Global.toggleTableSearch();
    });

    //设置表格的搜索参数
    var query_params = function (params) {
        return {
            limit: params.limit,
            offset: params.offset,
            order: params.order,
            sort: params.sort,
            username: $("input.bootstrap-table-filter-control-username").val(),
            ip: $("input.bootstrap-table-filter-control-ip").val(),
            lastVisitDate: Global.datepickerSearch("lastVisitDate"),
            firstVisitDate: Global.datepickerSearch("firstVisitDate")
        };
    };

    //设置日期搜索控件的参数
    var datepicker_between = [{
        field: "lastVisitDate",
        between: true
    }, {
        field: "firstVisitDate",
        between: false
    }];

    //加载表格
    Global.initTable($table, {
        url: "/oauth2/session/api/list",
        toolbar: '#session-toolbar',
        queryParams: query_params,
        filterControl: true,
        datepickerBetween: datepicker_between
    });

    //强制提出用户
    $("#delete-session").click(function () {
        var ss = $table.bootstrapTable('getSelections');
        if (ss.length === 0) {
            Global.show_error_message("错误选择", "请选择用户然后再剔除")
        } else {
            var sessions = {
                usernames: '',
                sessionIds: ''
            };

            for (var s in ss) {
                sessions.usernames += ss[s].username + ","
                sessions.sessionIds += ss[s].sessionId + ","
            }

            Global.show_confirm_msg(
                "<i class='fa fa-minus-square-o' style='color:red'></i> 确认剔除下列所列用户?",
                $this.data('reset.msg') || "确认要剔除[" + sessions.usernames.substr(0, sessions.usernames.length - 1) + "]用户?",
                function (ButtonPressed) {

                    if (ButtonPressed === "确定") {
                        var params = new URLSearchParams();
                        params.append("sessionId", sessions.sessionIds.substr(0, sessions.sessionIds.length - 1));
                        axios.post("/session/api/forcelogout", params)
                            .then(function (response) {

                                if (response.data.code === Global.status_code.success) {
                                    layer.msg(response.data.message);
                                    $table.bootstrapTable("refresh");
                                }

                            })
                    }

                }
            );

        }
    });


};


/**
 * 格式化session编码显示方式
 * @param session64
 * @returns {string}
 */
function sessionBase64formatter(session64) {
    return session64.substr(0, 5).concat("******").concat(session64.substr(session64.length - 5, 5))
}


page_function();