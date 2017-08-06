package org.templateproject.oauth2.support.pojo.vo;


/**
 * Created by Liurongqi on 2017/7/19.
 */
public class LoginSumVO {
    private Integer[] loginSum;  //每日访问数数组
    private String[] loginDate;  //日期数组

    public Integer[] getLoginSum() {
        return loginSum;
    }

    public void setLoginSum(Integer[] loginSum) {
        this.loginSum = loginSum;
    }

    public String[] getLoginDate() {
        return loginDate;
    }

    public void setLoginDate(String[] loginDate) {
        this.loginDate = loginDate;
    }
}
