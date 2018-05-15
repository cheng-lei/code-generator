<!DOCTYPE html>

<html lang="en">
<head>
<#include "../base/cssLink.ftl">
    <meta charset="utf-8"/>
</head>
<body>
<div class="page-header">
    <form id="searchForm" class="form-inline">
        <div class="col-md-1"></div>
        <div class="form-group">
            <label for="name">数据库：</label>
            <select class="form-control" name="page_EQS_tableSchema">
                <option value=""></option>
            <#list databases as item>
                <option value="${item}">${item}</option>
            </#list>
            </select>
        </div>
        <div class="form-group">
            <button type="button" class="form-control btn-info" id="selectOne">查询</button>
            <button type="button" class="form-control btn-info" id="generateCode">生成代码</button>
        </div>
    </form>
</div>
<div>
    <table>
        <tr>
            <td><a href="/columns/beforeSave">新增</a></td>
        </tr>
    </table>
</div>
<div>
    <table id="jqGrid"></table>
    <div id="jqGridPager"></div>
</div>
<#include "../base/jsLib.ftl">
<script type="text/javascript">
    function deleteById(id) {
        var url = "http://localhost:8080/columns/delete/" + id;
        $.getJSON(url, function (result) {
            console.log(result);
            $("#jqGrid").trigger("reloadGrid");
        });
    }

    $(document).ready(function () {
        $("#jqGrid").jqGrid({
            url: 'http://localhost:8080/columns/page',
            mtype: "GET",
            datatype: "json",
            styleUI: 'Bootstrap',
            colModel: [
                {label: '表名称', name: 'tableName'},
                {label: '列名称', name: 'columnName'},
                {label: '数据类型', name: 'dataType'},
                {label: '注释', name: 'columnComment'},
            ],
            viewrecords: true,
//            loadonce: true, // this is just for the demo
            rowNum: 20,
            height:"60%",
            pager: "#jqGridPager",
            toppager:true,
            jsonReader: {
                root: "data.result",
                page: "data.pageNo", //当前页数
                total: "data.totalPages", // 总页数
                records: "data.totalCount", // 总记录数
                repeatitems: true,
                id: "id"
            },
            prmNames: {
                page: "pageNo",
                rows: "pageSize",
                sort: "orderBy",
                order: "order"
            },
            width: 1600
        });
    });

</script>
</body>
</html>