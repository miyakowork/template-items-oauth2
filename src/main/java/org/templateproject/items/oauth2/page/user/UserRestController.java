package org.templateproject.items.oauth2.page.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.items.oauth2.entity.IUser;
import org.templateproject.items.oauth2.service.UserService;
import org.templateproject.items.oauth2.service.shiro.ShiroUserService;
import org.templateproject.items.oauth2.support.BaseRestController;
import org.templateproject.items.oauth2.support.pojo.BootstrapTable;
import org.templateproject.items.oauth2.support.pojo.bo.UserBO;
import org.templateproject.items.oauth2.support.pojo.vo.UserVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

/**
 * Created by wuwenbin on 2017/8/8/.
 */
@RestController
@RequestMapping("oauth2/user/api")
public class UserRestController extends BaseRestController {

    /**
     * 注入UserService层
     */
    private UserService userService;
    private ShiroUserService shiroUserService;

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @Autowired
    public void setShiroUserService(ShiroUserService shiroUserService) {
        this.shiroUserService = shiroUserService;
    }


    /**
     * 显示数据
     *
     * @param page
     * @param userBO
     * @return
     */
    @RequestMapping("list")
    public BootstrapTable<UserVO> list(Page<UserVO> page, UserBO userBO) {
        page = userService.findUserPage(queryParam2Page(userBO, page), userBO);
        return bootstrapTable(page);
    }

    /**
     * 添加用户
     *
     * @param user
     * @return
     */
    @RequestMapping("add")
    public R add(IUser user) {
        if (shiroUserService.findByUserName(user.getUsername()) != null) {
            return R.error("此账号已存在！");
        }
        try {
            if (shiroUserService.addNewUser(user) == 1)
                return R.ok("添加用户成功！");
            else
                return R.error("添加用户失败！");
        } catch (Exception e) {
            LOGGER.error("添加用户出现异常，异常信息：{}", e);
            return R.error("添加用户异常，原因：" + e.getMessage());
        }
    }

    /**
     * 编辑用户
     *
     * @param iUser
     * @return
     */
    @RequestMapping("edit")
    public R doEdit(IUser iUser) {
        try {
            if (userService.edit(iUser))
                return R.ok("修改用户成功！");
            else
                return R.error("修改用户失败！");
        } catch (Exception e) {
            LOGGER.error("修改用户出现异常，异常信息：{}", e);
            return R.error("修改用户异常，原因：" + e.getMessage());
        }
    }


    /**
     * 修改用户密码
     *
     * @param username
     * @param newPwd
     * @return
     */
    @RequestMapping("editPwd")
    public R doEditPwd(String username, String newPwd) {
        IUser user = shiroUserService.findByUserName(username);
        if (user != null) {
            try {
                shiroUserService.changePasswordByUser(user, newPwd);
                return R.ok("修改用户密码成功！");
            } catch (Exception e) {
                LOGGER.error("修改用户密码出现异常，异常信息：{}", e);
                return R.error("修改用户密码异常，原因：" + e.getMessage());
            }
        } else {
            return R.ok("用户不存在，修改失败！");
        }
    }


    /**
     * 禁用用户
     *
     * @param ids
     * @return
     */
    @RequestMapping("delete")
    public R delete(String ids) {
        try {
            userService.disabledUser(ids);
            return R.ok("禁用用户成功！");
        } catch (Exception e) {
            LOGGER.error("禁用用户出现异常，异常信息：{}", e);
            return R.error("禁用用户异常，原因：" + e.getMessage());
        }
    }


}
