package ${packageNamePrefix}.${packageNamePrefixModel};

/**
* date : ${.now?date}.
* author : ${author}
*/
public class ${capitalizeTableName} {

<#list columnList as item>
    private ${item.dbJavaType.javaTypeName} ${item.javaColumnName};<#if item.comment??&&item.comment!="">//${item.comment}</#if>
</#list>

<#list columnList as item>
    public ${item.dbJavaType.javaTypeName} get${item.capitalizeJavaColumnName}() {
        return ${item.javaColumnName};
    }

    public void set${item.capitalizeJavaColumnName}(${item.dbJavaType.javaTypeName} ${item.javaColumnName}) {
        this.${item.javaColumnName} = ${item.javaColumnName};
    }
</#list>
}
