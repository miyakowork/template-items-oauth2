package org.templateproject.items.oauth2.entity.base;

import org.templateproject.items.oauth2.constant.CommonConsts;
import org.templateproject.items.oauth2.constant.ServiceConsts;
import org.templateproject.tools.sqlgen.annotation.SQLColumn;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 每个实体类需要间接继承的抽象父类
 * 使用sqlFactory的时候，router禁止使用1609931，因为这个关系到更新的字段
 * 基本实体类都使用到了此router
 * Created by Wuwenbin on 2017/7/12.
 */
public abstract class BaseEntity implements CommonConsts, Serializable {

    @SQLColumn(pk = true, routers = ServiceConsts.PK_ROUTER)
    protected Integer id;

    @SQLColumn(routers = CREATE_ROUTER)
    LocalDateTime createDate;

    @SQLColumn(routers = CREATE_ROUTER)
    Integer createUser;

    @SQLColumn(routers = UPDATE_ROUTER)
    LocalDateTime updateDate;

    @SQLColumn(routers = UPDATE_ROUTER)
    Integer updateUser;

    public abstract void preInsert();

    public abstract void preUpdate();

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }

    public Integer getCreateUser() {
        return createUser;
    }

    public void setCreateUser(Integer createUser) {
        this.createUser = createUser;
    }

    public LocalDateTime getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(LocalDateTime updateDate) {
        this.updateDate = updateDate;
    }

    public Integer getUpdateUser() {
        return updateUser;
    }

    public void setUpdateUser(Integer updateUser) {
        this.updateUser = updateUser;
    }
}
