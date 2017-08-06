package org.templateproject.oauth2.page.privilegepage;


/**
 * Created by zhangteng on 2017/7/18.
 */
public class ZTreeBO {
    protected String id;
    protected String pId;
    protected String name;
    protected boolean isParent;
    protected boolean open;

    protected boolean nocheck;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getpId() {
        return pId;
    }

    public void setpId(String pId) {
        this.pId = pId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean getisParent() {
        return isParent;
    }

    public void setisParent(boolean parent) {
        isParent = parent;
    }

    public boolean getOpen() {
        return open;
    }

    public void setOpen(boolean open) {
        this.open = open;
    }


    public boolean isNocheck() {
        return nocheck;
    }

    public void setNocheck(boolean nocheck) {
        this.nocheck = nocheck;
    }
}
