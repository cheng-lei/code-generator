package com.example.demo.business.model;

import com.example.demo.business.utils.DbJavaType;

/**
 * date : 2018/5/9.
 * author : leicheng
 * package : demo
 */
public class ColumnInfo {
    private String dbColumnName;
    private String javaColumnName;
    private String capitalizeJavaColumnName;
    private String dbType;
    private String comment;
    private DbJavaType dbJavaType;

    public String getDbColumnName() {
        return dbColumnName;
    }

    public void setDbColumnName(String dbColumnName) {
        this.dbColumnName = dbColumnName;
    }

    public String getJavaColumnName() {
        return javaColumnName;
    }

    public void setJavaColumnName(String javaColumnName) {
        this.javaColumnName = javaColumnName;
    }

    public String getDbType() {
        return dbType;
    }

    public void setDbType(String dbType) {
        this.dbType = dbType;
    }


    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public DbJavaType getDbJavaType() {
        return dbJavaType;
    }

    public void setDbJavaType(DbJavaType dbJavaType) {
        this.dbJavaType = dbJavaType;
    }

    public String getCapitalizeJavaColumnName() {
        return capitalizeJavaColumnName;
    }

    public void setCapitalizeJavaColumnName(String capitalizeJavaColumnName) {
        this.capitalizeJavaColumnName = capitalizeJavaColumnName;
    }
}
