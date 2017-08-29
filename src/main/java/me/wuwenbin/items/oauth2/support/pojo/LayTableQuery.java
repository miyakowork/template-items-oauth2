package me.wuwenbin.items.oauth2.support.pojo;

/**
 * layui框架中table组件的查询参数
 * created by Wuwenbin on 2017/8/21 at 16:33
 */
public abstract class LayTableQuery {

    private int page;
    private int limit;

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }
}
