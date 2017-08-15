package org.templateproject.oauth2.service;

import org.templateproject.oauth2.service.base.SimpleBaseCrudService;
import org.templateproject.oauth2.support.pojo.bo.ZTreeBO;
import org.templateproject.oauth2.support.pojo.vo.PrivilegeVO;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by tuchen on 2017/7/21.
 */
public class PrivilegeService extends SimpleBaseCrudService {


    /**
     * 查询权限页面List
     * @param pId
     * @return
     */
    public List<ZTreeBO> findPageByResModuleId(String pId) throws Exception {
        String sql = "SELECT NAME,T_OAUTH_PRIVILEGE_PAGE.ID  FROM T_OAUTH_RESOURCE,T_OAUTH_PRIVILEGE_PAGE " +
                "WHERE T_OAUTH_RESOURCE.ID IN( " +
                "SELECT T_OAUTH_PRIVILEGE_PAGE.ID FROM T_OAUTH_PRIVILEGE_PAGE " +
                "WHERE RESOURCE_MODULE_ID = ? )";
        List<PrivilegeVO> list = mysql.findListBeanByArray(sql, PrivilegeVO.class, pId);
        //将list转为Ztree
        for (int i=0;i<list.size();i++){

            System.out.println(list.get(i).toString());
        }
        return  privilegeVOToZtree(list,pId);

    }



    /**
     * 將List转为zTree树对象
     * @param privilegeVOS  权限页面的Name ,Id 的一个对象
     * @return
     * @throws Exception
     */
    private List<ZTreeBO> privilegeVOToZtree(Collection<PrivilegeVO> privilegeVOS, String pId) throws Exception {
        List<ZTreeBO> zTreeList = new LinkedList<>();
        //将角色转换成zTree
        for (PrivilegeVO privilegePage : privilegeVOS) {
            ZTreeBO ztree = new ZTreeBO();
            ztree.setId(privilegePage.getId().toString());
            ztree.setpId(pId);
            ztree.setName(privilegePage.getName());
            ztree.setOpen(true);
            //增加ztree
            zTreeList.add(ztree);
        }
        return zTreeList;
    }

}
