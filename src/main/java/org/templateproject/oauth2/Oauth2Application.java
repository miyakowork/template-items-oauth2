package org.templateproject.oauth2;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
public class Oauth2Application extends SpringBootServletInitializer {

        /**
         * 生成可以在tomcat里运行的war包，并且使用jrebel热部署
         *
         * @param builder
         * @return
         */
        @Override
        protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
                return builder.sources(Oauth2Application.class);
        }


        public static void main(String[] args) {
                SpringApplication.run(Oauth2Application.class, args);
        }
}
