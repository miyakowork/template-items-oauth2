package org.templateproject.oauth2.support.pojo.vo;

import org.templateproject.oauth2.entity.OauthRole;

/**
 * 权限管理页面的对象VO
 * Created by tuchen on 2017/7/16.
 */
public class PrivilegeVO  {
    private String name;
    private Integer id;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
