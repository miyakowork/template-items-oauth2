var toolbar =
    '<div :id="operateId.toolbar" class="form-inline">' +
    '<a :id="operateId.add" class="btn btn-primary btn-sm"><i class="fa fa-plus-square-o"></i> 添加</a> ' +
    '<a :id="operateId.edit" class="btn btn-warning btn-sm"><i class="fa fa-edit"></i> 编辑</a> ' +
    '<a v-if="showDelete" :id="operateId.del" class="btn btn-danger btn-sm"><i class="fa fa-minus-square-o"></i> 删除</a> ' +
    '</div>';

Vue.component('toolbar', {
    template: toolbar,
    computed: {
        operateId: function () {
            return {
                toolbar: this.name + "-toolbar",
                add: "add-" + this.name,
                edit: "edit-" + this.name,
                del: "delete-" + this.name
            };
        }
    },
    props: {
        //使用此组件的模块唯一标识
        name: {required: true},
        //工具栏是否显示删除按钮
        showDelete: {
            type: Boolean,
            required: true,
            default: true//默认显示
        }
    }
});


var bootstrapTable =
    '<section class="col-xs-12 col-sm-12 col-md-12 col-lg-12">' +
    '<table :id="tableId">' +
    '<template v-for="col in options.columns">' +
    '<tr>' +
    '<th :data-radio="col.radio"' +
    ' :data-checkbox="col.checkbox"' +
    ' :data-field="col.field"' +
    ' :data-title="col.title"' +
    ' :data-title-tooltip="col.titleTooltip"' +
    ' :data-class="col.class"' +
    ' :data-rowspan="col.rowspan"' +
    ' :data-colspan="col.colspan"' +
    ' :data-align="col.align ? col.align : columnDefault.align"' +
    ' :data-halign="col.halign ? col.halign : columnDefault.halign"' +
    ' :data-falign="col.falign"' +
    ' :data-valign="col.valign"' +
    ' :data-width="col.width"' +
    ' :data-sortable="col.sortable"' +
    ' :data-order="col.order"' +
    ' :data-visible="col.visible"' +
    ' :data-card-visible="col.cardVisible"' +
    ' :data-switchable="col.switchable"' +
    ' :data-click-to-select="col.clickToSelect"' +
    ' :data-formatter="col.formatter"' +
    ' :data-footer-formatter="col.footerFormatter"' +
    ' :data-events="col.events"' +
    ' :data-sorter="col.sorter"' +
    ' :data-sort-name="col.sortName"' +
    ' :data-cell-style="col.cellStyle"' +
    ' :data-searchable="col.searchable"' +
    ' :data-search-formatter="col.searchFormatter"' +
    '>{{col.field}}</th>' +
    '</tr>' +
    '</template> ' +
    '</table>' +
    '</section>';

Vue.component('bootstrap-table', {
    template: bootstrapTable,
    data: function () {
        return {
            columnDefault: {
                align: "center",
                halign: "middle"
            },
            tableDefault: {
                height: TF.getHeight()
            }
        };
    },
    computed: {
        tableId: function () {
            return this.name.concat("-table");
        },
        $bootstrapTable: function () {
            return $("table[id=" + this.tableId + "]");
        }
    },
    mounted: function () {
        window.onresize = function reSize() {
            if (this.$bootstrapTable.length > 0) {
                this.$bootstrapTable.bootstrapTable('resetView', {
                    height: TF.getHeight()
                });
            }
        }
    },
    //初始化BootstrapTable
    created: function () {
        // TF.initTable(this.$bootstrapTable, this.options);
        console.log(this.options);
    },
    props: {
        //table的唯一标识
        name: {required: true},
        options: {
            type: Object,
            default: {}
        }
    }
});