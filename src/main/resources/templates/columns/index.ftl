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
            <div class="box-body">
                <form class="form-inline btn-group-custom-search" id="searchForm">
                    <input type="hidden" id="pageSize" name="pageSize" value="${(pageList.pageSize)!}"/>
                    <input type="hidden" id="pageNum" name="pageNum" value="1"/>
                    <input type="hidden" id="orderBy" name="orderBy" value="${(queryList.orderBy)!}"/>
                <@input labelText="标签ID" showWrap=true name="queryId"  value=((queryList.queryId)!) />
                <@input labelText="标签名称" showWrap=true name="queryName" value=((queryList.queryName)!) />
                    <div class="form-group">
                        <label for="queryGroup">标签类型&nbsp;</label>
                        <select class="form-control input-sm" id="queryGroup" name="queryGroup" onChange="formSubmit()">
                            <option value="-1">--全部--</option>
                        </select>
                    </div>

                <@select labelText="标签级别" name="queryType" dataMap=tagType value=(((queryList.queryType)!-1)?string) showWrap=true />
                <@search />
                </form>
            </div>
            <div class="box-header with-border">
                <div class="box-toolbar">
                    <div class="btn-group margin-right-5">
                        <button class="btn btn-primary btn-sm my-btn-add" onclick="saveOrUpdate(this)">添加</button>
                        <button class="btn btn-danger btn-sm my-btn-del" onclick="batchDelete(this)">删除</button>
                    </div>
                </div>
            </div>
            <div class="my-data-jqgrid">
                <table id="jqGrid"></table>
                <div id="jqGridPager"></div>
            </div>
        </section>
    </div>
    <div id="addDiv" style="z-index: 1000;position: absolute;display: none;">
        <section class="content no-padding-bottom">
            <div class="row">
                <form class="form-horizontal form-striped">
                <#if (bppTagGroup.id)??>
                    <div class="form-group">
                        <label for="id" class="col-sm-2 control-label">标签Id</label>
                        <div class="col-sm-3">
                            <input class="form-control input-sm" readonly="readonly" id="id"
                                   name="bppTagGroup.id" value="${bppTagGroup.id}">
                        </div>
                    </div>
                </#if>
                    <div class="form-group">
                        <label for="groupname" class="col-md-2 control-label text-red">*&nbsp;标签组名称</label>
                        <div class="col-md-3">
                            <input type="text" class="form-control input-sm" placeholder="请输入名称" id="groupname"
                                   name="bppTagGroup.groupname" value="${(bppTagGroup.groupname)!}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="rank" class="col-md-2 control-label">权重</label>
                        <div class="col-md-3">
                            <input type="text" class="form-control input-sm" id="rank" name="bppTagGroup.rank"
                                   value="${(bppTagGroup.rank)!0}">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-md-5">
                            <button type="submit" class="btn btn-success">&nbsp;&nbsp;提交&nbsp;&nbsp;</button>
                        </div>
                    </div>
                </form>
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
                    {label: 'ID', name: 'id'},
                    {label: '表名称', name: 'tableName'},
                    {label: '列名称', name: 'columnName'},
                    {label: '数据类型', name: 'dataType'},
                    {label: '注释', name: 'columnComment'},
                    {
                        label: '操作', name: 'operation', formatter: function (o, v, r) {
                        return '<button class="btn btn-primary btn-sm my-btn-add" onclick="saveOrUpdate(this)" data-id='+r.id+'>编辑</button>' +
                                '|<button class="btn btn-danger btn-sm my-btn-del" onclick="batchDelete(this)" data-id='+r.id+'>删除</button>'
                    }
                    }
                ],
                viewrecords: true,
                rowNum: 20,
                height: "60%",
                pager: "#jqGridPager",
                toppager: true,
                multiselect: true,
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
                width: 1000
            });
//            $(".my-btn-add").on('click', function (e) {
//                var that = $(this);
//                var id = that.attr("data-id");
//                if(!id){
//                    id=0;
//                }
//                console.log(that);
//                $('body').popLayer({
//                    target: "body", // 把弹出层添加到的目标节点
//                    position: "center",
//                    data: {id: "saveDiv", source: "remote",url:"/columns/beforeSave/"+id},
//                    height: 600,
//                    width: 800
//                });
//            });


            function getParam() {
                var self = $("#search_form"), serializeParam = self.serializeArray(), param = {};
                $.map(serializeParam, function (k, v) {
                    param[k.name] = format(k.value);
                });
                return param;
            }

            $(".my-btn-search").on('click', function (e) {
                $("#jqGrid").jqGrid('setGridParam', {
                    postData: getParam()
                }).trigger('reloadGrid');
            });
//            $(".my-btn-del").on('click', function (e) {
//                var that = $(this);
//                var id = that.attr("data-id");
//                var isBatchDelete = !id;
//                var ids = [];
//                if(isBatchDelete){//是批量删除
//                    ids = $('#jqGrid').jqGrid('getGridParam', 'selarrrow');
//                }else{//是单个删除
//                    ids.push(id);
//                }
//                console.log(JSON.stringify(ids));
//                if (!ids || ids.length <= 0) {
//                    $.MsgBox.Alert("选项为空请至少选择一项！", "warning");
//                } else {
//                    $.MsgBox.Confirm("警告", "确定要将选中的" + ids.length + "项删除吗？", function (result) {
//                        if (result) {
//                            var trueIdArr=[];
//                            if(isBatchDelete){
//                                var rowDataArr = $('#jqGrid').jqGrid('getRowData', ids);
//                                for(row in rowDataArr){
//                                    trueIdArr.push(row.id);
//                                }
//                            }else{
//                                trueIdArr = ids;
//                            }
//                            console.log("ids:"+JSON.stringify(trueIdArr));
////                            ajaxPost(actionUrl, $("input[name='checkId']:checked").serialize(), function (result) {
//                                $.MsgBox.Alert("测试删除成功!");
////                            });
//                        }
//                    });
//                }
//            });

        });
        function saveOrUpdate(element) {
            var that = $(element);
            var id = that.attr("data-id");
            if(id=='undefined'||!id){
                id=0;
            }
            $('body').popLayer({
                target: "body", // 把弹出层添加到的目标节点
                position: "center",
                data: {id: "saveDiv", source: "remote",url:"/columns/beforeSave/"+id},
                height: 600,
                width: 800,
                footer:[
                    {text:"确定",class:"btn btn-info",handler:function (result) {
                        $.MsgBox.Alert("测试确定成功!");
                    }},{text:"取消",class:"btn btn-info",handler:function (result) {
                        $.MsgBox.Alert("测试取消成功!");
                    }}
                ]
            });
        }
        function batchDelete(element) {
            var that = $(element);
            var id = that.attr("data-id");
            var isBatchDelete = !id;
            var ids = [];
            if(isBatchDelete){//是批量删除
                ids = $('#jqGrid').jqGrid('getGridParam', 'selarrrow');
            }else{//是单个删除
                ids.push(id);
            }
            console.log(JSON.stringify(ids));
            if (!ids || ids.length <= 0) {
                $.MsgBox.Alert("选项为空请至少选择一项！", "warning");
            } else {
                $.MsgBox.Confirm("警告", "确定要将选中的" + ids.length + "项删除吗？", function (result) {
                    if (result) {
                        var trueIdArr=[];
                        if(isBatchDelete){
                            var rowDataArr = $('#jqGrid').jqGrid('getRowData', ids);
                            for(row in rowDataArr){
                                trueIdArr.push(row.id);
                            }
                        }else{
                            trueIdArr = ids;
                        }
                        console.log("ids:"+JSON.stringify(trueIdArr));
//                            ajaxPost(actionUrl, $("input[name='checkId']:checked").serialize(), function (result) {
                        $.MsgBox.Alert("测试删除成功!");
//                            });
                    }
                });
            }
        }
    </script>
</body>
</html>
