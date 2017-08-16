package org.templateproject.items.oauth2.support.pojo.bo;

/**
 * 前台下拉搜索的对象
 * Created by Wuwenbin on 2017/7/23.
 */
public class SelectBO {

    private Object value;
    private Object text;

    public Object getValue() {
        return value;
    }

    public void setValue(Object value) {
        this.value = value;
    }

    public Object getText() {
        return text;
    }

    public void setText(Object text) {
        this.text = text;
    }

    public static SelectBO create(String value, String text) {
        SelectBO selectBO = new SelectBO();
        selectBO.setValue(value);
        selectBO.setText(text);
        return selectBO;
    }

}
