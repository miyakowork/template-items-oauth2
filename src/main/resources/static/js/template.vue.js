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

var menuItem = '\
    <ul>\
       <li v-for="menu in menus">\
           <a :href="menuHref(menu.href)"  :title="menu.name" :onclick="hasOnclick(menu.onclick) ? menu.onclick:\'\'" :target="menuTarget(menu.target)" v-bind="{skip:menuTarget(menu.target)==\'\'}">\
               <i :class="menuIcon(menu.icon,menu.id)"></i>\
               <span class="menu-item-parent" v-text="menu.name"></span>\
           </a>\
           <menu-item :menus="menu.childMenus" v-if="hasChild(menu.childMenus)"></menu-item>\
       </li>\
    </ul>\
    ';

Vue.component('menu-item', {
    template: menuItem,
    methods: {
        hasChild: function (menu) {
            return menu !== undefined && menu.length > 0;
        },
        menuIcon: function (icon, id) {
            if (icon !== '' && icon !== null) {
                return icon;
            } else {
                return id !== 0 ? 'fa fa-fw fa-lg fa-list-ul' : 'fa fa-fw fa-list-ul';
            }
        },
        menuHref: function (href) {
            if (href !== '' && href !== null) {
                return href;
            } else {
                return '#';
            }
        },
        menuTarget: function (target) {
            if (target !== '' && target !== null) {
                return target;
            } else {
                return '';
            }
        },
        hasOnclick: function (onclick) {
            return onclick !== '' && onclick !== null;
        }
    },
    props: ['menus'],
    created: function () {
        window.__initLeftNav = true;
    },
    mounted: function () {
        //防止多次初始化
        if (window.__initLeftNav) {
            initApp.leftNav();
            if ($.navAsAjax) {
                // fire this on page load if nav exists
                if ($('nav').length) {
                    checkURL();
                    window.__initLeftNav = false;
                }
            }
        }
    }
});


var menuModule = '\
    <ul>\
       <li v-for="(module, index) in modules">\
           <a @click="switchModule(module.id)" class="jarvismetro-tile big-cubes" :class="color(index)">\
                <span class="iconbox">\
                    <i :class="module.iconMini" class="fa-4x"></i>\
                     <span v-text="moduleName(module.name,module.id)" style="text-align: center;"></span>\
                </span>\
           </a>\
       </li>\
    </ul>\
    ';

Vue.component('menu-module', {
    template: menuModule,
    props: ['modules'],
    data: function () {
        return {
            colors: [
                'bg-color-blue',
                'bg-color-orange',
                'bg-color-blueDark',
                'bg-color-green',
                'bg-color-purple',
                'bg-color-red',
                'bg-color-teal',
                'bg-color-magenta',
                'bg-color-pink'
            ],
            systemCode: 'SYS_BASE'
        }
    },
    methods: {
        switchModule: function (moduleId) {
            if (CookieUtils.get(Global.key.LEFT_NAV_MODULE_ID) !== null && moduleId === Number(CookieUtils.get(Global.key.LEFT_NAV_MODULE_ID))) {
                layer.msg("目标为当前模块，不必切换！");
            } else {
                CookieUtils.del(Global.key.LEFT_NAV_MODULE_ID);
                CookieUtils.set(Global.key.LEFT_NAV_MODULE_ID, moduleId, '7d');
                window.location.reload();
            }
        },
        color: function (index) {
            var categories = this.colors.length;
            var num = index % categories;
            return this.colors[num];
        },
        moduleName: function (name, id) {
            return name.concat(id === Number(CookieUtils.get(Global.key.LEFT_NAV_MODULE_ID)) ? " √" : "");
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
    '               <input class="form-control" :readonly="readonly" :placeholder="placeholder" :value="value" @input="updateValue($event.target.value)">' +
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
    '               <label class="radio radio-inline"><slot name="nocheck"></slot><span>否</span></label>' +
    '               <div class="note-error margin-bottom-0" :class="hasErrorMsg" v-text="message"></div>' +
    '           </div>' +
    '       </div>' +
    '   </div> '
    ,
    fetch:
    '<div :class="col">' +
    '   <div class="form-group" :class="hasError">' +
    '       <label class="col-md-3 control-label" v-text="label"></label>' +
    '       <div class="col-md-9">' +
    '           <div class="input-group">' +
    '               <input class="form-control"  :readonly="readonly" :placeholder="placeholder" :value="value" @input="updateValue($event.target.value)">' +
    '               <div class="input-group-btn">' +
    '                   <a @click.prevent="clickToFetch" class="btn btn-default">' +
    '                       <i class="fa fa-check-square-o"></i>&nbsp;获取' +
    '                   </a>' +
    '               </div>' +
    '           </div>' +
    '           <div class="note-error margin-bottom-0" :class="hasErrorMsg" v-text="message"></div>' +
    '       </div>' +
    '   </div> ' +
    '</div>'
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
        readonly: {
            default: false
        },
        value: {},
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
Vue.component('form-fetch', {
    template: formItem.fetch,
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
        },
        clickToFetch: function () {
            this.fetch();
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
        readonly: {
            default: false
        },
        value: {
            type: [String, Number],
            default: ''
        },
        message: {
            type: String,
            default: ''
        },
        fetch: {
            type: Function
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
    mounted: function () {
        $("#" + this.operateId.searchControl).find("input[type=checkbox]").prop("checked", window.__customControls___);
        Global.toggleTableSearch();
    },
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
            if (this.functions.del) {
                this.functions.del();
            } else {
                void(0);
            }
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
    '      </table>';

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

var panel =
    '<div class="panel" :class="theme">' +
    '   <div class="panel-heading">' +
    '       <slot name="heading"></slot>' +
    '   </div>' +
    '   <div class="panel-body" style="min-height: 300px;">' +
    '       <slot name="body"></slot>' +
    '   </div> ' +
    '</div>';

Vue.component('panel', {
    template: panel,
    props: {
        theme: {
            type: String,
            default: "panel-default"
        }
    }
})