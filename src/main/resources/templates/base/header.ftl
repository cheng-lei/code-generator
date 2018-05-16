  <!-- start header-->
  <header class="main-header">
    <a href="user/welcome.action" class="logo">
      <span class="logo-mini"><b>CGP</b></span>
      <span class="logo-lg"><b>CGP</b>&nbsp;代码管理平台</span>
    </a>
    <nav class="navbar navbar-static-top" role="navigation">
      <a class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="glyphicon glyphicon-list"></span>
      </a>
      <!-- start custom-nav -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <li>
            <a href="user/welcome.action" title="回到主页"><span class="glyphicon glyphicon-home"></span></a>
          </li>
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" title="个性化设置">
              <span class="glyphicon glyphicon-user"></span>
              <span class="hidden-xs">${(user.domainUserName)!}</span>
            </a>
            <ul class="dropdown-menu">
              <li class="user-header">
                <p>欢迎使用代码管理平台
                  <small>今天：${.now?string("yyyy年MM月dd日 EEE")}</small>
                </p>
              </li>
              <li class="user-body">
                <div class="row">
                  <div class="col-xs-4 text-center pad-lr-6">
                    <span>顶部导航栏</span>
                  </div>
                  <div class="col-xs-8 text-left top-menu pad-lr-6">
                    <a data-skin="skin-blue" class="btn btn-primary btn-xs ${(((user.userSetting.skincolor)!'skin-blue')?index_of('skin-blue')!=-1)?string('selected','')}"><b></b><i class="fa fa-eye text-white"></i></a>
                    <a data-skin="skin-red" class="btn btn-danger btn-xs ${(((user.userSetting.skincolor)!'skin-blue')?index_of('skin-red')!=-1)?string('selected','')}"><b></b><i class="fa fa-eye text-white"></i></a>
                    <a data-skin="skin-yellow" class="btn btn-warning btn-xs ${(((user.userSetting.skincolor)!'skin-blue')?index_of('skin-yellow')!=-1)?string('selected','')}"><b></b><i class="fa fa-eye text-white"></i></a>
                    <a data-skin="skin-purple" class="btn btn-purple btn-xs ${(((user.userSetting.skincolor)!'skin-blue')?index_of('skin-purple')!=-1)?string('selected','')}"><b></b><i class="fa fa-eye text-white"></i></a>
                    <a data-skin="skin-green" class="btn btn-success btn-xs ${(((user.userSetting.skincolor)!'skin-blue')?index_of('skin-green')!=-1)?string('selected','')}"><b></b><i class="fa fa-eye text-white"></i></a>
                  </div>
                </div>
                <div class="row margin-top">
                  <div class="col-xs-4 text-center pad-lr-6">
                    <span>左侧菜单栏</span>
                  </div>
                  <div class="col-xs-8 text-left left-menu pad-lr-6">
                    <a data-skin="black" class="btn btn-black btn-xs ${(((user.userSetting.skincolor)!'skin-blue')?index_of('-light')==-1)?string('selected','')}"><b></b><i class="fa fa-eye text-white"></i></a>
                    <a data-skin="light" class="btn btn-light btn-xs ${(((user.userSetting.skincolor)!'skin-blue')?index_of('-light')!=-1)?string('selected','')}"><b></b><i class="fa fa-eye text-black"></i></a>
                  </div>
                </div>
              </li>
              <li class="user-footer">
                <div class="pull-left">
                  <a href="user/showMySetting.action" class="btn btn-default btn-flat">个性化设置</a>
                </div>
                <div class="pull-right">
                  <a href="user/logout.action" class="btn btn-default btn-flat">退出系统</a>
                </div>
              </li>
            </ul>
          </li>
          <li>
            <a href="sys/addSysDemand.action" title="我要反馈"><span class="glyphicon glyphicon-star-empty"></span></a>
          </li>
          <li>
            <a href="user/logout.action" title="退出系统"><span class="glyphicon glyphicon-log-out"></span></a>
          </li>
        </ul>
      </div>
      <!-- end custom-nav -->
    </nav>
  </header>
  <!-- end header -->
