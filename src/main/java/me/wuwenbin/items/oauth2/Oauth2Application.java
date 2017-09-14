package me.wuwenbin.items.oauth2;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@SpringBootApplication
@EnableAspectJAutoProxy(exposeProxy = true)
public class Oauth2Application {

    //TODO:第一次使用系统的时候，用户不登录给使用者添加初始数据，要不然不能使用。在参数表中设置一个字段标识，如果用户设置完最基本数据则开启权限控制
    public static void main(String[] args) {
        SpringApplication.run(Oauth2Application.class, args);
    }

}
