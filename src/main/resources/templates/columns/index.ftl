<!DOCTYPE html>

<html lang="en">
<head>
    <!-- The jQuery library is a prerequisite for all jqSuite products -->
    <script type="text/ecmascript" src="/js/jquery-1.11.0.min.js"></script>
    <!-- We support more than 40 localizations -->
    <script type="text/ecmascript" src="/js/grid.locale-cn.js"></script>
    <!-- This is the Javascript file of jqGrid -->
    <script type="text/ecmascript" src="/js/jquery.jqGrid.min.js"></script>
    <!-- This is the localization file of the grid controlling messages, labels, etc.
    <!-- A link to a jQuery UI ThemeRoller theme, more than 22 built-in and many more custom -->
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <!-- The link to the CSS that the grid needs -->
    <link rel="stylesheet" type="text/css" media="screen" href="/css/ui.jqgrid-bootstrap.css"/>
    <meta charset="utf-8"/>
    <itemName>GRID</itemName>
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
            pager: "#jqGridPager",
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
            }
        });
    });

</script>
</body>
</html>