package org.templateproject.oauth2.entity;
import org.templateproject.oauth2.entity.base.DataEntity;
import org.templateproject.sql.annotation.SQLColumn;
import org.templateproject.sql.annotation.SQLTable;

import java.time.LocalDateTime;


/**
 * Created by yuanqi on 2017/7/12/012.
 * 部门表
 */
@SQLTable("t_oauth_department")
public class OauthDepartment extends DataEntity{

    @SQLColumn
    private String name;//名称

    @SQLColumn
    private Integer parentId;//父级id

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    /**
     * 生成root节点
     * @return root
     */
    public static OauthDepartment root(){
        OauthDepartment root = new OauthDepartment();
        root.setId(0);
        root.setName("部门根节点");
        root.setParentId(-1);
        root.setOrderIndex(0);
        root.setCreateDate(LocalDateTime.now());
        root.setRemark("根节点部门，无任何意义，作为树形部门的象征节点");
        return root;
    }

}
