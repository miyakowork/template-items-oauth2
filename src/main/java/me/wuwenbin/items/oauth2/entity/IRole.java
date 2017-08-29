package me.wuwenbin.items.oauth2.entity;

import me.wuwenbin.items.oauth2.entity.base.DataEntity;
import org.templateproject.tools.sqlgen.annotation.SQLColumn;
import org.templateproject.tools.sqlgen.annotation.SQLTable;

import java.time.LocalDateTime;

/**
 * 角色表
 * Created by tuchen on 2017/7/12.
 */
@SQLTable("t_oauth_role")
public class IRole extends DataEntity {

    @SQLColumn
    private String name;//名称

    @SQLColumn
    private String cnName;//角色标识

    @SQLColumn
    private Integer parentId;//父级角色id

    @SQLColumn
    private String systemCode;

    public String getSystemCode() {
        return systemCode;
    }

    public void setSystemCode(String systemCode) {
        this.systemCode = systemCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCnName() {
        return cnName;
    }

    public void setCnName(String cnName) {
        this.cnName = cnName;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    /**
     * 生成root节点
     *
     * @return root
     */
    public static IRole root() {
        IRole root = new IRole();
        root.setId(0);
        root.setCnName("上帝角色(虚拟节点)");
        root.setParentId(-1);
        root.setOrderIndex(0);
        root.setCreateDate(LocalDateTime.now());
        root.setRemark("根节点部门，无任何意义，作为树形部门的象征节点");
        return root;
    }
}
