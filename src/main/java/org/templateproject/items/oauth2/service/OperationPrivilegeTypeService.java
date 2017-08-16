package org.templateproject.items.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.items.oauth2.entity.IOperationPrivilegeType;
import org.templateproject.items.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.items.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.items.oauth2.support.pojo.bo.OperationPrivilegeTypeBo;
import org.templateproject.items.oauth2.support.pojo.vo.OperationPrivilegeTypeVO;
import org.templateproject.pojo.page.Page;

/**
 * Created by zhangteng on 2017/7/12.
 * 操作级权限类型 service
 */
@Service
@Transactional
@SqlMapper("operation_privilege_type")
public class OperationPrivilegeTypeService extends SimpleBaseCrudService<IOperationPrivilegeType, Integer> {


    /*
    * 根据name模糊查询操作级权限类型
    * name为空 则返回所有记录
    * */
    public Page<OperationPrivilegeTypeVO> findOperationPrivilegeTypePage(Page<OperationPrivilegeTypeVO> page, OperationPrivilegeTypeBo operationPrivilegeTypeBo) {
        return findPagination(page, OperationPrivilegeTypeVO.class, sql(), operationPrivilegeTypeBo);
    }


}
