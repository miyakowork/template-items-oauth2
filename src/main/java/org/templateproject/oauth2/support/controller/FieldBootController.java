package org.templateproject.oauth2.support.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * request包装controller以及log日志对象定义层
 * Created by Wuwenbin on 2017/7/12.
 */
@Controller
public class FieldBootController {

    @Autowired
    private HttpServletRequest request;

    /**
     * 日志对象
     */
    protected Logger LOGGER = LoggerFactory.getLogger(getClass());


    /**
     * 获取request
     *
     * @return 包装好的HttpServletRequest
     */
    protected HttpServletRequest getRequest() {
        return new TemplateRequestWrapper(this.request);
    }
}
