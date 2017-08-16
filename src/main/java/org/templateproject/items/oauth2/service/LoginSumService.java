package org.templateproject.items.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.items.oauth2.entity.IDepartment;
import org.templateproject.items.oauth2.entity.IUserLoginLog;
import org.templateproject.items.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.items.oauth2.support.pojo.bo.LoginSumBO;
import org.templateproject.items.oauth2.support.pojo.vo.LoginSumVO;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Liurongqi on 2017/7/19.
 */

@Service
@Transactional
public class LoginSumService extends SimpleBaseCrudService<IUserLoginLog, Integer> {


    /**
     * 根据LoginSumBO内的截止时间以及查询周期天数获得待查的时间list
     *
     * @param loginSumBO
     * @return
     */
    public List<String> dateToTimeSpan(LoginSumBO loginSumBO) {
        List<String> timeSpanList = new ArrayList<>();
        LocalDate endDate = LocalDate.parse(loginSumBO.getEndTime());
        for (int i = 0; i < loginSumBO.getNum(); i++) {
            LocalDate date = endDate.minusDays(i);
            timeSpanList.add(date.getYear() + "-" + date.getMonthValue() + "-" + date.getDayOfMonth());
        }
        Collections.reverse(timeSpanList);
        return timeSpanList;
    }

    /**
     * 将2017-07-20格式转换为7.20以便echarts加载x轴
     *
     * @param date
     * @return
     */
    public String dateFormatter(String date) {
        return date.substring(5, date.length()).replace('-', '.');
    }


    /**
     * 根据departmentId查询下所所有子节点，包括子节点的子节点
     *
     * @param list
     * @param id
     * @return
     */
    public List<IDepartment> getDeptId(List<IDepartment> list, Integer id) {
        String sql = "SELECT * FROM t_oauth_department tod WHERE 1=1 AND tod.parent_id  = ?";
        List<IDepartment> departments = mysql.findListBeanByArray(sql, IDepartment.class, id);
        list.addAll(departments);
        Iterator<IDepartment> iterator = departments.iterator();
        while (iterator.hasNext()) {
            getDeptId(list, iterator.next().getId());
        }
        return list;
    }

    /**
     * 结合getDeptId方法将departmentId改为适用于数据库的IN的格式:1,2,3
     *
     * @param id
     * @return
     */
    public String deptIdFormatter(Integer id) {
        String deptIds = " " + id;
        List<IDepartment> list = new ArrayList<>();
        Iterator<IDepartment> oauthDepartmentIterator = getDeptId(list, id).iterator();
        while (oauthDepartmentIterator.hasNext()) {
            deptIds = deptIds + "," + oauthDepartmentIterator.next().getId();
        }
        return deptIds;
    }


    /**
     * 根据查询条件获取LoginSumVO数据
     *
     * @param loginSumBO
     * @return
     */
    public LoginSumVO getData(LoginSumBO loginSumBO) {
        List<String> TimeSpan = dateToTimeSpan(loginSumBO);
        Integer[] sumList = new Integer[loginSumBO.getNum()];
        String[] dateList = new String[loginSumBO.getNum()];
        LoginSumVO loginSumVO = new LoginSumVO();
        String deptIds = deptIdFormatter(loginSumBO.getDeptId());
        for (int i = 0; i < loginSumBO.getNum(); i++) {
            String sql = "SELECT COUNT(*) FROM T_OAUTH_USER_LOGIN_LOG WHERE 1=1 AND T_OAUTH_USER_LOGIN_LOG.USER_ID IN (" +
                    "SELECT T_OAUTH_USER.ID FROM T_OAUTH_USER WHERE T_OAUTH_USER.DEPT_ID IN (" + deptIds + ")" +
                    ") AND T_OAUTH_USER_LOGIN_LOG.LAST_LOGIN_DATE = ?";

            sumList[i] = (mysql.queryNumberByArray(sql, Integer.class, TimeSpan.get(i)));
            dateList[i] = (dateFormatter(TimeSpan.get(i)));
        }

        loginSumVO.setLoginSum(sumList);
        loginSumVO.setLoginDate(dateList);
        return loginSumVO;
    }

}
