package me.wuwenbin.items.oauth2.support.enumerate;

/**
 * SQL中运算操作符
 * Created by Wuwenbin on 2017/7/22.
 */
public enum Operator {

    LIKE("LIKE"),
    EQ("="),
    NE("!="),
    GLT("<>"),
    GT(">"),
    LT("<"),
    GTE(">="),
    LTE("<="),
    NLT("!<"),
    NGT("!>"),

    BETWEEN("BETWEEN");

    private String operation;

    Operator(String operation) {
        this.operation = operation;
    }

    public String value() {
        return this.operation;
    }
}
