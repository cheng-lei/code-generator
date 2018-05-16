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
  	<section class="error-content">
      <div class="headline text-yellow">${error.errorCode}</div>
      <div class="status">
        <div class="warning">
          <i class="fa fa-warning text-yellow"></i>&nbsp;${error.message}
        </div>
        <h4 class="font-14">错误信息：${(error.trace)!}</h4>
        <a class="btn btn-warning" href="user/welcome.action">返回主页</a>
      </div>
    </section>
  </div>
  <!-- end page content -->
  <#include "/pages/base/footer.ftl">
</div>
<#include "/pages/base/jslib.ftl">
</body>
</html>