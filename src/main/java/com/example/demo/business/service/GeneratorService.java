package com.example.demo.business.service;

import com.example.demo.DemoApplication;
import com.example.demo.business.model.TableInfo;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * date : 2018/5/9.
 * author : leicheng
 * package : demo
 */
@Service
public class GeneratorService {

    private static final String GENERATOR_DIR_NAME = "generatorDirName";
    private static final String PACKAGE_NAME_PREFIX = "packageNamePrefix";
    private static final String TABLE_NAME = "tableName";
    private static final String PROJECT_NAME = "projectName";

    private static final String[] MODULE_ARR = {"model", "mapper", "service", "controller"};

    @Autowired
    private ColumnsService columnsService;

    public void generate(String database) {
        Map<String, TableInfo> map = columnsService.getTableInfoListByDatabase(database);
        for (Map.Entry<String, TableInfo> tableInfoEntry : map.entrySet()) {
            generateOneTable(tableInfoEntry.getValue());
        }
    }

    public void generate(String database, String tableName) {
        Map<String, TableInfo> map = columnsService.getTableInfoListByDatabase(database);
        for (Map.Entry<String, TableInfo> tableInfoEntry : map.entrySet()) {
            if (tableName.equalsIgnoreCase(tableInfoEntry.getKey())) {
                generateOneTable(tableInfoEntry.getValue());
                break;
            }
        }
    }

    private void generateOneTable(TableInfo tableInfo) {
        Map<String, Object> attrs = addAttrToMap(tableInfo);
        String dirName = (String) attrs.get(GENERATOR_DIR_NAME);
        String projectName = (String) attrs.get(PROJECT_NAME);
        String packageNamePrefix = (String) attrs.get(PACKAGE_NAME_PREFIX);
        String filePathPrefix = dirName + "/" + projectName + "/" + StringUtils.replaceChars(packageNamePrefix, '.', '/');
        String fileNamePrefix = StringUtils.capitalize((String) attrs.get(TABLE_NAME));
        for (int i = 0; i < MODULE_ARR.length; i++) {
            generateOneFile(attrs, MODULE_ARR[i], fileNamePrefix, filePathPrefix);
        }
    }

    private void generateOneFile(Map<String, Object> attrs, String module, String fileNamePrefix, String filePathPrefix) {
        try {
            Configuration cfg = new Configuration(Configuration.VERSION_2_3_26);
            String config = DemoApplication.class.getClassLoader().getResource("config").getPath();
            cfg.setDirectoryForTemplateLoading(new File(config));  //模板父路径
            cfg.setDefaultEncoding("UTF-8");//设置编码
            Template template = cfg.getTemplate(module + ".ftl");//获取模板
            String targetBasePathStr = filePathPrefix + "/" + module;//生成的目标文件的父目录
            File targetBasePath = new File(targetBasePathStr);
            if (!targetBasePath.exists()) {
                targetBasePath.mkdirs();
            }
            String targetFileName = generateFileName(module, fileNamePrefix);//生成目标文件的名字
            File targetFile = new File(targetBasePath, targetFileName);
            if (!targetFile.exists())
                targetFile.createNewFile();
            Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(targetFile), "UTF-8"));
            template.process(attrs, out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String generateFileName(String module, String fileNamePrefix) {
        String moduleName = StringUtils.equalsIgnoreCase("model", module) ? "" : StringUtils.capitalize(module);
        return fileNamePrefix + moduleName + ".java";
    }

    private Map<String, Object> addAttrToMap(TableInfo tableInfo) {
        Map<String, Object> attrs = new HashMap<>(32);
        attrs.put("tableName", tableInfo.getJavaTableName());
        attrs.put("capitalizeTableName", StringUtils.capitalize(tableInfo.getJavaTableName()));
        attrs.put("columnList", tableInfo.getColumnInfoList());
        attrs.putAll(initConfig());
        return attrs;
    }

    private Map<String, Object> initConfig() {
        Map<String, Object> map = new HashMap<>();
        try {
            Properties prop = new Properties();
            prop.load(DemoApplication.class.getClassLoader().getResourceAsStream("config/config.properties"));
            for (Map.Entry<Object, Object> entry : prop.entrySet()) {
                String key = (String) entry.getKey();
                String value = (String) entry.getValue();
                //处理配置中的包名
                if (key.startsWith(PACKAGE_NAME_PREFIX) && StringUtils.isNotBlank(value)) {
                    for (int i = 0; i < MODULE_ARR.length; i++) {
                        if (key.equalsIgnoreCase(PACKAGE_NAME_PREFIX + MODULE_ARR[i])) {
                            value = StringUtils.isBlank((String) entry.getValue()) ?
                                    MODULE_ARR[i] : (String) entry.getValue();
                            break;
                        }
                    }
                }
                map.put(key, value);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return map;
    }


}
