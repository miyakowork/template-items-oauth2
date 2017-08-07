package org.templateproject.oauth2.support.controller;

import org.springframework.boot.autoconfigure.web.ErrorAttributes;
import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.boot.autoconfigure.web.ErrorProperties;
import org.springframework.boot.autoconfigure.web.ServerProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.templateproject.pojo.response.R;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * Created by wuwenbin on 2017/5/21.
 */
@Controller
@RequestMapping("error")
@EnableConfigurationProperties({ServerProperties.class})
public class ErrorExceptionController extends MethodBootController implements ErrorController {

        private ErrorAttributes errorAttributes;

        private ServerProperties serverProperties;

        /**
         * 初始化ExceptionController
         *
         * @param errorAttributes
         */
        public ErrorExceptionController(ErrorAttributes errorAttributes, ServerProperties serverProperties) {
                Assert.notNull(errorAttributes, "ErrorAttributes must not be null");
                this.errorAttributes = errorAttributes;
                this.serverProperties = serverProperties;
        }


        /**
         * 定义404的ModelAndView,普通URL请求404页面
         *
         * @param request
         * @param response
         * @return
         */
        @RequestMapping(value = {"{errorCode}", ""}, produces = "text/html", method = RequestMethod.GET)
        public ModelAndView errorHtml(HttpServletRequest request, HttpServletResponse response, @PathVariable String errorCode) {
                response.setStatus(getStatus(request).value());
                Map<String, Object> model = getErrorAttributes(request, isIncludeStackTrace(request, MediaType.TEXT_HTML));
                model.put("pageCode", errorCode.equalsIgnoreCase("exception") ? "500" : errorCode);
                if (isRouter())
                        return new ModelAndView("error/router", model);
                else
                        return new ModelAndView("error/page", model);
        }


        /**
         * 定义404的JSON数据
         *
         * @param request
         * @return
         */
        @RequestMapping(value = {"{errorCode}", ""})
        @ResponseBody
        public R error(HttpServletRequest request, @PathVariable String errorCode) {
                Map<String, Object> body = getErrorAttributes(request, isIncludeStackTrace(request, MediaType.TEXT_HTML));
                HttpStatus status = getStatus(request);
                String message = body.get("message").toString();
                body.remove("message");
                return R.custom(status.value(), message, body);
        }


        /**
         * Determine if the stacktrace attribute should be included.
         *
         * @param request  the source request
         * @param produces the media type produced (or {@code MediaType.ALL})
         * @return if the stacktrace attribute should be included
         */
        protected boolean isIncludeStackTrace(HttpServletRequest request, MediaType produces) {
                ErrorProperties.IncludeStacktrace include = this.serverProperties.getError().getIncludeStacktrace();
                return include == ErrorProperties.IncludeStacktrace.ALWAYS || include == ErrorProperties.IncludeStacktrace.ON_TRACE_PARAM && getTraceParameter(request);
        }


        /**
         * 获取错误的信息
         *
         * @param request
         * @param includeStackTrace
         * @return
         */
        private Map<String, Object> getErrorAttributes(HttpServletRequest request, boolean includeStackTrace) {
                RequestAttributes requestAttributes = new ServletRequestAttributes(request);
                return this.errorAttributes.getErrorAttributes(requestAttributes, includeStackTrace);
        }

        /**
         * 是否包含trace
         *
         * @param request
         * @return
         */
        private boolean getTraceParameter(HttpServletRequest request) {
                String parameter = request.getParameter("trace");
                return parameter != null && !"false".equals(parameter.toLowerCase());
        }

        /**
         * 获取错误编码
         *
         * @param request
         * @return
         */
        private HttpStatus getStatus(HttpServletRequest request) {
                Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
                if (statusCode == null) {
                        return HttpStatus.INTERNAL_SERVER_ERROR;
                }
                try {
                        return HttpStatus.valueOf(statusCode);
                } catch (Exception ex) {
                        return HttpStatus.INTERNAL_SERVER_ERROR;
                }
        }

        /**
         * 暂时无用
         *
         * @return
         */
        @Override
        public String getErrorPath() {
                return null;
        }
}
