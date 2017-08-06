package org.templateproject.oauth2.aop.support;

/**
 * created by Wuwenbin on 2017/8/5 at 17:16
 */
public class SQLSeat {

        private String sql;

        public String getSql() {
                return sql;
        }

        public void setSql(String sql) {
                this.sql = sql;
        }

        /**
         * 占位函数，给AOP留个参数位置自动填充sql
         *
         * @return SQLSeat
         */
        public static SQLSeat seat() {
                return new SQLSeat();
        }
}
