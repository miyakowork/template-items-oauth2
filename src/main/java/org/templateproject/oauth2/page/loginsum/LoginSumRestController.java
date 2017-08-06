package org.templateproject.oauth2.page.loginsum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.templateproject.oauth2.service.LoginSumService;
import org.templateproject.oauth2.support.pojo.bo.LoginSumBO;
import org.templateproject.oauth2.support.pojo.vo.LoginSumVO;

/**
 * Created by Liurongqi on 2017/7/19.
 */
@RestController
@RequestMapping("/loginsum/api")
public class    LoginSumRestController {
    private LoginSumService loginSumService;

    @Autowired
    public void setLoginSumService(LoginSumService loginSumService) {
        this.loginSumService = loginSumService;
    }

    @RequestMapping("charts")
    public LoginSumVO getData(LoginSumBO loginSumBO){
        return loginSumService.getData(loginSumBO);
    }

}
