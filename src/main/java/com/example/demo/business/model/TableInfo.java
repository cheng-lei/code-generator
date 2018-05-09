package com.example.demo.business.model;

import java.util.List;

/**
 * date : 2018/5/9.
 * author : leicheng
 * package : demo
 */
public class TableInfo {
    private String dbTableName;
    private String javaTableName;
    private List<ColumnInfo> columnInfoList;

    public String getDbTableName() {
        return dbTableName;
    }

    public void setDbTableName(String dbTableName) {
        this.dbTableName = dbTableName;
    }

    public String getJavaTableName() {
        return javaTableName;
    }

    public void setJavaTableName(String javaTableName) {
        this.javaTableName = javaTableName;
    }

    public List<ColumnInfo> getColumnInfoList() {
        return columnInfoList;
    }

    public void setColumnInfoList(List<ColumnInfo> columnInfoList) {
        this.columnInfoList = columnInfoList;
    }
}
