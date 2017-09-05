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
            lastLoginDate: Global.datepickerSearch("lastLoginDate")
        };
    };


    //搜索控件显影的监听事件
    $("#log-search-control").on("click", function () {
        window.__customControls___ = $(this).find("input[type=checkbox]").prop("checked");
        Global.toggleTableSearch();
    });


    //加载表格
    Global.initTable($table, {
        url: "/oauth2/log/api/list",
        toolbar: '#log-toolbar',
        queryParams: query_params,
        filterControl: true,
        sortName: 'last_login_date',
        sortOrder: 'desc'
    });

};


page_function();
