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
      <div class="headline text-red">${(error.errorCode)!500}</div>
      <div class="status">
        <div class="error">
          <i class="fa fa-bug text-red"></i>&nbsp;服务端出错了，点击发送Bug邮件通知管理员~&nbsp;&nbsp;&nbsp;
        </div>
        <div class="panel-group" id="error">
          <div class="panel panel-default no-border">
            <div class="panel-heading">
              <h4 class="panel-title font-14">错误信息：${(error.message)!}&nbsp;&nbsp;
                <a class="text-blue" data-toggle="collapse" data-parent="#error" href="#error-details">查看详情</a>
              </h4>
            </div>
            <div id="error-details" class="panel-collapse collapse">
              <div class="panel-body pad-tb-6 no-padding-left pad-tb-6 no-border" style="background: #ECF0F5;">
                <pre class="bg-white font-14">${(((error.trace)!'') == '')?string('${(error.message)!}', '${(error.trace)!}')}</pre>
              </div>
            </div>
          </div>
        </div>
        <#if (((error.trace)!'')?length >600) >
          <#assign trace=(error.trace)!?substring(0, 600) />
        <#else>
          <#assign trace=(error.trace)! />
        </#if>
        <a href="mailto:mipdev@pptv.com?cc=mipqa@pptv.com;mippm@pptv.com&subject=Mipweb-${(error.errorCode)!500}异常模块：'${request.getRequestUri()}'&body=${trace}..." 
          class="btn btn-danger"><i class="fa fa-envelope"></i>&nbsp;发送Bug邮件</a>&nbsp;&nbsp;&nbsp;
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