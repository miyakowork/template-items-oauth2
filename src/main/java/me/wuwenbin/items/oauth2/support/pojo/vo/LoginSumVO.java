package me.wuwenbin.items.oauth2.support.pojo.vo;


/**
 * Created by Wuwenbin on 2017/8/19.
 */
public class LoginSumVO {
    private String[] loginSum;  //每日访问人数数组
    private int[] loginMount;//每日访问人次数组
    private String[] loginDate;  //日期数组

    public String[] getLoginSum() {
        return loginSum;
    }

    public void setLoginSum(String[] loginSum) {
        this.loginSum = loginSum;
    }

    public int[] getLoginMount() {
        return loginMount;
    }

    public void setLoginMount(int[] loginMount) {
        this.loginMount = loginMount;
    }

    public String[] getLoginDate() {
        return loginDate;
    }

    public void setLoginDate(String[] loginDate) {
        this.loginDate = loginDate;
    }
}
