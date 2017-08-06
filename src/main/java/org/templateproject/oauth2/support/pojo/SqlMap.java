package org.templateproject.oauth2.support.pojo;

import org.dom4j.Document;
import org.dom4j.Element;
import org.templateproject.lang.TP;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.oauth2.support.exception.SqlMapperException;
import org.templateproject.sql.util.SQLDefineUtils;


/**
 * 映射service和xml的sql mapper类
 * created by Wuwenbin on 2017/8/4 at 11:21
 */
public class SqlMap {

        //默认的sql映射路劲
        private static final String DEFAULT_MAPPER_PATH = "classpath:mappers";

        private String mapperPath = DEFAULT_MAPPER_PATH;

        /**
         * 根据sqlId查找对应的sql
         *
         * @param sqlId        sql id
         * @param serviceClass 注入SqlMap的类
         * @param <T>          {@link SimpleBaseCrudService}
         * @return sql
         */
        public <T extends SimpleBaseCrudService> String findSqlById(String sqlId, Class<T> serviceClass) {
                //先判断service是否有@SqlMapper注解，在使用了sqlId的情况下
                if (!serviceClass.isAnnotationPresent(SqlMapper.class))
                        throw new SqlMapperException("使用sqlId必须在Service注明@SqlMapper注解");

                //获取当前service使用的是哪个xml定义的sql
                String xmlFileName = SQLDefineUtils.java2SQL(serviceClass.getAnnotation(SqlMapper.class).value(), serviceClass.getName());

                String completePath;
                if (getMapperPath().contains("classpath:"))
                        setMapperPath("/".concat(mapperPath.replace("classpath:", "")));

                completePath = getMapperPath().concat("/").concat(xmlFileName);
                if (!completePath.endsWith(".xml"))
                        completePath += ".xml";

                String sqlMapperPath = this.getClass().getResource(completePath).getPath();
                Document document = TP.dom4jXml.getDocument(sqlMapperPath);
                Element root = document.getRootElement();
                Element sqlElement = TP.dom4jXml.getChild(root, sqlId);
                return sqlElement.getTextTrim();
        }

        public String getMapperPath() {
                return mapperPath;
        }

        public void setMapperPath(String mapperPath) {
                this.mapperPath = mapperPath;
        }


}
