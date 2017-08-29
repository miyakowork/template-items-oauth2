package me.wuwenbin.items.oauth2.entity;

import me.wuwenbin.items.oauth2.entity.base.DataEntity;
import org.templateproject.tools.sqlgen.annotation.SQLColumn;
import org.templateproject.tools.sqlgen.annotation.SQLTable;

import java.time.LocalDateTime;

/**
 * Created by zhangteng on 2017/7/14.
 * 系统模块表
 */
@SQLTable("T_OAUTH_SYSTEM_MODULE")
public class ISystemModule extends DataEntity {


    @SQLColumn
    private String name; //系统模块名称

    @SQLColumn
    private String systemCode;  //系统模块代码


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSystemCode() {
        return systemCode;
    }

    public void setSystemCode(String systemCode) {
        this.systemCode = systemCode;
    }


    /**
     * 生成root节点
     *
     * @return root
     */
    public static ISystemModule root() {
        ISystemModule root = new ISystemModule();
        root.setId(0);
        root.setName("");
        root.setOrderIndex(0);
        root.setCreateDate(LocalDateTime.now());
        root.setRemark("根节点部门，无任何意义，作为树形部门的象征节点");
        return root;
    }

}
