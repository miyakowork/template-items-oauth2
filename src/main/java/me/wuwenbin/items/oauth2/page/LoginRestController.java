package me.wuwenbin.items.oauth2.page;

import me.wuwenbin.items.oauth2.constant.ShiroConsts;
import me.wuwenbin.items.oauth2.support.BaseRestController;
import me.wuwenbin.items.oauth2.util.UserUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authc.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.WebUtils;
import org.templateproject.pojo.response.R;

import javax.servlet.http.HttpServletRequest;

/**
 * 登录API控制层接口
 * Created by wuwenbin on 2017/5/25.
 */
@RestController
public class LoginRestController extends BaseRestController {

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public R doLogin(HttpServletRequest request) {

        String userName = UserUtils.getLoginUserName();
        if (StringUtils.isNotEmpty(userName)) {
            LOGGER.info("用户 [" + userName + "] 已登录，跳转至首页");
            return R.ok("请勿重复登录");
        }
        String exceptionName = (String) request.getAttribute(ShiroConsts.LOGIN_FAILURE);
        if (UnknownAccountException.class.getName().equals(exceptionName)) {
            LOGGER.error("帐号不存在");
            return R.error("用户名/密码错误");
        } else if (IncorrectCredentialsException.class.getName().equals(exceptionName)) {
            LOGGER.error("密码/凭证错误");
            return R.error("用户名/密码错误");
        } else if (ExcessiveAttemptsException.class.getName().equals(exceptionName)) {
            LOGGER.error("验证失败次数超过限制");
            return R.error("输入错误次数过多，请稍后尝试");
        } else if (LockedAccountException.class.getName().equals(exceptionName)) {
            LOGGER.error("帐号已被锁定");
            return R.error("帐号被锁定");
        } else if (AuthenticationException.class.getName().equals(exceptionName)) {
            LOGGER.error("帐号验证失败");
            return R.error("账户验证失败");
        } else if (exceptionName != null) {
            LOGGER.error("未知的错误：" + exceptionName);
            return R.error("发生未知错误");
        }

        if (WebUtils.findParameterValue(request, ShiroConsts.SESSION_FORCE_LOGOUT_KEY) != null) {
            LOGGER.error("已被管理员强制退出");
            return R.error("您已被管理员强制退出，请重新登录");
        }

        return R.ok("登录成功");
    }
}
