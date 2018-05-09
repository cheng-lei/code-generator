package com.example.demo.framwork.utils.web;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * Created by leicheng on 2017/11/17.
 */
public class RequestUtils {

    public static HttpServletRequest getRequest() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        return request;
    }

    public static HttpSession getSession() {
        return getRequest().getSession();
    }

    /**
     * 获取request中的所有参数
     *
     * @return
     */
    public static String getParameterString() {
        HttpServletRequest request = getRequest();
        StringBuilder parameters = new StringBuilder();
        Map<String, String[]> params = request.getParameterMap();
        if (params != null) {
            for (String key : params.keySet()) {
                String[] values = params.get(key);
                if (values != null) {
                    for (int i = 0; i < values.length; i++) {
                        String value = values[i];
                        parameters.append(key).append("=").append(value).append("&");
                    }
                }
            }
        }
        return parameters.toString();
    }
}
