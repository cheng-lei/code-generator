package ${packageNamePrefix}.${packageNamePrefixController}.${capitalizeTableName};

import ${packageNamePrefix}.${packageNamePrefixModel}.${capitalizeTableName};
import ${packageNamePrefix}.${packageNamePrefixService}.${capitalizeTableName}Service;
import com.example.demo.business.web.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
* date : ${.now?date}.
* author : ${author}
*/
@RequestMapping("/${tableName}")
@Controller
public class ${capitalizeTableName}Controller extends BaseController<${capitalizeTableName}> {
}
