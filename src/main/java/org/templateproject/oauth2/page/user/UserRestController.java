package org.templateproject.oauth2.page.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.entity.OauthUser;
import org.templateproject.oauth2.service.UserService;
import org.templateproject.oauth2.support.TemplateController;
import org.templateproject.oauth2.support.pojo.bo.UserBO;
import org.templateproject.oauth2.support.pojo.BootstrapTable;
import org.templateproject.oauth2.support.pojo.vo.UserVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

import java.util.List;

/**
 * Created by yuanqi on 2017/7/19/019.
 */
@RestController
@RequestMapping("user/api")

public class UserRestController extends TemplateController {

    /**
     * 注入UserService层
     */
    private UserService userService;

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }


    /**
     * 显示数据
     * @param page
     * @param userBO
     * @return
     */
    @RequestMapping("list")
    public BootstrapTable<UserVO> list(Page<UserVO> page, UserBO userBO){

        page = userService.getPage(queryParam2Page(userBO,page),userBO);
        List<UserVO> result = page.getTResult();
        return new BootstrapTable<>(page.getTotalCount(), result);
    }

    /**
     * 添加数据
     */
    @RequestMapping("add")
    public R add(UserVO userVO){
        boolean flag= false;
        try {
            flag = userService.save1(userVO);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            if (flag)
                return R.ok("添加成功");
            else {
                return R.error("添加失败");
            }
        }
    }

    /**
     * 编辑
     * @return
     */
    @RequestMapping("doEdit")
    public R doEdit(OauthUser oauthUser)  {

        boolean flag = false;
        try {
            flag = userService.edit1(oauthUser);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            if (flag) {
                return R.ok("更新成功");
            } else {
                return R.ok("更新失败");
            }
        }
    }

    /**
     * 删除
     */
    @RequestMapping("delete")
    public R delete(String id){
        try {
            userService.delete(id);
        }catch (Exception e){
            e.printStackTrace();
        }
        return R.ok("删除成功");
    }

    /**
     * 从角色表获取添加用户模块下的角色下拉菜单
     */
    @RequestMapping("getRole")
    public R getRole(){
        return R.ok(userService.getRole1());
    }

}
