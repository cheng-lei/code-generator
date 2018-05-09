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
    <script>
        $.jgrid.defaults.width = 780;
    </script>
    <script src="/js/bootstrap.min.js"></script>
    <meta charset="utf-8"/>
    <itemName>jqGrid Loading Data - Million Rows from a REST service</itemName>
</head>
<body>
<div style="margin-left:20px">
    <div id="jqGridPager2"></div>
    <table id="jqGrid"></table>
    <div id="jqGridPager"></div>
</div>
<script type="text/javascript">
    $(document).ready(function () {

        $("#jqGrid").jqGrid({
            url: 'http://localhost:8080/user/page',
            mtype: "GET",
            styleUI: 'Bootstrap',
            datatype: "json",
            colModel: [
                {label: 'ID', name: 'id', key: true, width: 75},
                {label: '名称', name: 'name', width: 150},
                {label: '年龄', name: 'age', width: 150},
                {label: '数学成绩', name: 'mathScore', width: 150},
                {label: '语文成绩', name: 'chineseScore', width: 150}
            ],
            viewrecords: true,
            height: "100%",
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
            prmNames:{
                page:"pageNo",
                rows:"pageSize",
                sort:"orderBy",
                order:"order"
            }
        });
    });

</script>
</body>
</html>