package me.wuwenbin.items.oauth2.support.pojo.bo;


import me.wuwenbin.modules.pagination.query.model.bootstrap.BootstrapTableQuery;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryColumn;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryTable;
import me.wuwenbin.modules.pagination.query.support.operator.Operator;

/**
 * Created by Administrator on 2017/7/19/019.
 */
@QueryTable(aliasName = "tou")
public class UserBO extends BootstrapTableQuery {

    private String username;//用户名

    private String cname;

    @QueryColumn(operator = Operator.EQ)
    private String enabled;

    @QueryColumn(operator = Operator.GTE, column = "create_date")
    private String createDate;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getEnabled() {
        return enabled;
    }

    public void setEnabled(String enabled) {
        this.enabled = enabled;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }
}
