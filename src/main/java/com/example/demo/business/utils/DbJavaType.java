package com.example.demo.business.utils;

import org.apache.commons.lang3.StringUtils;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

/**
 * date : 2018/5/9.
 * author : leicheng
 * package : demo
 */
public enum DbJavaType {

    CHAR("char", "String", String.class),
    VARCHAR("varchar", "String", String.class),
    INT("int", "Integer", Integer.class),
    TINYINT("tinyint", "Integer", Integer.class),
    MEDIUMINT("mediumint", "Integer", Integer.class),
    BIGINT("bigint", "Long", Long.class),
    LONGTEXT("longtext", "String", String.class),
    MEDIUMTEXT("mediumtext", "String", String.class),
    TEXT("text", "String", String.class),
    FLOAT("float", "Float", Float.class),
    DOUBLE("double", "Double", Double.class),
    DECIMAL("decimal", "java.math.BigDecimal", BigDecimal.class),
    DATE("date", "java.sql.Date", Date.class),
    TIME("time", "java.sql.Time", Time.class),
    DATETIME("datetime", "java.sql.Timestamp", Timestamp.class),
    TIMESTAMP("timestamp", "java.sql.Timestamp", Timestamp.class);


    private String dbTypeName;
    private String javaTypeName;
    private Class clazz;

    DbJavaType(String dbTypeName, String javaTypeName, Class clazz) {
        this.dbTypeName = dbTypeName;
        this.javaTypeName = javaTypeName;
        this.clazz = clazz;
    }

    public String getDbTypeName() {
        return dbTypeName;
    }

    public String getJavaTypeName() {
        return javaTypeName;
    }

    public Class getClazz() {
        return clazz;
    }

    public static DbJavaType convertTo(String dbTypeName) {
        if (StringUtils.isBlank(dbTypeName)) {
            return null;
        }
        for (int i = 0; i < values().length; i++) {
            DbJavaType type = values()[i];
            if (type.dbTypeName.equalsIgnoreCase(dbTypeName)) {
                return type;
            }
        }
        return null;
    }
}
