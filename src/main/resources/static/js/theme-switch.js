var options =
    '<div class="demo">' +
    '<span id="demo-setting"><i class="fa fa-cogs fa-spin txt-color-blueDark"></i></span> ' +
    '<form>' +
    '<legend class="no-padding margin-bottom-10">主题切换</legend>' +
    '<section id="smart-styles">' +
    '<a href="javascript:void(0);" id="smart-style-0" data-skinlogo="/static/img/favicon/favicon.ico" class="btn btn-block btn-xs txt-color-white margin-right-5" style="background-color:#4E463F;"> 经典灰</a>' +
    '<a href="javascript:void(0);" id="smart-style-1" data-skinlogo="/static/img/favicon/favicon.ico" class="btn btn-block btn-xs txt-color-white" style="background:#3A4558;">优雅亮黑</a>' +
    '<a href="javascript:void(0);" id="smart-style-2" data-skinlogo="/static/img/favicon/favicon.ico" class="btn btn-xs btn-block txt-color-darken margin-top-5" style="background:#fff;"><i class="fa fa-check fa-fw" id="skin-checked"></i> 极致雅白</a>' +
    '<a href="javascript:void(0);" id="smart-style-3" data-skinlogo="/static/img/favicon/favicon.ico" class="btn btn-xs btn-block txt-color-white margin-top-5" style="background:#f78c40">谷歌主题</a>' +
    '<a href="javascript:void(0);" id="smart-style-4" data-skinlogo="/static/img/favicon/favicon.ico" class="btn btn-xs btn-block txt-color-white margin-top-5" style="background: #bbc0cf; border: 1px solid #59779E; color: #17273D !important;">粉碎像素</a> ' +
    '<a href="javascript:void(0);" id="smart-style-5" data-skinlogo="/static/img/favicon/favicon.ico" class="btn btn-xs btn-block txt-color-white margin-top-5" style="background: rgba(153, 179, 204, 0.2); border: 1px solid rgba(121, 161, 221, 0.8); color: #17273D !important;">透明玻璃 </a>' +
    '</section>' +
    '</form> ' +
    '</div>';
$("#main").append(options);

$("#smart-bgimages").fadeOut(), $("#demo-setting").click(function () {
    $(".demo").toggleClass("activate")
}), "top" === localStorage.getItem("sm-setmenu") ? $("#smart-topmenu").prop("checked", !0) : $("#smart-topmenu").prop("checked", !1), $("#smart-styles > a").on("click", function () {
    var a = $(this);
    $.root_.removeClassPrefix("smart-style").addClass(a.attr("id")), $("html").removeClassPrefix("smart-style").addClass(a.attr("id")), $('#smart-styles > a #skin-checked').remove(), a.prepend("<i class='fa fa-check fa-fw' id='skin-checked'></i>")
});