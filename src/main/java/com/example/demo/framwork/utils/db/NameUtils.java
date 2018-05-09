package com.example.demo.framwork.utils.db;

import org.apache.commons.lang3.StringUtils;

/**
 * date : 2018/3/7.
 * author : leicheng
 * package : demo
 */
public class NameUtils {

    public static String covertToDbName(String name) {
        if (StringUtils.isBlank(name)) {
            return null;
        }
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < name.length(); i++) {
            char ch = name.charAt(i);
            if (i != 0 && Character.isUpperCase(ch)) {
                result.append("_");
            }
            result.append(Character.toLowerCase(ch));
        }
        return result.toString();
    }

    public static String covertToFieldName(String dbColumnName) {
        if (StringUtils.isBlank(dbColumnName)) {
            return null;
        }
        StringBuilder result = new StringBuilder();
        boolean nextUpper = false;
        for (int i = 0; i < dbColumnName.length(); i++) {
            char ch = dbColumnName.charAt(i);
            if (ch == '_') {
                nextUpper = true;
            } else {
                if (nextUpper) {
                    result.append(Character.toUpperCase(ch));
                } else {
                    result.append(Character.toLowerCase(ch));
                }
                nextUpper = false;
            }
        }
        return result.toString();
    }
}
