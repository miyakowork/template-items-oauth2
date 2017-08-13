package org.templateproject.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.oauth2.entity.OauthResource;
import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.annotation.sql.SqlMapper;
import org.templateproject.oauth2.support.pojo.bo.ResourceBO;
import org.templateproject.oauth2.support.pojo.vo.ResourceVO;
import org.templateproject.pojo.page.Page;

/**
 * Created by Liurongqi on 2017/7/13.
 */
@Service
@Transactional
@SqlMapper("resource")
public class ResourceService extends SimpleBaseCrudService<OauthResource, Integer> {

    /**
     * 根据权限标识查询数据
     *
     * @param resourceBO
     * @param page
     * @return page<OauthResource>
     */
    public Page<ResourceVO> findResourcePage(ResourceBO resourceBO, Page<ResourceVO> page) {
        return findPagination(page, ResourceVO.class, sql(), resourceBO);
    }

    /**
     * 隐藏资源，也就相当于是逻辑删除
     *
     * @param hideIds
     * @throws Exception
     */
    public void hideResourceByIds(String hideIds) throws Exception {
        String[] ids = hideIds.split(",");
        executeBatch(sql(), "id", ids);
    }


    /**
     * 删除指定资源,永久删除，即物理删除
     *
     * @param deleteIds
     * @return
     * @throws Exception
     */
    public void delete(String deleteIds) throws Exception {
        String[] ids = deleteIds.split(",");
        deleteBatchByArrayIds(OauthResource.class, ids);
    }
}
