package com.example.demo.business.service;

import com.example.demo.business.model.ColumnInfo;
import com.example.demo.business.model.Columns;
import com.example.demo.business.model.TableInfo;
import com.example.demo.business.utils.DbJavaType;
import com.example.demo.framwork.base.AbstractBaseService;
import com.example.demo.framwork.utils.db.NameUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by leicheng on 2017/10/11.
 */
@Service
public class ColumnsService extends AbstractBaseService<Columns> {

    public Set<String> getAllDatabases() {
        List<Columns> all = this.selectAll();
        Set<String> databases = all.stream().map(c -> c.getTableSchema()).collect(Collectors.toSet());
        databases.stream().forEach(str -> System.out.println(str));
        return databases;
    }

    public Map<String, TableInfo> getTableInfoListByDatabase(String database) {
        List<Columns> all = this.selectAll();
        List<Columns> databaseList = all.stream().filter(c -> c.getTableSchema().equalsIgnoreCase(database)).collect(Collectors.toList());
        Map<String, TableInfo> result = convertToTableInfo(databaseList);
        return result;
    }

    private Map<String, TableInfo> convertToTableInfo(List<Columns> databaseList) {
        Map<String, TableInfo> map = new HashMap<>();
        for (Columns c : databaseList) {
            if (map.containsKey(c.getTableName())) {
                map.get(c.getTableName()).getColumnInfoList().add(convertToColumnInfo(c));
            } else {
                List<ColumnInfo> list = new ArrayList<>();
                list.add(convertToColumnInfo(c));
                TableInfo tableInfo = new TableInfo();
                tableInfo.setColumnInfoList(list);
                tableInfo.setDbTableName(StringUtils.trimToEmpty(c.getTableName()));
                tableInfo.setJavaTableName(NameUtils.covertToFieldName(tableInfo.getDbTableName()));
                map.put(c.getTableName(), tableInfo);
            }
        }
        return map;
    }

    private ColumnInfo convertToColumnInfo(Columns c) {
        ColumnInfo info = new ColumnInfo();
        info.setDbColumnName(StringUtils.trimToEmpty(c.getColumnName()));
        info.setJavaColumnName(NameUtils.covertToFieldName(c.getColumnName()));
        info.setDbType(c.getDataType());
        info.setComment(c.getColumnComment());
        info.setDbJavaType(DbJavaType.convertTo(c.getDataType()));
        info.setCapitalizeJavaColumnName(StringUtils.capitalize(info.getJavaColumnName()));
        return info;
    }
}
