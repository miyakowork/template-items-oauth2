package me.wuwenbin.items.oauth2.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

/**
 * created by Wuwenbin on 2017/9/7 at 20:34
 */
@Configuration
@ConfigurationProperties(prefix = "resource")
@PropertySource("classpath:oauth2.properties")
public class OauthConfig {

    private int scan;
    private String systemModuleCode;
    private int openSa;
    private int init;

    public int getScan() {
        return scan;
    }

    public void setScan(int scan) {
        this.scan = scan;
    }

    public String getSystemModuleCode() {
        return systemModuleCode;
    }

    public void setSystemModuleCode(String systemModuleCode) {
        this.systemModuleCode = systemModuleCode;
    }

    public int getOpenSa() {
        return openSa;
    }

    public void setOpenSa(int openSa) {
        this.openSa = openSa;
    }

    public int getInit() {
        return init;
    }

    public void setInit(int init) {
        this.init = init;
    }
}
