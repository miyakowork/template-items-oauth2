package me.wuwenbin.items.oauth2.support.pojo.bo;


import me.wuwenbin.modules.pagination.query.model.bootstrap.BootstrapTableQuery;
import me.wuwenbin.modules.pagination.query.support.annotation.QueryColumn;
import me.wuwenbin.modules.pagination.query.support.operator.Operator;

/**
 * Created by Wuwenbin on 2017/7/20.
 */
public class SessionBO extends BootstrapTableQuery {

    private String username;
    private String ip;
    @QueryColumn(column = "last_visit_date", operator = Operator.BETWEEN_AND)
    private String lastVisitDate;
    @QueryColumn(column = "first_visit_date", operator = Operator.GTE)
    private String firstVisitDate;

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getLastVisitDate() {
        return lastVisitDate;
    }

    public void setLastVisitDate(String lastVisitDate) {
        this.lastVisitDate = lastVisitDate;
    }

    public String getFirstVisitDate() {
        return firstVisitDate;
    }

    public void setFirstVisitDate(String firstVisitDate) {
        this.firstVisitDate = firstVisitDate;
    }
}
