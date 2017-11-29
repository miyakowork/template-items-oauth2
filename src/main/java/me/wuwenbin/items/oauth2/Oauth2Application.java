package me.wuwenbin.items.oauth2;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@SpringBootApplication
@EnableAspectJAutoProxy(exposeProxy = true)
@ComponentScan(basePackages = {"com.alibaba", "me.wuwenbin"})
public class Oauth2Application {

    public static void main(String[] args) {
        SpringApplication.run(Oauth2Application.class, args);
    }

}
