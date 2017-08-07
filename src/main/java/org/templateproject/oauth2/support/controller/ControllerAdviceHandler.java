package org.templateproject.oauth2.support.controller;

import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.templateproject.oauth2.support.TemplateController;
import org.templateproject.oauth2.support.webeditor.DateEditor;
import org.templateproject.oauth2.support.webeditor.DoubleEditor;
import org.templateproject.oauth2.support.webeditor.IntegerEditor;
import org.templateproject.oauth2.support.webeditor.LongEditor;

import java.util.Date;

/**
 * web->Controller数据绑定操作
 * Created by wuwenbin on 2017/5/20.
 */
@ControllerAdvice
public class ControllerAdviceHandler extends TemplateController {

        @InitBinder
        protected void initBinderByCustom(ServletRequestDataBinder binder) throws Exception {
                binder.registerCustomEditor(int.class, new IntegerEditor());
                binder.registerCustomEditor(long.class, new LongEditor());
                binder.registerCustomEditor(double.class, new DoubleEditor());
                binder.registerCustomEditor(Date.class, new DateEditor());
        }


}
