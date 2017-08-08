package org.templateproject.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.oauth2.entity.OauthSystemParam;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.oauth2.support.pojo.bo.SysParamBo;
import org.templateproject.oauth2.support.pojo.vo.SystemParamVO;
import org.templateproject.pojo.page.Page;


@Service
@Transactional
@SqlMapper("system_param")
public class SystemParamService extends SimpleBaseCrudService<OauthSystemParam, Integer> {

    /**
     * 系统参数页面
     *
     * @param page       page
     * @param sysParamBo 查询对象
     * @return page
     */
    public Page<SystemParamVO> findSystemParamPage(Page<SystemParamVO> page, SysParamBo sysParamBo) {
        return findPagination(page, SystemParamVO.class, sql(), sysParamBo);
    }

    /**
     * 通过参数key查找对应的value
     *
     * @param keyName key
     * @param clazz   类型
     * @param <T>     泛型
     * @return value
     */
    public <T> T findValueByParamKey(String keyName, Class<T> clazz) {
        return h2Dao.findBeanByArray(sql(), clazz, keyName);
    }
}
