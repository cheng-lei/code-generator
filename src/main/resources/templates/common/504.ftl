<!DOCTYPE html>
<html>
<head>
  <#include "/pages/base/csslink.ftl">
</head>
<body class=<@getSkinClass />>
<div class="wrapper">
  <#include "/pages/base/header.ftl">
  <#include "/pages/base/sidebar.ftl">
  <!-- start page content -->
  <div class="content-wrapper">
    <section class=" error-content">
      <div class="headline text-red">${error.errorCode}</div>
      <div class="status">
        <div class="error">
          <i class="fa fa-bug text-red"></i>&nbsp;${error.message}&nbsp;&nbsp;&nbsp;<a href="" class="btn btn-danger btn-sm"><i class="fa fa-envelope"></i> <small> 发送Bug邮件</small></a>
        </div>
        <div class="panel-group" id="error">
          <div class="panel panel-default no-border">
            <div class="panel-heading">
              <h4 class="panel-title font-14">
                	详细信息：<a class="text-blue" data-toggle="collapse" data-parent="#error" href="#error-details">点击查看</a>
              </h4>
            </div>
            <div id="error-details" class="panel-collapse collapse">
              <div class="panel-body pad-tb-6 no-padding-left pad-tb-6 no-border" style="background: #ECF0F5;">
                <pre class="bg-white font-14">
                	${(error.trace)!}
                </pre>
              </div>
            </div>
          </div>
        </div>
        <a class="btn btn-danger"  onclick="history.back()">&nbsp;返&nbsp;回&nbsp;</a>
      </div>
    </section>
  </div>
  <!-- end page content -->
  <#include "/pages/base/footer.ftl">
</div>
<#include "/pages/base/jslib.ftl">
</body>
</html>