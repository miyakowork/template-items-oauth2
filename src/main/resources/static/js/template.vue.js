//注册全局的Vue方法/属性
Vue.mixin({
    computed: {
        errors: function () {
            return this.$vuerify.$errors // 错误信息会在 $vuerify.$errors 内体现
        }
    },
    methods: {
        //判断表单中某个字段是否存在错误
        isHasError: function (errorMsg) {
            return Boolean(errorMsg);
        }
    }
});

//form-item
var formItem = {
    input:
    '   <div :class="col">' +
    '       <div class="form-group" :class="hasError">' +
    '           <label class="col-md-3 control-label" v-text="label"></label>' +
    '           <div class="col-md-9">' +
    '               <input class="form-control" :placeholder="placeholder" :value="value" @input="updateValue($event.target.value)">' +
    '               <div class="note-error margin-bottom-0" :class="hasErrorMsg" v-text="message"></div>' +
    '           </div>' +
    '       </div>' +
    '   </div> '
    ,
    select:
    '   <div :class="col">' +
    '       <div class="form-group" :class="hasError">' +
    '           <label class="col-md-3 control-label" v-text="label"></label>' +
    '           <div class="col-md-9">' +
    '               <slot></slot>' +
    '               <div class="note-error margin-bottom-0" :class="hasErrorMsg" v-text="message"></div>' +
    '           </div>' +
    '       </div>' +
    '   </div> '
    ,
    radio:
    '   <div :class="col">' +
    '       <div class="form-group" :class="hasError">' +
    '           <label class="col-md-3 control-label" v-text="label"></label>' +
    '           <div class="col-md-9">' +
    '               <label class="radio radio-inline"><slot name="check"></slot><span>是</span></label>' +
    '                   <label class="radio radio-inline"><slot name="nocheck"></slot><span>否</span></label>' +
    '               <div class="note-error margin-bottom-0" :class="hasErrorMsg" v-text="message"></div>' +
    '           </div>' +
    '       </div>' +
    '   </div> '
};

Vue.component('form-input', {
    template: formItem.input,
    computed: {
        hasError: function () {
            return this.isHasError(this.message) ? 'has-error' : '';
        },
        hasErrorMsg: function () {
            return this.isHasError(this.message) ? 'has-error text-danger margin-top-10' : '';
        },
        col: function () {
            return this.double === "true" ? 'col-md-6' : 'col-md-12';
        }
    },
    methods: {
        updateValue: function (value) {
            this.$emit("input", value);
        }
    },
    props: {
        //是否以两列形式摆放元素
        double: {
            type: Boolean,
            default: false
        },
        label: {
            type: String,
            default: ''
        },
        placeholder: {
            type: String,
            default: ''
        },
        value: Object,
        message: {
            type: String,
            default: ''
        }
    }
});
Vue.component('form-select', {
    template: formItem.select,
    computed: {
        hasError: function () {
            return this.isHasError(this.message) ? 'has-error' : '';
        },
        hasErrorMsg: function () {
            return this.isHasError(this.message) ? 'has-error text-danger margin-top-10' : '';
        },
        col: function () {
            return this.double === "true" ? 'col-md-6' : 'col-md-12';
        }
    },
    props: {
        //是否以两列形式摆放元素
        double: {
            type: Boolean,
            default: false
        },
        label: {
            type: String,
            default: ''
        },
        message: {
            type: String,
            default: ''
        }
    }
});
Vue.component('form-radio', {
    template: formItem.radio,
    computed: {
        hasError: function () {
            return this.isHasError(this.message) ? 'has-error' : '';
        },
        hasErrorMsg: function () {
            return this.isHasError(this.message) ? 'has-error text-danger margin-top-10' : '';
        },
        col: function () {
            return this.double === "true" ? 'col-md-6' : 'col-md-12';
        }
    },
    props: {
        //是否以两列形式摆放元素
        double: {
            type: Boolean,
            default: false
        },
        label: {
            type: String,
            default: ''
        },
        message: {
            type: String,
            default: ''
        }
    }
});


//表格的toolbar组件
var toolbar =
    '<div :id="operateId.toolbar" class="form-inline">' +
    '   <a :id="operateId.add" class="btn btn-primary btn-sm" @click="openAddDialog"><i class="fa fa-plus-square-o"></i> 添加</a> ' +
    '   <a :id="operateId.edit" class="btn btn-warning btn-sm" @click="openEditDialog"><i class="fa fa-edit"></i> 编辑</a> ' +
    '   <a v-if="showDelete" :id="operateId.del" class="btn btn-danger btn-sm" @click="deleteItem"><i class="fa fa-minus-square-o"></i> 删除</a> ' +
    ' &nbsp;' +
    '   <label :id="operateId.searchControl" class="checkbox-inline" @click="toggleSearchControl">' +
    '   <input type="checkbox" class="checkbox style-3"> ' +
    '   <span>显示搜索控件</span> ' +
    '   </label> ' +
    '</div>';

Vue.component('toolbar', {
    template: toolbar,
    computed: {
        operateId: function () {
            return {
                toolbar: this.name + "-toolbar",
                add: "add-" + this.name,
                edit: "edit-" + this.name,
                del: "delete-" + this.name,
                searchControl: this.name + "-search-control"
            };
        }
    },
    methods: {
        toggleSearchControl: function () {
            window.__customControls___ = $("#" + this.operateId.searchControl).find("input[type=checkbox]").prop("checked");
            Global.toggleTableSearch();
        },
        openAddDialog: function () {
            this.functions.add();
        },
        openEditDialog: function () {
            this.functions.edit();
        },
        deleteItem: function () {
            this.functions.del();
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
        },
        functions: {
            type: Object
        }
    }
});

//bootstrapTable组件
var bootstrapTable =
    '<section class="col-xs-12 col-sm-12 col-md-12 col-lg-12">' +
    '   <table :id="tableId">' +
    '       <template v-for="col in options.columns">' +
    '           <tr>' +
    '               <th :data-radio="col.radio"' +
    '                   :data-checkbox="col.checkbox"' +
    '                   :data-field="col.field"' +
    '                   :data-title="col.title"' +
    '                   :data-title-tooltip="col.titleTooltip"' +
    '                   :data-class="col.class"' +
    '                   :data-rowspan="col.rowspan"' +
    '                   :data-colspan="col.colspan"' +
    '                   :data-align="col.align"' +
    '                   :data-halign="col.halign"' +
    '                   :data-falign="col.falign"' +
    '                   :data-valign="col.valign"' +
    '                   :data-width="col.width"' +
    '                   :data-sortable="col.sortable"' +
    '                   :data-order="col.order"' +
    '                   :data-visible="col.visible"' +
    '                   :data-card-visible="col.cardVisible"' +
    '                   :data-switchable="col.switchable"' +
    '                   :data-click-to-select="col.clickToSelect"' +
    '                   :data-formatter="col.formatter"' +
    '                   :data-footer-formatter="col.footerFormatter"' +
    '                   :data-events="col.events"' +
    '                   :data-sorter="col.sorter"' +
    '                   :data-sort-name="col.sortName"' +
    '                   :data-cell-style="col.cellStyle"' +
    '                   :data-searchable="col.searchable"' +
    '                   :data-search-formatter="col.searchFormatter"' +
    '                   :data-filter-control="col.filterControl"' +
    '                   :data-filter-data="col.filterData"' +
    '                   :data-laydate-options="col.laydateOptions"' +
    '                  ></th>' +
    '              </tr>' +
    '          </template> ' +
    '      </table>' +
    '</section>';

Vue.component('bootstrap-table', {
    template: bootstrapTable,
    data: function () {
        return {
            tableDefault: {
                height: Global.getHeight()
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
    //初始化BootstrapTable
    mounted: function () {
        Global.initTable(this.$bootstrapTable, this.options);
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