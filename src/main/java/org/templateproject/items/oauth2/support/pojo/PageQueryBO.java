package org.templateproject.items.oauth2.support.pojo;


import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * 查询Bo基本对象
 * Created by wuwenbin on 2017/7/6.
 */
public abstract class PageQueryBO {

    private int limit;//当前的页面大小，即每页显示多少条数据
    private int offset;//当前页的最后一条数据的序号
    private String order;//排序顺序 desc asc
    private String sort;//排序字段
    private List<MultiSort> multiSorts;//多列排序


    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public int getOffset() {
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public List<MultiSort> getMultiSorts() {
        return multiSorts;
    }

    public void setMultiSort(String multiSorts) {
        if (StringUtils.isEmpty(multiSorts)) {
            this.multiSorts = null;
        } else {
            String[] sorts = multiSorts.split(";");
            List<MultiSort> multiSortList = new ArrayList<>(sorts.length);
            for (String sort : sorts) {
                String[] singleSort = sort.split(",");
                MultiSort ms = new MultiSort();
                ms.setSortName(singleSort[0]);
                ms.setSortOrder(singleSort[1]);
                multiSortList.add(ms);
            }
            this.multiSorts = multiSortList;
        }
    }

    /**
     * 计算当前页码
     *
     * @return
     */
    public int pageNo() {
        return this.getOffset() / this.getLimit() + 1;
    }


}
