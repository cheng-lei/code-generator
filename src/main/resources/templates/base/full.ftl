<!DOCTYPE html>
<html>
<head>
  <base href="<%=basePath%>">
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>MIP媒资管理平台</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="http://cdn.bootcss.com/font-awesome/4.4.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css">
  <link rel="stylesheet" href="dist/css/AdminLTE.css">
  <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
  <link rel="stylesheet" href="plugins/iCheck/flat/blue.css">
  <link rel="stylesheet" href="plugins/morris/morris.css">
  <link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css">
  <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
  <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker-bs3.css">
  <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
  <header class="main-header">
    <a href="index.jsp" class="logo">
      <span class="logo-mini"><b>MIP</b></span>
      <span class="logo-lg"><b>MIP</b>&nbsp;媒资管理平台</span>
    </a>
    <nav class="navbar navbar-static-top" role="navigation">
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="glyphicon glyphicon-list"></span>
      </a>
      <!-- start custom-nav -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <li>
            <a href="index.jsp" title="回到主页"><span class="glyphicon glyphicon-home"></span></a>
          </li>
          <!-- start messages-meun -->
          <li class="dropdown messages-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <span class="glyphicon glyphicon-envelope"></span>
              <span class="label label-warning">5</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">您有5条未处理消息</li>
              <li>
                <ul class="menu">
                  <li><a href="#"><i class="fa fa-warning text-yellow"></i> message 1</a></li>
                  <li><a href="#"><i class="fa fa-warning text-yellow"></i> message 1</a></li>
                  <li><a href="#"><i class="fa fa-warning text-yellow"></i> message 1</a></li>
                  <li><a href="#"><i class="fa fa-warning text-yellow"></i> message 1</a></li>
                  <li><a href="#"><i class="fa fa-warning text-yellow"></i> message 1</a></li>
                </ul>
              </li>
              <li class="footer"><a href="#">查看全部</a></li>
            </ul>
          </li>
          <!-- end messages-menu -->

          <!-- start user-menu -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <span class="glyphicon glyphicon-user"></span>
              <span class="hidden-xs">Administrator</span>
            </a>
            <ul class="dropdown-menu">
              <li class="user-header">
                <p>欢迎使用媒资管理平台
                  <small>今天：2015年9月6日 星期日</small>
                </p>
              </li>
              <li class="user-body">
                <div class="row">
                  <div class="col-xs-4 text-left">
                    <span>导航栏颜色</span>
                  </div>
                  <div class="col-xs-8 text-left">
                    <a href="#">蓝色、红色、绿色、黄色、紫色</a>
                  </div>
                </div>
                <div class="row">
                  <div class="col-xs-4 text-left">
                    <span>菜单栏颜色</span>
                  </div>
                  <div class="col-xs-8 text-left">
                    <a href="#">深灰、浅白</a>
                  </div>
                </div>
              </li>
              <li class="user-footer">
                <div class="pull-left">
                  <a href="#" class="btn btn-default btn-flat">修改信息</a>
                </div>
                <div class="pull-right">
                  <a href="#" class="btn btn-default btn-flat">退出系统</a>
                </div>
              </li>
            </ul>
          </li>
          <li>
            <a href="#" title="我要反馈"><span class="glyphicon glyphicon-star-empty"></span></a>
          </li>
          <li>
            <a href="#" title="退出系统"><span class="glyphicon glyphicon-log-out"></span></a>
          </li>
        </ul>
      </div>
      <!-- end custom-nav -->
    </nav>
  </header>

  <!-- start left sidebar -->
  <aside class="main-sidebar">
    <section class="sidebar">
      <div class="user-panel">
        <div class="pull-left image">
          <img src="dist/img/user1-128x128.jpg" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p>Administrator</p>
          <a href="#"><span class="fa fa-circle text-success"></span>超级管理员</a>
        </div>
      </div>
      <!-- start sidebar-menu -->
      <ul class="sidebar-menu">
        <li class="header"><b>视频信息管理</b></li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-list"></i><span>BPP基础节目管理</span><i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="#"><i class="fa fa-link"></i>频道入库</a></li>
            <li><a href="#"><i class="fa fa-link"></i>频道列表</a></li>
            <li><a href="#"><i class="fa fa-link"></i>剧集管理</a></li>
            <li><a href="#"><i class="fa fa-link"></i>合集管理</a></li>
            <li><a href="#"><i class="fa fa-link"></i>视频雷达</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-list"></i><span>EPG前端节目管理</span><i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="#"><i class="fa fa-link"></i>网站节目管理</a></li>
            <li><a href="#"><i class="fa fa-link"></i>客户端管理</a></li>
            <li><a href="#"><i class="fa fa-link"></i>IPhone节目管理</a></li>
            <li><a href="#"><i class="fa fa-link"></i>IPad节目管理</a></li>
            <li><a href="#"><i class="fa fa-link"></i>AndroidPhone管理</a></li>
            <li><a href="#"><i class="fa fa-link"></i>AndroidPad管理</a></li>
            <li><a href="#"><i class="fa fa-link"></i>WinPhone节目管理</a></li>
            <li><a href="#"><i class="fa fa-link"></i>Win8节目管理</a></li>
            <li><a href="#"><i class="fa fa-link"></i>TV节目管理</a></li>
            <li><a href="#"><i class="fa fa-link"></i>定时发布管理</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-list"></i><span>标签分类管理</span><i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="#"><i class="fa fa-link"></i>BPP基础分类</a></li>
            <li><a href="#"><i class="fa fa-link"></i>EPG前端分类</a></li>
            <li><a href="tag/queryBppTags.action"><i class="fa fa-link"></i>标签管理</a></li>
            <li><a href="tag/queryBppTagGroups.action"><i class="fa fa-link"></i>标签组管理</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-list"></i><span>综合信息管理</span><i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="#"><i class="fa fa-link"></i>节目热度</a></li>
            <li><a href="#"><i class="fa fa-link"></i>播放次数</a></li>
            <li><a href="#"><i class="fa fa-link"></i>UGC流量</a></li>
            <li><a href="#"><i class="fa fa-link"></i>花絮关联</a></li>
            <li><a href="#"><i class="fa fa-link"></i>CDN刷新</a></li>
            <li><a href="#"><i class="fa fa-link"></i>CDN删除</a></li>
            <li><a href="#"><i class="fa fa-link"></i>同步黑名单</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-list"></i><span>BPP基础节目管理</span><i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="#"><i class="fa fa-link"></i>频道入库</a></li>
            <li><a href="#"><i class="fa fa-link"></i>频道列表</a></li>
            <li><a href="#"><i class="fa fa-link"></i>剧集管理</a></li>
            <li><a href="#"><i class="fa fa-link"></i>合集管理</a></li>
            <li><a href="#"><i class="fa fa-link"></i>视频雷达</a></li>
          </ul>
        </li>
        <li class="header"><b>百科信息管理</b></li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-list"></i><span>百科管理</span><i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="#"><i class="fa fa-link"></i>电影百科</a></li>
            <li><a href="#"><i class="fa fa-link"></i>电视剧百科</a></li>
            <li><a href="#"><i class="fa fa-link"></i>综艺百科</a></li>
            <li><a href="#"><i class="fa fa-link"></i>综艺百科</a></li>
            <li><a href="#"><i class="fa fa-link"></i>动漫百科</a></li>
            <li><a href="#"><i class="fa fa-link"></i>人物百科</a></li>
            <li><a href="#"><i class="fa fa-link"></i>体育百科</a></li>
            <li><a href="#"><i class="fa fa-link"></i>游戏百科</a></li>
            <li><a href="#"><i class="fa fa-link"></i>数据审核</a></li>
          </ul>
        </li>
      </ul>
    </section>
  </aside>
  <!-- end left sidebar -->

  <!-- start page content -->
  <div class="content-wrapper">
    <!-- start location bar -->
    <section class="content-header">
      <h1>欢迎页
        <small>Welcome</small>
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-dashboard"></i>&nbsp;欢迎页</li>
      </ol>
    </section>
    <!-- end location bar -->

    <!-- start main content -->
    <section class="content no-padding-bottom">
      <div class="row">
        <div class="col-md-12">
          <div class="box box-success">
            <div class="box-header with-border">
              <h3 class="box-title">用户登录信息 | 系统图标说明</h3>

              <div class="box-tools pull-right">
                <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
              </div>
            </div>
            <div class="box-body">
              <div class="row">
                <div class="col-md-4 border-right">
                  <p class="text-center">
                    <strong>用户登录信息</strong>
                  </p>

                  <div class="row">
                    <div class="col-md-4">用户名：</div>
                    <div class="col-md-8">Administrator</div>
                    <div class="col-md-4">域帐号：</div>
                    <div class="col-md-8">admin</div>
                    <div class="col-md-4">所属角色：</div>
                    <div class="col-md-8">admin</div>
                    <div class="col-md-4">登录IP：</div>
                    <div class="col-md-8">192.168.27.169</div>
                  </div>
                </div>
                <!-- /.col -->
                <div class="col-md-8">
                  <p class="text-center">
                    <strong>系统图标说明</strong>
                  </p>

                  <div class="">
                    TODO
                  </div>
                </div>
              </div>
            </div>
            <!-- end box-body -->
          </div>
        </div>
      </div>
      <!-- start main table -->
      <div class="row">
        <div class="col-md-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">反馈列表</h3>

              <div class="box-toolbar pull-right">
                <div class="input-group" style="width: 150px;">
                  <input type="text" name="table_search" class="form-control input-sm pull-right" placeholder="Search">

                  <div class="input-group-btn">
                    <button class="btn btn-sm btn-default"><i class="fa fa-search"></i></button>
                  </div>
                </div>
              </div>
            </div>
            <div class="box-body pad-tb-2">
              <table class="table table-hover table-bordered dataTable">
                <tbody>
                <tr>
                  <th width="8%">序号</th>
                  <th width="8%">类型</th>
                  <th width="16%">标题</th>
                  <th width="30%">描述</th>
                  <th width="8%">提供者</th>
                  <th width="10%">提出时间</th>
                  <th width="8%">状态</th>
                  <th width="12%">操作</th>
                </tr>
                <tr>
                  <td>1</td>
                  <td>Bug修复</td>
                  <td>选择窗口按钮超出宽屏屏幕点击不到保存按钮</td>
                  <td>在操作时，有些选择窗口确定，保护会超出电脑屏幕边际（特别是宽屏机器，高度比较小），这样选择后无法点到确定，保存等按键，无法保存，必须点F11让浏览器全屏才能看到按钮。</td>
                  <td>钱骏</td>
                  <td>2011-08-29 22:40:11</td>
                  <td><span class="label label-success">已完成</span></td>
                  <td>查看 | 修改 | 删除</td>
                </tr>
                <tr>
                  <td>2</td>
                  <td>新需求</td>
                  <td>在频道列表内增加可查看相关资料的入口</td>
                  <td>目前，频道列表内只有显示片名，不能显示更为详细相关资料，望能增加一入口可供查看详细资料。 ----> 答：频道列表点详细不是可以看到更详细的相关资料吗？</td>
                  <td>蔡鲁庆</td>
                  <td>2011-07-21 18:40:11</td>
                  <td><span class="label label-success">已完成</span></td>
                  <td>查看 | 修改 | 删除</td>
                </tr>
                <tr>
                  <td>3</td>
                  <td>新需求</td>
                  <td>娱乐的合集没有截图</td>
                  <td>娱乐的合集没有截图,答：合集本来就是没有截图的</td>
                  <td>李珺玮</td>
                  <td>2011-04-21 18:40:11</td>
                  <td><span class="label label-warning">处理中</span></td>
                  <td>查看 | 修改 | 删除</td>
                </tr>
                <tr>
                  <td>4</td>
                  <td>Bug修复</td>
                  <td>选择窗口按钮超出宽屏屏幕点击不到保存按钮</td>
                  <td>在操作时，有些选择窗口确定，保护会超出电脑屏幕边际（特别是宽屏机器，高度比较小），这样选择后无法点到确定，保存等按键，无法保存，必须点F11让浏览器全屏才能看到按钮。</td>
                  <td>钱骏</td>
                  <td>2011-08-29 22:40:11</td>
                  <td><span class="label label-success">已完成</span></td>
                  <td>查看 | 修改 | 删除</td>
                </tr>
                <tr>
                  <td>5</td>
                  <td>新需求</td>
                  <td>在频道列表内增加可查看相关资料的入口</td>
                  <td>目前，频道列表内只有显示片名，不能显示更为详细相关资料，望能增加一入口可供查看详细资料。 ----> 答：频道列表点详细不是可以看到更详细的相关资料吗？</td>
                  <td>蔡鲁庆</td>
                  <td>2011-07-21 18:40:11</td>
                  <td><span class="label label-success">已完成</span></td>
                  <td>查看 | 修改 | 删除</td>
                </tr>
                <tr>
                  <td>6</td>
                  <td>新需求</td>
                  <td>娱乐的合集没有截图</td>
                  <td>娱乐的合集没有截图,答：合集本来就是没有截图的</td>
                  <td>李珺玮</td>
                  <td>2011-04-21 18:40:11</td>
                  <td><span class="label label-warning">处理中</span></td>
                  <td>查看 | 修改 | 删除</td>
                </tr>
                <tr>
                  <td>7</td>
                  <td>Bug修复</td>
                  <td>选择窗口按钮超出宽屏屏幕点击不到保存按钮</td>
                  <td>在操作时，有些选择窗口确定，保护会超出电脑屏幕边际（特别是宽屏机器，高度比较小），这样选择后无法点到确定，保存等按键，无法保存，必须点F11让浏览器全屏才能看到按钮。</td>
                  <td>钱骏</td>
                  <td>2011-08-29 22:40:11</td>
                  <td><span class="label label-success">已完成</span></td>
                  <td>查看 | 修改 | 删除</td>
                </tr>
                <tr>
                  <td>8</td>
                  <td>新需求</td>
                  <td>在频道列表内增加可查看相关资料的入口</td>
                  <td>目前，频道列表内只有显示片名，不能显示更为详细相关资料，望能增加一入口可供查看详细资料。 ----> 答：频道列表点详细不是可以看到更详细的相关资料吗？</td>
                  <td>蔡鲁庆</td>
                  <td>2011-07-21 18:40:11</td>
                  <td><span class="label label-success">已完成</span></td>
                  <td>查看 | 修改 | 删除</td>
                </tr>
                <tr>
                  <td>9</td>
                  <td>新需求</td>
                  <td>娱乐的合集没有截图</td>
                  <td>娱乐的合集没有截图,答：合集本来就是没有截图的</td>
                  <td>李珺玮</td>
                  <td>2011-04-21 18:40:11</td>
                  <td><span class="label label-warning">处理中</span></td>
                  <td>查看 | 修改 | 删除</td>
                </tr>
                <tr>
                  <td>10</td>
                  <td>Bug修复</td>
                  <td>选择窗口按钮超出宽屏屏幕点击不到保存按钮</td>
                  <td>在操作时，有些选择窗口确定，保护会超出电脑屏幕边际（特别是宽屏机器，高度比较小），这样选择后无法点到确定，保存等按键，无法保存，必须点F11让浏览器全屏才能看到按钮。</td>
                  <td>钱骏</td>
                  <td>2011-08-29 22:40:11</td>
                  <td><span class="label label-success">已完成</span></td>
                  <td>查看 | 修改 | 删除</td>
                </tr>
                </tbody>
              </table>
              <!-- start paginator -->
              <div class="col-sm-5 no-padding">
                <div class="dataTables_info form-inline input-page">总计5000条&nbsp;/&nbsp;共250页&nbsp;&nbsp;每页显示
                  <select class="form-control input-sm">
                    <option value="10">10</option>
                    <option value="15">15</option>
                    <option value="20" selected="selected">20</option>
                    <option value="25">25</option>
                    <option value="30">30</option>
                  </select> 条
                </div>
              </div>
              <div class="col-sm-7 pull-right no-padding">
                <div class="dataTables_paginate">
                  <ul class="pagination pagination-sm">
                    <li class="previous"><a href="#">首页</a></li>
                    <li class="previous"><a href="#">上一页</a></li>
                    <li class="active"><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li><a href="#">6</a></li>
                    <li><a href="#">7</a></li>
                    <li><a href="#">8</a></li>
                    <li><a href="#">9</a></li>
                    <li><a href="#">10</a></li>
                    <li class="next"><a href="#">下一页</a></li>
                    <li class="next"><a href="#">尾页</a></li>
                  </ul>
                </div>
              </div>
              <!-- end paginator -->
            </div>
          </div>
        </div>
      </div>
      <!-- end main table -->
    </section>
  </div>
  <!-- end page content -->

  <!-- start footer -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs"><b>Version</b> 0.0.1</div>
    <strong>Copyright © 2015 PPLive Inc. </strong>All Rights Reserved. 上海聚力传媒技术有限公司 版权所有
  </footer>
  <div class="control-sidebar-bg"></div>
  <!-- end footer -->
</div>
<!-- ref js lib -->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="plugins/morris/morris.min.js"></script>
<script src="plugins/sparkline/jquery.sparkline.min.js"></script>
<script src="plugins/knob/jquery.knob.js"></script>
<script src="plugins/daterangepicker/daterangepicker.js"></script>
<script src="plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
<script src="plugins/fastclick/fastclick.min.js"></script>
<script src="dist/js/app.min.js"></script>
</body>
</html>
