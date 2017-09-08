/**
 * @author: Dennis Hernández
 * @webSite: http://djhvscf.github.io/Blog
 * @version: v2.1.1
 */

(function ($) {

    'use strict';

    var sprintf = $.fn.bootstrapTable.utils.sprintf,
        objectKeys = $.fn.bootstrapTable.utils.objectKeys;

    //一开始是没有的，是undefined，会报错，所以此处还应该做一个判断
    var getOptionsFromSelectControl = function (selectControl) {
        if (window.__customControls___ && selectControl.length > 0)
            return selectControl.get(selectControl.length - 1).options;
        else
            return '';
    };

    var hideUnusedSelectOptions = function (selectControl, uniqueValues) {
        var options = getOptionsFromSelectControl(selectControl);

        for (var i = 0; i < options.length; i++) {
            if (options[i].value !== "") {
                if (!uniqueValues.hasOwnProperty(options[i].value)) {
                    selectControl.find(sprintf("option[value='%s']", options[i].value)).hide();
                } else {
                    selectControl.find(sprintf("option[value='%s']", options[i].value)).show();
                }
            }
        }
    };

    var addOptionToSelectControl = function (selectControl, value, text) {
        value = $.trim(value);
        selectControl = $(selectControl.get(selectControl.length - 1));
        if (!existOptionInSelectControl(selectControl, value)) {
            selectControl.append($("<option></option>")
                .attr("value", value)
                .text($('<div />').html(text).text()));
        }
    };


    var sortSelectControl = function (selectControl) {
        var $opts = selectControl.find('option:gt(0)');
        $opts.sort(function (a, b) {
            a = $(a).text().toLowerCase();
            b = $(b).text().toLowerCase();
            if ($.isNumeric(a) && $.isNumeric(b)) {
                // Convert numerical values from string to float.
                a = parseFloat(a);
                b = parseFloat(b);
            }
            return a > b ? 1 : a < b ? -1 : 0;
        });

        selectControl.find('option:gt(0)').remove();
        selectControl.append($opts);
    };

    var existOptionInSelectControl = function (selectControl, value) {
        var options = getOptionsFromSelectControl(selectControl);
        for (var i = 0; i < options.length; i++) {
            if (options[i].value === value.toString()) {
                //The value is not valid to add
                return true;
            }
        }

        //If we get here, the value is valid to add
        return false;
    };

    var fixHeaderCSS = function (that) {
        // var filterDatepickerBetween = hasBetweenDatepicker(that);
        if (window.__customControls___) {
            // if (filterDatepickerBetween) {
            //     that.$tableHeader.css("height", "108px");
            // } else {
            that.$tableHeader.css("height", "75px");
            // }
        } else {
            that.$tableHeader.css('height', '37px');
        }
    };

    /**
     * 判断当前列的搜索控件是不是日期
     * @param colField
     * @param that
     */
    var isFieldDatepicker = function (colField, that) {
        var cols = that.columns;
        for (var c in cols) {
            var col = cols[c];
            if (colField.field === col.field) {
                if (col.filterControl) {
                    return col.filterControl === "datepicker";
                }
            }
        }
        return false;
    }


    var getCurrentHeader = function (that) {
        var header = that.$header;
        if (that.options.height) {
            header = that.$tableHeader;
        }

        return header;
    };

    var getCurrentSearchControls = function (that) {
        var searchControls = 'select, input';
        if (that.options.height) {
            searchControls = 'table select, table input, table .bootstrap-laydate';
        }

        return searchControls;
    };

    var getCursorPosition = function (el) {
        if ($.fn.bootstrapTable.utils.isIEBrowser()) {
            if ($(el).is('input')) {
                var pos = 0;
                if ('selectionStart' in el) {
                    pos = el.selectionStart;
                } else if ('selection' in document) {
                    el.focus();
                    var Sel = document.selection.createRange();
                    var SelLength = document.selection.createRange().text.length;
                    Sel.moveStart('character', -el.value.length);
                    pos = Sel.text.length - SelLength;
                }
                return pos;
            } else {
                return -1;
            }
        } else {
            return -1;
        }
    };

    var setCursorPosition = function (el, index) {
        if ($.fn.bootstrapTable.utils.isIEBrowser()) {
            if (el.setSelectionRange !== undefined) {
                el.setSelectionRange(index, index);
            } else {
                $(el).val(el.value);
            }
        }
    };

    //把搜索值存入到options对象中以便搜索完毕之后还是现实在table的搜索条件中，不至于变为空白
    var copyValues = function (that) {
        var header = getCurrentHeader(that),
            searchControls = getCurrentSearchControls(that);

        that.options.valuesFilterControl = [];

        header.find(searchControls).each(function () {
            if ($(this).hasClass("date-filter-control-start")) {
                that.options.valuesFilterControl.push({
                    field: $(this).closest('[data-field]').data('field'),
                    value: $(this).val(),
                    between: "start",
                    position: getCursorPosition($(this).get(0))
                });
            }
            else if ($(this).hasClass("date-filter-control-end")) {
                that.options.valuesFilterControl.push({
                    field: $(this).closest('[data-field]').data('field'),
                    value: $(this).val(),
                    between: "end",
                    position: getCursorPosition($(this).get(0))
                });
            }
            else {
                that.options.valuesFilterControl.push({
                    field: $(this).closest('[data-field]').data('field'),
                    value: $(this).val(),
                    between: "singleOrNone",
                    position: getCursorPosition($(this).get(0))
                });
            }
        });

    };

    //搜索完毕之后把搜索的内容原封不动的放入搜索框中，做成一种搜索框没有被清楚的错觉，感觉上次搜索的内容还在，没被清除
    var setValues = function (that) {
        var field = null,
            result = [],
            header = getCurrentHeader(that),
            searchControls = getCurrentSearchControls(that);

        //增加此处全局的赋值，主要是为了日期，因为日期是用laydate重写过的，不会被源码中的onColumnSearch之后的事件所触发到
        //也就是不会把搜索的记录存到页面上，刷新之后不会有搜索记录，所以需要重新加上
        //循环遍历搜索值，填入日期的搜索值
        $.each(that.options.valuesFilterControl, function (index, vfc) {
            //如果循环到当前的列为datepicker
            if (isFieldDatepicker(vfc, that)) {
                if (window.__searchValues) {
                    (that.options.valuesFilterControl)[index].value = window.__searchValues[vfc.field]
                }
            } else {
                return true;
            }
        })

        if (that.options.valuesFilterControl.length > 0) {
            header.find(searchControls).each(function (index, ele) {
                field = $(this).closest('[data-field]').data('field');
                result = $.grep(that.options.valuesFilterControl, function (valueObj, valueIndex) {
                    return valueObj.field === field;
                });

                if (result.length > 0 && result.length < 2) {
                    $(this).val(result[0].value);
                    //如果是日期搜索，且只有一个，那则是这种赋值方式,此处以改为input输入，所以与上面的赋值方式一样，以前则为.text()方式
                    if ($(this).hasClass("bootstrap-laydate")) {
                        $(this).val(result[0].value);
                    }
                    setCursorPosition($(this).get(0), result[0].position);
                }
            });
        }
    };

    var collectBootstrapCookies = function cookiesRegex() {
        var cookies = [],
            foundCookies = document.cookie.match(/(?:bs.table.)(\w*)/g);

        if (foundCookies) {
            $.each(foundCookies, function (i, cookie) {
                if (/./.test(cookie)) {
                    cookie = cookie.split(".").pop();
                }

                if ($.inArray(cookie, cookies) === -1) {
                    cookies.push(cookie);
                }
            });
            return cookies;
        }
    };

    var initFilterSelectControls = function (that) {
        var data = that.data,
            itemsPerPage = that.pageTo < that.options.data.length ? that.options.data.length : that.pageTo,

            isColumnSearchableViaSelect = function (column) {
                return column.filterControl && column.filterControl.toLowerCase() === 'select' && column.searchable;
            },

            isFilterDataNotGiven = function (column) {
                return column.filterData === undefined || column.filterData.toLowerCase() === 'column';
            },

            hasSelectControlElement = function (selectControl) {
                return selectControl && selectControl.length > 0;
            };

        var z = that.options.pagination ?
            (that.options.sidePagination === 'server' ? that.pageTo : that.options.totalRows) :
            that.pageTo;

        $.each(that.header.fields, function (j, field) {
            var column = that.columns[$.fn.bootstrapTable.utils.getFieldIndex(that.columns, field)],
                selectControl = $('.bootstrap-table-filter-control-' + escapeID(column.field));

            if (isColumnSearchableViaSelect(column) && isFilterDataNotGiven(column) && hasSelectControlElement(selectControl)) {
                if (selectControl.get(selectControl.length - 1).options.length === 0) {
                    //Added the default option
                    addOptionToSelectControl(selectControl, '', '');
                }

                var uniqueValues = {};
                for (var i = 0; i < z; i++) {
                    //Added a new value
                    var fieldValue = data[i][field],
                        formattedValue = $.fn.bootstrapTable.utils.calculateObjectValue(that.header, that.header.formatters[j], [fieldValue, data[i], i], fieldValue);

                    uniqueValues[formattedValue] = fieldValue;
                }

                for (var key in uniqueValues) {
                    addOptionToSelectControl(selectControl, uniqueValues[key], key);
                }

                sortSelectControl(selectControl);

                if (that.options.hideUnusedSelectOptions) {
                    hideUnusedSelectOptions(selectControl, uniqueValues);
                }
            }
        });
    };

    var escapeID = function (id) {
        return String(id).replace(/(:|\.|\[|\]|,)/g, "\\$1");
    };

    var createControls = function (that, header) {
        var addedFilterControl = false,
            isVisible,
            html,
            timeoutId = 0;

        $.each(that.columns, function (i, column) {
            isVisible = 'hidden';
            html = [];

            if (!column.visible) {
                return;
            }
            if (!column.filterControl/* || !window.__customControls___*/) {
                html.push('<div class="no-filter-control"></div>');
            } else {
                html.push('<div class="filter-control">');

                var nameControl = column.filterControl.toLowerCase();
                if (column.searchable && that.options.filterTemplate[nameControl]) {
                    addedFilterControl = true;
                    isVisible = 'visible';
                    html.push(that.options.filterTemplate[nameControl](that, column.field, isVisible, column.filterControlPlaceholder));
                }
            }

            $.each(header.children().children(), function (i, tr) {
                tr = $(tr);
                if (tr.data('field') === column.field) {
                    tr.find('.fht-cell').append(html.join(''));
                    return false;
                }
            });

            if (column.filterData !== undefined && column.filterData.toLowerCase() !== 'column') {

                var filterDataType = getFilterDataMethod(filterDataMethods, column.filterData.substring(0, column.filterData.indexOf(':')));
                var filterDataSource, selectControl;

                if (filterDataType !== null) {
                    filterDataSource = column.filterData.substring(column.filterData.indexOf(':') + 1, column.filterData.length);
                    selectControl = $('.bootstrap-table-filter-control-' + escapeID(column.field));

                    addOptionToSelectControl(selectControl, '', '请选择');
                    filterDataType(filterDataSource, selectControl);
                } else {
                    throw new SyntaxError('Error. You should use any of these allowed filter data methods: var, json, url.' + ' Use like this: var: {key: "value"}');
                }

                var variableValues, key;
                switch (filterDataType) {
                    case 'url':
                        $.ajax({
                            url: filterDataSource,
                            dataType: 'json',
                            success: function (data) {
                                for (var key in data) {
                                    addOptionToSelectControl(selectControl, key, data[key]);
                                }
                                sortSelectControl(selectControl);
                            }
                        });
                        break;
                    case 'var':
                        variableValues = window[filterDataSource];
                        for (key in variableValues) {
                            addOptionToSelectControl(selectControl, key, variableValues[key]);
                        }
                        sortSelectControl(selectControl);
                        break;
                    case 'jso':
                        // variableValues = JSON.parse(filterDataSource);
                        variableValues = eval('(' + filterDataSource + ')')
                        for (key in variableValues) {
                            addOptionToSelectControl(selectControl, key, variableValues[key]);
                        }
                        sortSelectControl(selectControl);
                        break;
                }
            }
        });

        if (addedFilterControl) {
            header.off('keyup', 'input').on('keyup', 'input', function (event) {
                if (!$(this).hasClass("date-filter-control-start")) {
                    clearTimeout(timeoutId);
                    timeoutId = setTimeout(function () {
                        that.onColumnSearch(event);
                    }, that.options.searchTimeOut);
                }
            });


            header.off('change', 'select').on('change', 'select', function (event) {
                clearTimeout(timeoutId);
                timeoutId = setTimeout(function () {
                    that.onColumnSearch(event);
                }, that.options.searchTimeOut);
            });
        } else {
            header.find('.filterControl').hide();
        }
    };

    var getDirectionOfSelectOptions = function (alignment) {
        alignment = alignment === undefined ? 'left' : alignment.toLowerCase();

        switch (alignment) {
            case 'left':
                return 'ltr';
            case 'right':
                return 'rtl';
            case 'auto':
                return 'auto';
            default:
                return 'ltr';
        }
    };

    var filterDataMethods =
        {
            'var': function (filterDataSource, selectControl) {
                var variableValues = window[filterDataSource];
                for (var key in variableValues) {
                    addOptionToSelectControl(selectControl, key, variableValues[key]);
                }
                sortSelectControl(selectControl);
            },
            'url': function (filterDataSource, selectControl) {
                selectControl.empty();
                addOptionToSelectControl(selectControl, '', '请选择');
                $.ajax({
                    url: filterDataSource,
                    dataType: 'json',
                    success: function (data) {
                        for (var key in data) {
                            addOptionToSelectControl(selectControl, key, data[key]);
                        }
                        sortSelectControl(selectControl);
                    }
                });
            },
            'json': function (filterDataSource, selectControl) {
                var variableValues = JSON.parse(filterDataSource);
                for (var key in variableValues) {
                    addOptionToSelectControl(selectControl, key, variableValues[key]);
                }
                sortSelectControl(selectControl);
            }
        };

    var getFilterDataMethod = function (objFilterDataMethod, searchTerm) {
        var keys = Object.keys(objFilterDataMethod);
        for (var i = 0; i < keys.length; i++) {
            if (keys[i] === searchTerm) {
                return objFilterDataMethod[searchTerm];
            }
        }
        return null;
    };

    $.extend($.fn.bootstrapTable.defaults, {
        filterControl: false,
        onColumnSearch: function (field, text) {
            return false;
        },
        filterShowClear: false,
        alignmentSelectControlOptions: undefined,
        filterTemplate: {
            input: function (that, field, isVisible, placeholder) {
                return sprintf('<input class="form-control bootstrap-table-filter-control-%s" style="width: 100%; visibility: %s" placeholder="%s">', field, isVisible, placeholder);
            },
            select: function (that, field, isVisible) {
                return sprintf('<select class="form-control bootstrap-table-filter-control-%s" style="width: 100%; visibility: %s" dir="%s"></select>',
                    field, isVisible, getDirectionOfSelectOptions(that.options.alignmentSelectControlOptions));
            },
            datepicker: function (that, field, isVisible) {
                var laydateOptions = {};
                var cols = that.columns;
                for (var col in cols) {
                    if (cols[col].field === field) {
                        laydateOptions = cols[col].laydateOptions
                    }
                }
                var layOpt = eval("(" + laydateOptions + ")");
                var table_id = $(that.$el[0]).attr("id");
                return sprintf('<input placeholder="' + layOpt.placeholder + '" readonly onclick="Global.activeLaydatePicker(this,\'' + table_id + '\',' + laydateOptions + ')" class="bootstrap-laydate form-control date-filter-control date-filter-control-single bootstrap-table-filter-control-%s" style="width: 100%; visibility: %s"/>', field, isVisible);

            }
        },
        //internal variables
        valuesFilterControl: []
    });

    $.extend($.fn.bootstrapTable.COLUMN_DEFAULTS, {
        filterControl: undefined,
        filterData: undefined,
        filterDatepickerOptions: undefined,
        filterStrictSearch: false,
        filterStartsWithSearch: false,
        filterControlPlaceholder: ""
        // filterDatepickerBetween: false
    });

    $.extend($.fn.bootstrapTable.Constructor.EVENTS, {
        'column-search.bs.table': 'onColumnSearch'
    });

    $.extend($.fn.bootstrapTable.defaults.icons, {
        clear: 'glyphicon-trash icon-clear'
    });

    $.extend($.fn.bootstrapTable.locales, {
        formatClearFilters: function () {
            return 'Clear Filters';
        }
    });
    $.extend($.fn.bootstrapTable.defaults, $.fn.bootstrapTable.locales);

    var BootstrapTable = $.fn.bootstrapTable.Constructor,
        _init = BootstrapTable.prototype.init,
        _initToolbar = BootstrapTable.prototype.initToolbar,
        _initHeader = BootstrapTable.prototype.initHeader,
        _initBody = BootstrapTable.prototype.initBody,
        _initSearch = BootstrapTable.prototype.initSearch;

    BootstrapTable.prototype.init = function () {
        //Make sure that the filterControl option is set
        if (this.options.filterControl) {
            var that = this;

            // Compatibility: IE < 9 and old browsers
            if (!Object.keys) {
                objectKeys();
            }

            //Make sure that the internal variables are set correctly
            this.options.valuesFilterControl = [];

            this.$el.on('reset-view.bs.table', function () {
                //Create controls on $tableHeader if the height is set
                if (!that.options.height) {
                    return;
                }

                //Avoid recreate the controls
                if (that.$tableHeader.find('select').length > 0 || that.$tableHeader.find('input').length > 0) {
                    return;
                }
//TODO 此处注释掉，防止搜索的时候提交两次（其中第一次被取消，接着第二次才请求成功）
                //createControls(that, that.$tableHeader);
            }).on('post-header.bs.table', function () {
                setValues(that);
            }).on('post-body.bs.table', function () {
                if (that.options.height) {
                    fixHeaderCSS(that);
                }
            }).on('column-switch.bs.table', function () {
                setValues(that);
            })
        }
        _init.apply(this, Array.prototype.slice.apply(arguments));
    };

    BootstrapTable.prototype.initToolbar = function () {
        this.showToolbar = this.options.filterControl && this.options.filterShowClear;

        _initToolbar.apply(this, Array.prototype.slice.apply(arguments));

        if (this.options.filterControl && this.options.filterShowClear) {
            var $btnGroup = this.$toolbar.find('>.btn-group'),
                $btnClear = $btnGroup.find('.filter-show-clear');

            if (!$btnClear.length) {
                $btnClear = $([
                    '<button class="btn btn-default filter-show-clear" ',
                    sprintf('type="button" title="%s">', this.options.formatClearFilters()),
                    sprintf('<i class="%s %s"></i> ', this.options.iconsPrefix, this.options.icons.clear),
                    '</button>'
                ].join('')).appendTo($btnGroup);

                $btnClear.off('click').on('click', $.proxy(this.clearFilterControl, this));
            }
        }
    };

    BootstrapTable.prototype.initHeader = function () {
        _initHeader.apply(this, Array.prototype.slice.apply(arguments));

        if (!this.options.filterControl) {
            return;
        }
        createControls(this, this.$header);
    };

    BootstrapTable.prototype.initBody = function () {
        _initBody.apply(this, Array.prototype.slice.apply(arguments));

        initFilterSelectControls(this);
    };

    BootstrapTable.prototype.initSearch = function () {
        _initSearch.apply(this, Array.prototype.slice.apply(arguments));

        if (this.options.sidePagination === 'server') {
            return;
        }

        var that = this;
        var fp = $.isEmptyObject(this.filterColumnsPartial) ? null : this.filterColumnsPartial;

        //Check partial column filter
        this.data = fp ? $.grep(this.data, function (item, i) {
            for (var key in fp) {
                var thisColumn = that.columns[$.fn.bootstrapTable.utils.getFieldIndex(that.columns, key)];
                var fval = fp[key].toLowerCase();
                var value = item[key];

                // Fix #142: search use formated data
                if (thisColumn && thisColumn.searchFormatter) {
                    value = $.fn.bootstrapTable.utils.calculateObjectValue(that.header,
                        that.header.formatters[$.inArray(key, that.header.fields)],
                        [value, item, i], value);
                }

                if (thisColumn.filterStrictSearch) {
                    if (!($.inArray(key, that.header.fields) !== -1 &&
                            (typeof value === 'string' || typeof value === 'number') &&
                            value.toString().toLowerCase() === fval.toString().toLowerCase())) {
                        return false;
                    }
                } else if (thisColumn.filterStartsWithSearch) {
                    if (!($.inArray(key, that.header.fields) !== -1 &&
                            (typeof value === 'string' || typeof value === 'number') &&
                            (value + '').toLowerCase().indexOf(fval) === 0)) {
                        return false;
                    }
                } else {
                    if (!($.inArray(key, that.header.fields) !== -1 &&
                            (typeof value === 'string' || typeof value === 'number') &&
                            (value + '').toLowerCase().indexOf(fval) !== -1)) {
                        return false;
                    }
                }
            }
            return true;
        }) : this.data;
    };

    BootstrapTable.prototype.initColumnSearch = function (filterColumnsDefaults) {
        copyValues(this);

        if (filterColumnsDefaults) {
            this.filterColumnsPartial = filterColumnsDefaults;
            this.updatePagination();

            for (var filter in filterColumnsDefaults) {
                this.trigger('column-search', filter, filterColumnsDefaults[filter]);
            }
        }
    };

    BootstrapTable.prototype.onColumnSearch = function (event) {
        if ($.inArray(event.keyCode, [37, 38, 39, 40]) > -1) {
            return;
        }

        copyValues(this);
        var text = $.trim($(event.currentTarget).val());
        var $field = $(event.currentTarget).closest('[data-field]').data('field');

        if ($.isEmptyObject(this.filterColumnsPartial)) {
            this.filterColumnsPartial = {};
        }
        if (text) {
            this.filterColumnsPartial[$field] = text;
        } else {
            delete this.filterColumnsPartial[$field];
        }

        // if the searchText is the same as the previously selected column value,
        // bootstrapTable will not try searching again (even though the selected column
        // may be different from the previous search).  As a work around
        // we're manually appending some text to bootstrap's searchText field
        // to guarantee that it will perform a search again when we call this.onSearch(event)
        this.searchText += "randomText";

        this.options.pageNumber = 1;
        this.onSearch(event);
        this.trigger('column-search', $field, text);
    };

    BootstrapTable.prototype.clearFilterControl = function () {
        if (this.options.filterControl && this.options.filterShowClear) {
            var that = this,
                cookies = collectBootstrapCookies(),
                header = getCurrentHeader(that),
                table = header.closest('table'),
                controls = header.find(getCurrentSearchControls(that)),
                search = that.$toolbar.find('.search input'),
                timeoutId = 0;

            $.each(that.options.valuesFilterControl, function (i, item) {
                item.value = '';
            });

            //清除搜索的日期
            $(".bootstrap-laydate").val("");
            window.__searchValues = {};
            setValues(that);

            // Clear each type of filter if it exists.
            // Requires the body to reload each time a type of filter is found because we never know
            // which ones are going to be present.
            if (controls.length > 0) {
                this.filterColumnsPartial = {};
                $(controls[0]).trigger(controls[0].tagName === 'INPUT' ? 'keyup' : 'change');
            } else {
                return;
            }

            if (search.length > 0) {
                that.resetSearch();
            }

            // use the default sort order if it exists. do nothing if it does not
            if (that.options.sortName !== table.data('sortName') || that.options.sortOrder !== table.data('sortOrder')) {
                var sorter = header.find(sprintf('[data-field="%s"]', $(controls[0]).closest('table').data('sortName')));
                if (sorter.length > 0) {
                    that.onSort(table.data('sortName'), table.data('sortName'));
                    $(sorter).find('.sortable').trigger('click');
                }
            }

            // clear cookies once the filters are clean
            clearTimeout(timeoutId);
            timeoutId = setTimeout(function () {
                if (cookies && cookies.length > 0) {
                    $.each(cookies, function (i, item) {
                        if (that.deleteCookie !== undefined) {
                            that.deleteCookie(item);
                        }
                    });
                }
            }, that.options.searchTimeOut);
        }
    };
})(jQuery);
