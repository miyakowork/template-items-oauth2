var toolbar =
    '<div :id="operateId.toolbar" class="form-inline">' +
    '<a :id="operateId.add" class="btn btn-primary btn-sm"><i class="fa fa-plus-square-o"></i> 添加</a> ' +
    '<a :id="operateId.edit" class="btn btn-warning btn-sm"><i class="fa fa-edit"></i> 编辑</a> ' +
    '<a v-if="deleted == \'true\'" :id="operateId.del" class="btn btn-danger btn-sm"><i class="fa fa-minus-square-o"></i> 删除</a> ' +
    '</div>';
// '</div>' +
// '<section class="col-xs-12 col-sm-12 col-md-12 col-lg-12">' +
// '<table :id="operateId.table"></table>' +
// '</section>';

Vue.component('toolbar', {
    template: toolbar,
    computed: {
        operateId: function () {
            return {
                toolbar: this.name + "-toolbar",
                add: "add-" + this.name,
                edit: "edit-" + this.name,
                del: "delete-" + this.name,
                table: this.name + "-table"
            };
        }
    },
    props: {
        //使用此组件的模块唯一标识
        name: {required: true},
        //工具栏是否显示删除按钮
        deleted: {
            type: Boolean,
            required: true,
            default: true//默认显示，其余的字符串不显示
        },
    }
});


var bootstrapTable =
    '<section class="col-xs-12 col-sm-12 col-md-12 col-lg-12">' +
    '<table :id="tableId"></table>' +
    '</section>';

Vue.component('bootstrap-table', {
    template: bootstrapTable,
    computed: {
        tableId: function () {
            return this.name + "-table";
        }
    },
    props: {
        //table的唯一标识
        name: {required: true}
    }
});