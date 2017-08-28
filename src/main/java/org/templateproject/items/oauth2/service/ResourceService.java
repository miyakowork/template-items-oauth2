package org.templateproject.items.oauth2.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.items.oauth2.entity.IResource;
import org.templateproject.items.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.items.oauth2.support.pojo.bo.ResourceBO;
import org.templateproject.items.oauth2.support.pojo.vo.ResourceVO;
import org.templateproject.pojo.page.Page;

/**
 * Created by Liurongqi on 2017/7/13.
 */
@Service
@Transactional
public class ResourceService extends SimpleBaseCrudService<IResource, Integer> {

    /**
     * 根据权限标识查询数据
     *
     * @param resourceBO
     * @param page
     * @return page<IResource>
     */
    public Page<ResourceVO> findResourcePage(ResourceBO resourceBO, Page<ResourceVO> page) {
        String sql = "SELECT tor.*, tou1.username AS create_name, tou2.username AS update_name, tosm.name AS systemModuleName" +
                " FROM t_oauth_resource tor, t_oauth_user tou1, t_oauth_user tou2, t_oauth_system_module tosm" +
                " WHERE tor.create_user = tou1.id AND tor.update_user = tou2.id AND tosm.system_code = tor.system_code";
        return findPagination(page, ResourceVO.class, sql, resourceBO);
    }


}
