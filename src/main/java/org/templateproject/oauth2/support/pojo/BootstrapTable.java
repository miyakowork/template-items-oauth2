package org.templateproject.oauth2.support.pojo;

import java.util.List;

/**
 * 前台Bootstrap table对应的数据模型
 * Created by wuwenbin on 2017/7/6.
 */
public class BootstrapTable<T> {

        private long total;//数据总量，提供页脚的分页显示参数
        private List<T> rows;//当前页的数据集合

        public BootstrapTable(long total, List<T> rows) {
                this.total = total;
                this.rows = rows;
        }

        public long getTotal() {
                return total;
        }

        public void setTotal(long total) {
                this.total = total;
        }

        public List<T> getRows() {
                return rows;
        }

        public void setRows(List<T> rows) {
                this.rows = rows;
        }
}
