package org.templateproject.oauth2.support.pojo.bo;

import org.templateproject.oauth2.support.pojo.PageQueryBO;

/**
 * Created by Liurongqi on 2017/7/19.
 */
public class LoginSumBO extends PageQueryBO {
    private String endTime; //截止时间
    private Integer num;  //查询周期时长
    private Integer deptId; //部门id


    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }
}
