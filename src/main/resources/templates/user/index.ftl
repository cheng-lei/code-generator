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
<div>
    <table>
        <tr>
            <td><a href="/test/beforeSave">新增</a></td>
        </tr>
    </table>
</div>
<div>
    <table id="jqGrid"></table>
    <div id="jqGridPager"></div>
</div>
<script type="text/javascript">
    function deleteById(id) {
        var url = "http://localhost:8080/user/delete/" + id;
        $.getJSON(url, function (result) {
            console.log(result);
            $("#jqGrid").trigger("reloadGrid");
        });
    }

    $(document).ready(function () {

        $("#jqGrid").jqGrid({
            url: 'http://localhost:8080/user/page',
            mtype: "GET",
            datatype: "json",
            height:"100%",
            styleUI: 'Bootstrap',
            colModel: [
                {label: 'ID', name: 'id', key: true},
                {label: '名称', name: 'name'},
                {label: '年龄', name: 'age'},
                {label: '数学成绩', name: 'mathScore'},
                {label: '语文成绩', name: 'chineseScore'},
                {
                    label: '操作', name: 'operation',
                    formatter: function (o, v, r) {
                        console.log(r.id)
                        var beforeSaveUrl = "/user/beforeSave?id=" + r.id;
                        console.log(beforeSaveUrl);
                        return "<a href='javascript:deleteById(" + r.id + ");'>删除</a> " +
                                "| <a target='_blank'  href='" + beforeSaveUrl + "'>编辑</a>";
                    }
                }
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