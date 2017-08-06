
pageSetUp();

// page_function
var page_function = function () {

    var $table = $("#log-table");

    //设置表格的搜索参数
    var query_params = function (params) {
        return {
            limit: params.limit,
            offset: params.offset,
            order: params.order,
            sort: params.sort,
            username: $("input.bootstrap-table-filter-control-username").val(),
            lastLoginDate: TF.datepickerSearch("lastLoginDate")
        };
    };

    //设置日期搜索控件的参数
    var datepicker_between = [{
        field: "lastLoginDate",
        between: true
    }];

    //搜索控件显影的监听事件
    $("#log-search-control").on("click", function () {
        window.__customControls___ = $(this).find("input[type=checkbox]").prop("checked");
        TF.reInitTable($table, {
            url: "/log/api/list",
            toolbar: '#log-toolbar',
            queryParams: query_params,
            filterControl: true,
            sortName:'last_login_date',
            sortOrder:'desc',
            datepickerBetween: datepicker_between
        })
    });


    //加载表格
    TF.initTable($table, {
        url: "/log/api/list",
        toolbar: '#log-toolbar',
        queryParams: query_params,
        filterControl: true,
        sortName:'last_login_date',
        sortOrder:'desc',
        datepickerBetween: datepicker_between
    });


};


page_function();
