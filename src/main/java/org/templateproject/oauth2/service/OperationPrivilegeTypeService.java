package org.templateproject.oauth2.service;

import jodd.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.lang.TP;
import org.templateproject.oauth2.constant.CommonConsts;
import org.templateproject.oauth2.constant.ServiceConsts;
import org.templateproject.oauth2.entity.OauthOperationPrivilegeType;
import org.templateproject.oauth2.service.base.AbstractBaseCrudService;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.oauth2.support.pojo.bo.OperationPrivilegeTypeBo;
import org.templateproject.oauth2.support.pojo.vo.OperationPrivilegeTypeVO;
import org.templateproject.pojo.page.Page;
import org.templateproject.sql.entrance.SQLFactory;
import org.templateproject.sql.factory.SQLBeanBuilder;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by zhangteng on 2017/7/12.
 * 操作级权限类型 service
 */
@Service
@Transactional
@SqlMapper("operation_privilege_type")
public class OperationPrivilegeTypeService extends SimpleBaseCrudService<OauthOperationPrivilegeType, Integer> {


    /*
    * 根据name模糊查询操作级权限类型
    * name为空 则返回所有记录
    * */
    public Page<OperationPrivilegeTypeVO> findOperationPrivilegeTypePage(Page<OperationPrivilegeTypeVO> page, OperationPrivilegeTypeBo operationPrivilegeTypeBo) {
        return findPagination(page, OperationPrivilegeTypeVO.class, sql(), operationPrivilegeTypeBo);
    }


}
