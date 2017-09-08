package me.wuwenbin.items.oauth2.service;

import me.wuwenbin.items.oauth2.entity.IResource;
import me.wuwenbin.items.oauth2.service.base.SimpleBaseCrudService;
import me.wuwenbin.items.oauth2.support.pojo.vo.ResourceVO;
import me.wuwenbin.modules.pagination.query.TableQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.templateproject.pojo.page.Page;

/**
 * Created by wuwenbin on 2017/7/13.
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
    public Page<ResourceVO> findResourcePage(TableQuery resourceBO, Page<ResourceVO> page) {
        String sql = "SELECT tor.*, tou1.username AS create_name, tou2.username AS update_name, tosm.name AS systemModuleName" +
                " FROM t_oauth_resource tor " +
                "LEFT JOIN t_oauth_user tou1 ON tor.create_user = tou1.id " +
                "LEFT JOIN t_oauth_user tou2 ON tor.update_user = tou2.id  " +
                "LEFT JOIN t_oauth_system_module tosm ON tosm.system_code = tor.system_code";
        return findPagination(page, ResourceVO.class, sql, resourceBO);
    }


}
