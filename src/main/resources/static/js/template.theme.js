var options =
    '<div class="demo">' +
    '<span id="demo-setting"><i class="fa fa-cogs fa-spin txt-color-blueDark"></i></span> ' +
    '<form>' +
    '<legend class="no-padding margin-bottom-10">主题切换</legend>' +
    '<section id="smart-styles">' +
    '<a href="javascript:void(0);" id="smart-style-0" data-skinlogo="/static/img/favicon/favicon.ico" class="btn btn-block btn-xs txt-color-white margin-right-5" style="background-color:#4E463F;"> 经典雅灰</a>' +
    '<a href="javascript:void(0);" id="smart-style-1" data-skinlogo="/static/img/favicon/favicon.ico" class="btn btn-block btn-xs txt-color-white" style="background:#3A4558;">优雅亮黑</a>' +
    '<a href="javascript:void(0);" id="smart-style-2" data-skinlogo="/static/img/favicon/favicon.ico" class="btn btn-xs btn-block txt-color-darken margin-top-5" style="background:#fff;"> 极致雅白</a>' +
    '<a href="javascript:void(0);" id="smart-style-3" data-skinlogo="/static/img/favicon/favicon.ico" class="btn btn-xs btn-block txt-color-white margin-top-5" style="background:#f78c40">谷歌主题</a>' +
    '<a href="javascript:void(0);" id="smart-style-4" data-skinlogo="/static/img/favicon/favicon.ico" class="btn btn-xs btn-block txt-color-white margin-top-5" style="background: #bbc0cf; border: 1px solid #59779E; color: #17273D !important;">粉碎像素</a> ' +
    '<a href="javascript:void(0);" id="smart-style-5" data-skinlogo="/static/img/favicon/favicon.ico" class="btn btn-xs btn-block txt-color-white margin-top-5" style="background: rgba(153, 179, 204, 0.2); border: 1px solid rgba(121, 161, 221, 0.8); color: #17273D !important;">透明玻璃 </a>' +
    '<a href="javascript:void(0);" id="smart-style-6" data-skinlogo="/static/img/logo-pale.png" class="btn btn-xs btn-block txt-color-white margin-top-6" style="background: #2196F3; border: 1px solid rgba(0, 0, 0, 0.3); color: #FFF !important;">MaterialDesign  </a>' +
    '</section>' +
    '</form> ' +
    '</div>';

$("#main").append(options);
$("#smart-bgimages").fadeOut();

var currentUserId = "";
var $smartStyles = $("#smart-styles");
var theme = localStorage.getItem("currentThemeByUser-" + currentUserId);
if (theme !== undefined && theme !== "" && theme !== null) {
    $.root_.removeClassPrefix("smart-style").addClass(theme);
    $("html").removeClassPrefix("smart-style").addClass(theme);
    $smartStyles.find("a#" + theme).prepend("<i class='fa fa-check fa-fw' id='skin-checked'></i>")
} else {
    $.root_.removeClassPrefix("smart-style").addClass("smart-style-0");
    $("html").removeClassPrefix("smart-style").addClass("smart-style-0");
    $smartStyles.find("a#smart-style-0").prepend("<i class='fa fa-check fa-fw' id='skin-checked'></i>")
}


$("#demo-setting").click(function () {
    $(".demo").toggleClass("activate");
});

$smartStyles.find("a").on("click", function () {
    var a = $(this);
    localStorage.setItem("currentThemeByUser-" + currentUserId, a.attr("id"));
    $.root_.removeClassPrefix("smart-style").addClass(a.attr("id"));
    $("html").removeClassPrefix("smart-style").addClass(a.attr("id"));
    $('#smart-styles').find("a").find('#skin-checked').remove();
    a.prepend("<i class='fa fa-check fa-fw' id='skin-checked'></i>");
});