package com.example.demo.framwork.utils.web;

import com.example.demo.framwork.base.PropertyFilter;
import org.apache.commons.lang3.StringUtils;
import org.springframework.util.Assert;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by leicheng on 2017/11/17.
 */
public class ParameterUtils {

    public static Map<String, Object> buildParametersMapStartingWith(String prefix) {
        HttpServletRequest request = RequestUtils.getRequest();
        Assert.notNull(request, "Request must not be null");
        Enumeration paramNames = request.getParameterNames();
        Map<String, Object> params = new HashMap<>();
        if (prefix == null) {
            prefix = "";
        }

        while (paramNames != null && paramNames.hasMoreElements()) {
            String paramName = (String) paramNames.nextElement();
            if ("".equals(prefix) || paramName.startsWith(prefix)) {
                String unprefixed = paramName.substring(prefix.length());
                String[] values = request.getParameterValues(paramName);
                if (values != null && values.length != 0) {
                    if (values.length > 1) {
                        params.put(unprefixed, values);
                    } else {
                        params.put(unprefixed, values[0]);
                    }
                }
            }
        }
        return params;
    }

    public static List<PropertyFilter> buildFilterList(final String filterPrefix) {
        List<PropertyFilter> filterList = new ArrayList<PropertyFilter>();

        //从request中获取含属性前缀名的参数,构造去除前缀名后的参数Map.
        Map<String, Object> filterParamMap = buildParametersMapStartingWith(filterPrefix);

        //分析参数Map,构造PropertyFilter列表
        for (Map.Entry<String, Object> entry : filterParamMap.entrySet()) {
            String filterName = entry.getKey();
            String value = (String) entry.getValue();
            //如果value值为空,则忽略此filter.
            if (StringUtils.isNotBlank(value)) {
                PropertyFilter filter = new PropertyFilter(filterName, value);
                filterList.add(filter);
            }
        }

        return filterList;
    }
}
