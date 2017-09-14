package me.wuwenbin.items.oauth2.page.user;

import me.wuwenbin.items.oauth2.entity.IUser;
import me.wuwenbin.items.oauth2.service.UserService;
import me.wuwenbin.items.oauth2.service.shiro.ShiroUserService;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import me.wuwenbin.items.oauth2.support.pojo.bo.UserBO;
import me.wuwenbin.items.oauth2.support.pojo.vo.UserVO;
import me.wuwenbin.modules.pagination.model.bootstrap.BootstrapTable;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.pojo.page.Page;
import org.templateproject.pojo.response.R;

/**
 * Created by wuwenbin on 2017/8/8/.
 */
@RestController
@RequestMapping("oauth2/user/api")
public class UserRestController extends BaseRestController {

    /**
     * 注入Service层
     */
    private UserService userService;
    private ShiroUserService shiroUserService;

    @Autowired
    public UserRestController(UserService userService, ShiroUserService shiroUserService) {
        this.userService = userService;
        this.shiroUserService = shiroUserService;
    }


    @RequestMapping("info")
    @RequiresPermissions("base:user:info")
    @AuthResource(name = "获取当前登录用户登录信息")
    public IUser getCurrentUserInfo() {
//        Object username = ShiroUtils.getSubject().getPrincipal();
        return /*username == null ? null :*/ shiroUserService.findByUserName("sa");
    }

    /**
     * 显示数据
     *
     * @param page
     * @param userBO
     * @return
     */
    @RequestMapping("list")
    @RequiresPermissions("base:user:list")
    @AuthResource(name = "获取用户列表页面数据")
    public BootstrapTable<UserVO> list(Page<UserVO> page, UserBO userBO) {
        page = userService.findUserPage(page, userBO);
        return bootstrapTable(page);
    }

    /**
     * 添加用户
     *
     * @param user
     * @return
     */
    @RequestMapping("add")
    @RequiresPermissions("base:user:add")
    @AuthResource(name = "添加用户")
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
    @RequiresPermissions("base:user:edit")
    @AuthResource(name = "编辑用户")
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
    @RequiresPermissions("base:user:editPwd")
    @AuthResource(name = "修改用户密码")
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
    @RequiresPermissions("base:user:delete")
    @AuthResource(name = "禁用用户")
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
