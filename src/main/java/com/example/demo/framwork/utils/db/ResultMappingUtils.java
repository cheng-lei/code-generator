package com.example.demo.framwork.utils.db;

import com.example.demo.framwork.utils.reflect.ReflectionUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * date : 2018/3/9.
 * author : leicheng
 * package : demo
 */
public class ResultMappingUtils {

    public static List mapping(List<Map<String, Object>> listMap, Class entityClass) {
        List result = new ArrayList<>();
        if (CollectionUtils.isEmpty(listMap)) {
            return result;
        }
        try {
            for (Map<String, Object> map : listMap) {
                if (MapUtils.isEmpty(map)) {
                    continue;
                }
                Object o = entityClass.newInstance();
                for (Map.Entry<String, Object> entry : map.entrySet()) {
                    if (entry == null) {
                        continue;
                    }
                    if (StringUtils.isBlank(entry.getKey())) {
                        continue;
                    }
                    String fieldName = NameUtils.covertToFieldName(entry.getKey());
                    Field field = ReflectionUtils.getAccessibleField(o, fieldName);
                    if (field == null) {
                        continue;
                    }
                    Class fieldType = field.getType();
                    Object value = entry.getValue();
                    Object v = ConvertUtils.convert(value, fieldType);
                    ReflectionUtils.invokeSetterMethod(o, fieldName, v);
                }
                result.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
