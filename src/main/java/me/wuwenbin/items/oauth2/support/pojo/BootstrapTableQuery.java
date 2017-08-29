package me.wuwenbin.items.oauth2.support.pojo;


import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * 查询Bo基本对象
 * Created by wuwenbin on 2017/7/6.
 */
public abstract class BootstrapTableQuery {

    private int limit;//当前的页面大小，即每页显示多少条数据
    private int offset;//当前页的最后一条数据的序号
    private String order;//排序顺序 desc asc
    private String sort;//排序字段
    private List<MultiSort> multiSorts;//多列排序

    private int pageNo;//根据前台传的参数 limit和offset计算而得出

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
        if (pageNo > 0)
            return pageNo;
        else
            return this.getOffset() / this.getLimit() + 1;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }


}
