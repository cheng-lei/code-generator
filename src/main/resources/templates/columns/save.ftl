<!DOCTYPE html>
<html>
<head>
<#include "../base/csslink.ftl">
</head>
<body class="hold-transition sidebar-mini skin-red overflow">
<div class="wrapper">
<#include "../base/header.ftl">
<#--<#include "../base/sidebar.ftl">-->
    <!-- start page content -->
    <div class="content-wrapper">
    <#--<#include "../base/location.ftl">-->
        <section class="content no-padding-bottom">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary bg-gray-light">
                        <div class="box-header with-border bg-white">
                            <h3 class="box-title">标签组信息</h3>
                        </div>
                        <div class="box-body pad-tb-2 min-h600">
                            <div class="pad-lr-6">
                                <form id="tagGroupForm" class="form-horizontal form-striped" action="tag/${(bppTagGroup.id)???string("updateBppTagGroup","addBppTagGroup")}.action" method="post">
                                <#if (bppTagGroup.id)??>
                                    <div class="form-group">
                                        <label for="id" class="col-sm-2 control-label">标签Id</label>
                                        <div class="col-sm-3">
                                            <input class="form-control input-sm rank" readonly="readonly" id="id" name="bppTagGroup.id" value="${bppTagGroup.id}">
                                        </div>
                                    </div>
                                </#if>
                                    <div class="form-group">
                                        <label for="groupname" class="col-md-2 control-label text-red">*&nbsp;标签组名称</label>
                                        <div class="col-md-3">
                                            <input type="text" class="form-control input-sm" placeholder="请输入名称" id="groupname" name="bppTagGroup.groupname" value="${(bppTagGroup.groupname)!}">
                                        </div>
                                    </div>
                                <#if !(bppTagGroup.id)??>
                                    <input type="hidden" class="form-control" id="id" name="bppTagGroup.id" value="">
                                </#if>
                                    <div class="form-group">
                                        <label for="rank" class="col-md-2 control-label">权重</label>
                                        <div class="col-md-3">
                                            <input type="text" class="form-control input-sm rank" id="rank" name="bppTagGroup.rank" value="${(bppTagGroup.rank)!0}">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-2 col-md-5">
                                            <button type="submit" class="btn btn-success">&nbsp;&nbsp;提交&nbsp;&nbsp;</button>
                                            <a type="button" class="btn btn-primary" href="">&nbsp;&nbsp;返回&nbsp;&nbsp;</a>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <!-- end page content -->
<#include "../base/footer.ftl">
</div>
<#include "../base/jslib.ftl">
<script type="text/javascript">
    // 参数校验
    $(function(){
        $("form").validate({
            rules: {
                'bppTagGroup.groupname':{
                    required:true,
                    noblank:true,
                    maxlength:50,
                    remote:{
                        url: "tag/ajaxValidateBppTagGroupName.action",
                        type: "post",
                        dataType: "json",
                        data: {
                            id: function() {
                                return $("#id").val();
                            },
                            groupname: function() {
                                return $("#groupname").val();
                            }
                        }
                    }
                },
                'bppTagGroup.rank': {
                    digitsTrim:true,
                    maxlength:9
                }
            },
            messages: {
                'bppTagGroup.groupname':{
                    required:"标签组名不能为空",
                    noblank:"标签组名不能全为空格",
                    maxlength:"长度不能超过50个字符"
                },
                'bppTagGroup.rank': {
                    digitsTrim:"权重必须为整数",
                    maxlength :"权重长度不能超过9位"
                }
            },
            // 定义错误信息的位置
            errorPlacement: function(error, element) {
                error.appendTo(element.closest(".form-group"));
                error.addClass("col-md-2 margin-top-6 text-nowrap");
            },
            // 焦点失去时触发
            onfocusout: function(element) {
                this.element(element);
            }
        });
    });
</script>
</body>
</html>