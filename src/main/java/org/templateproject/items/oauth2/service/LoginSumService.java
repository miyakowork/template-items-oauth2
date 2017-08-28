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
    private List<String> dateToTimeSpan(LoginSumBO loginSumBO) {
        List<String> timeSpanList = new ArrayList<>();
        LocalDate endDate = LocalDate.parse(loginSumBO.getEndTime());
        for (int i = 0; i < loginSumBO.getNum(); i++) {
            LocalDate date = endDate.minusDays(i);
            timeSpanList.add(date.toString());
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
    private String dateFormatter(String date) {
        return date.substring(5, date.length()).replace('-', '.');
    }


    /**
     * 根据departmentId查询下所所有子节点，包括子节点的子节点
     *
     * @param list
     * @param id
     * @return
     */
    private List<IDepartment> getDeptId(List<IDepartment> list, Integer id) {
        String sql = "SELECT * FROM t_oauth_department tod WHERE  tod.parent_id  = ?";
        List<IDepartment> departments = mysql.findListBeanByArray(sql, IDepartment.class, id);
        list.addAll(departments);
        for (IDepartment department : departments) {
            getDeptId(list, department.getId());
        }
        return list;
    }

    /**
     * 结合getDeptId方法将departmentId改为适用于数据库的IN的格式:1,2,3
     *
     * @param id
     * @return
     */
    private String deptIdFormatter(Integer id) {
        StringBuilder deptIds = new StringBuilder(" " + id);
        List<IDepartment> list = new ArrayList<>();
        for (IDepartment iDepartment : getDeptId(list, id)) {
            deptIds.append(",").append(iDepartment.getId());
        }
        return deptIds.toString();
    }


    /**
     * 根据查询条件获取LoginSumVO数据
     *
     * @param loginSumBO
     * @return
     */
    public LoginSumVO getData(LoginSumBO loginSumBO) {
        List<String> date = dateToTimeSpan(loginSumBO);
        String[] sums = new String[loginSumBO.getNum()];
        String[] dates = new String[loginSumBO.getNum()];
        int[] mounts = new int[loginSumBO.getNum()];
        LoginSumVO loginChart = new LoginSumVO();
        String deptIds = deptIdFormatter(loginSumBO.getDeptId());
        for (int i = 0; i < loginSumBO.getNum(); i++) {
            String sumSql = "SELECT COUNT(1) AS cnt FROM t_oauth_user_login_log " +
                    "WHERE t_oauth_user_login_log.user_id " +
                    "IN (SELECT t_oauth_user.id FROM t_oauth_user WHERE t_oauth_user.dept_id IN (" + deptIds + ")) " +
                    "AND date_format(t_oauth_user_login_log.last_login_date,'%Y-%m-%d') = ?";

            sums[i] = mysql.findMapByArray(sumSql, date.get(i)).get("cnt").toString();

            String mountSql = "SELECT user_id,count(1) as cnt FROM t_oauth_user_login_log " +
                    "WHERE t_oauth_user_login_log.user_id " +
                    "IN (SELECT t_oauth_user.id FROM t_oauth_user WHERE t_oauth_user.dept_id IN (" + deptIds + ")) " +
                    "AND date_format(t_oauth_user_login_log.last_login_date,'%Y-%m-%d') = ? GROUP BY t_oauth_user_login_log.user_id";
            mounts[i] = mysql.findListMapByArray(mountSql, date.get(i)).size();
            dates[i] = date.get(i);
        }

        loginChart.setLoginSum(sums);
        loginChart.setLoginMount(mounts);
        loginChart.setLoginDate(dates);
        return loginChart;
    }

}
