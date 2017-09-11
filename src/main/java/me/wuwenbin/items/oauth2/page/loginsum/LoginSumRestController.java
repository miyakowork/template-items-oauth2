package me.wuwenbin.items.oauth2.page.loginsum;

import me.wuwenbin.items.oauth2.service.LoginSumService;
import me.wuwenbin.items.oauth2.support.annotation.AuthResource;
import me.wuwenbin.items.oauth2.support.pojo.bo.LoginSumBO;
import me.wuwenbin.items.oauth2.support.pojo.vo.LoginSumVO;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by wuwenbin on 2017/7/19.
 */
@RestController
@RequestMapping("/oauth2/loginsum/api")
public class LoginSumRestController {

    private LoginSumService loginSumService;

    @Autowired
    public void setLoginSumService(LoginSumService loginSumService) {
        this.loginSumService = loginSumService;
    }

    @RequestMapping("charts")
    @RequiresPermissions("base:loginsum:charts")
    @AuthResource(name = "获取用户登录图标数据")
    public LoginSumVO getData(LoginSumBO loginSumBO) {
        return loginSumService.getData(loginSumBO);
    }

}
