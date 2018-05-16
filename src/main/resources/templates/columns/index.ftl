<!DOCTYPE html>
<html>
<head>
<#include "../base/csslink.ftl">
  <#include "../base/macro.ftl">
</head>
<body class="hold-transition sidebar-mini skin-red overflow">
<div class="wrapper">
<#include "../base/header.ftl">
<#--<#include "../base/sidebar.ftl">-->
    <!-- start page content -->
    <div class="content-wrapper">
    <#--<#include "../base/location.ftl">-->
        <section class="content no-padding-bottom">
            <div>
                <table id="jqGrid"></table>
                <div id="jqGridPager"></div>
            </div>
        </section>
    </div>
    <!-- end page content -->
<#include "../base/footer.ftl">
    <!-- ref js lib -->
<#include "../base/jslib.ftl">
<script type="text/javascript">
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
            }
        });
    });
</script>
</body>
</html>
