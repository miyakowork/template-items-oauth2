package me.wuwenbin.items.oauth2.entity.base;

import me.wuwenbin.items.oauth2.util.UserUtils;
import org.templateproject.tools.sqlgen.annotation.SQLColumn;

import java.time.LocalDateTime;

/**
 * 基本实体类
 * 但是更新或者插入中字段不是由程序自动实现更新的，是由代码或者说前端传来的数据来改变数据库的
 * 其中sqlFactory不能使用的router有1609932/1609933/1609934
 * Created by Wuwenbin on 2017/7/12.
 */
public class DataEntity extends BaseEntity {

    private int currentUserId;
    private int createUserId;
    private int updateUserId;

    @SQLColumn(routers = ENABLED_ROUTER)
    protected Boolean enabled;

    @SQLColumn(routers = ORDER_ROUTER)
    protected Integer orderIndex;

    @SQLColumn(routers = REMARK_ROUTER)
    protected String remark;

    @Override
    public void preInsert() {
        super.createUser = UserUtils.getLoginUser().getId();
        super.updateUser = UserUtils.getLoginUser().getId();
        super.createDate = LocalDateTime.now();
        super.updateDate = LocalDateTime.now();
    }

    @Override
    public void preUpdate() {
        super.updateUser = UserUtils.getLoginUser().getId();
        super.updateDate = LocalDateTime.now();
    }

    public int getCurrentUserId() {
        return currentUserId;
    }

    public void setCurrentUserId(int currentUserId) {
        this.currentUserId = currentUserId;
    }

    public int getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(int createUserId) {
        this.createUserId = createUserId;
    }

    public int getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(int updateUserId) {
        this.updateUserId = updateUserId;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public Integer getOrderIndex() {
        return orderIndex;
    }

    public void setOrderIndex(Integer orderIndex) {
        this.orderIndex = orderIndex;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
