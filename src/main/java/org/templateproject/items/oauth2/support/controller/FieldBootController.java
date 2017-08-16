package org.templateproject.items.oauth2.support.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;

/**
 * request包装controller以及log日志对象定义层
 * Created by Wuwenbin on 2017/7/12.
 */
@Controller
public class FieldBootController {

    private HttpServletRequest request;

    /**
     * 日志对象
     */
    protected Logger LOGGER = LoggerFactory.getLogger(getClass());

    @Autowired
    public void setHttpServletRequest(HttpServletRequest request) {
        this.request = request;
    }

    /**
     * 获取request
     *
     * @return 包装好的HttpServletRequest
     */
    protected HttpServletRequest getRequest() {
        return new TemplateRequestWrapper(this.request);
    }
}
