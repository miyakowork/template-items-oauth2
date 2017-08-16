package org.templateproject.items.oauth2.support.pojo.bo;


import org.templateproject.items.oauth2.support.annotation.query.QueryColumn;
import org.templateproject.items.oauth2.support.enumerate.Operator;
import org.templateproject.items.oauth2.support.pojo.PageQueryBO;

/**
 * Created by Wuwenbin on 2017/7/20.
 */
public class SessionBO extends PageQueryBO {

    private String username;
    private String ip;
    @QueryColumn(value = "last_visit_date", operation = Operator.BETWEEN)
    private String lastVisitDate;
    @QueryColumn(value = "first_visit_date", operation = Operator.GTE)
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
