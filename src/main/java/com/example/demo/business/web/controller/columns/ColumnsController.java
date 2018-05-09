package com.example.demo.business.web.controller.columns;

import com.example.demo.business.model.Columns;
import com.example.demo.business.service.ColumnsService;
import com.example.demo.business.service.GeneratorService;
import com.example.demo.business.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * date : 2018/3/9.
 * author : leicheng
 * package : demo
 */
@RequestMapping("/columns")
@Controller
public class ColumnsController extends BaseController<Columns> {

    @Autowired
    private ColumnsService columnsService;
    @Autowired
    private GeneratorService generatorService;

    protected Map<String, Object> initConstantMap() {
        Set<String> tableNames = columnsService.getAllDatabases();
        Map<String, Object> map = new HashMap<>();
        map.put("databases", tableNames);
        return map;
    }

    @RequestMapping(value = "/generate", method = RequestMethod.GET)
    @ResponseBody
    public void generate(String database) {
        generatorService.generate(database);
    }

    @RequestMapping(value = "/generateTable", method = RequestMethod.GET)
    @ResponseBody
    public void generateTable(String database,String tableName) {
        generatorService.generate(database,tableName);
    }
}
