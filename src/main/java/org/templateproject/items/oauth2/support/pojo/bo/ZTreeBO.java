package org.templateproject.items.oauth2.support.pojo.bo;


import org.templateproject.pojo.ztree.Ztree;

/**
 * 继承Ztree，添加一个set方法
 * Created by Wuwenbin on 2017/7/19.
 */
public class ZTreeBO<T> extends Ztree {

    private T other;

    public T getOther() {
        return other;
    }

    public void setOther(T other) {
        this.other = other;
    }

    public boolean getisParent() {
        return isParent;
    }

    public void setisParent(boolean parent) {
        isParent = parent;
    }

    public boolean getisHidden() {
        return isHidden;
    }

    public void setisHidden(boolean isHidden) {
        super.isHidden = isHidden;
    }

}
