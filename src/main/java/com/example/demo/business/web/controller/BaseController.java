package com.example.demo.business.web.controller;

import com.example.demo.framwork.base.AbstractBaseService;
import com.example.demo.framwork.base.PropertyFilter;
import com.example.demo.framwork.base.model.Page;
import com.example.demo.framwork.utils.reflect.ReflectionUtils;
import com.example.demo.framwork.utils.web.ParameterUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

/**
 * Created by leicheng on 2017/11/17.
 */
public abstract class BaseController<T> {

    @Autowired
    private AbstractBaseService<T> baseService;
    private String dirName = ReflectionUtils.getSuperClassGenricType(getClass()).getSimpleName().toLowerCase();

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView index() {
        ModelAndView modelAndView = new ModelAndView("/" + dirName + "/index");
        Map<String, Object> modelMap = this.initConstantMap();
        modelAndView.addAllObjects(modelMap);
        return modelAndView;
    }

    protected Map<String, Object> initConstantMap() {
        return null;
    }

    @RequestMapping(value = "/page", method = RequestMethod.GET)
    @ResponseBody
    public Page<T> pageJson(Page<T> page) {
        List<PropertyFilter> filters = ParameterUtils.buildFilterList("page_");
        Page<T> result = baseService.findPageByPropertyFilters(page, filters);
        return result;
    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ResponseBody
    public T getById(@PathVariable Long id) {
        T t = baseService.selectByPrimaryKey(id);
        return t;
    }

    @RequestMapping(value = "/insert/", method = RequestMethod.POST)
    @ResponseBody
    public void insert(T t) {
        baseService.insertSelective(t);
    }

    @RequestMapping(value = "/save/{id}", method = RequestMethod.POST)
    @ResponseBody
    public void save(@PathVariable Long id, T t) {
        if (id == null || id <= 0L) {
            baseService.insertSelective(t);
        } else {
            T dbT = baseService.selectByPrimaryKey(id);
            if (dbT != null) {
                baseService.updateByPrimaryKeySelective(t);
            } else {
                baseService.insertSelective(t);
            }
        }
    }

    @RequestMapping(value = "/beforeSave")
    public ModelAndView beforeSave(Long id) {
        ModelAndView modelAndView = new ModelAndView("/" + dirName + "/save");
        if (id != null && id > 0L) {
            T t = baseService.selectByPrimaryKey(id);
            modelAndView.addObject("t", t);
        }
        return modelAndView;
    }

    @RequestMapping(value = "/delete/{id}")
    @ResponseBody
    public void delete(@PathVariable Long id) {
        baseService.deleteByPrimaryKey(id);
    }

    public AbstractBaseService<T> getBaseService() {
        return baseService;
    }

    public void setBaseService(AbstractBaseService<T> baseService) {
        this.baseService = baseService;
    }

    public String getDirName() {
        return dirName;
    }

    public void setDirName(String dirName) {
        this.dirName = dirName;
    }
}
