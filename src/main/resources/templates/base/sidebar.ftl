  <!-- start left sidebar -->
  <aside class="main-sidebar">
    <section class="sidebar">
      <div class="user-panel">
        <div class="pull-left image">
          <#assign roleImage="auditor"/>
          <#if ((user.roleName)?? && user.roleName == '超级管理员')>
            <#assign roleImage="sadmin"/>
          <#elseif ((user.roleName)?? && (user.roleName == '超级管理员' || user.roleName?index_of('管理员')>-1 || user.roleName?index_of('经理')>-1))>
            <#assign roleImage="admin"/>
          <#elseif ((user.roleName)?? && user.roleName?index_of('编辑')>-1)>
            <#assign roleImage="editor"/>
          <#elseif ((user.roleName)?? && user.roleName == '观看者')>
            <#assign roleImage="guest"/>
          </#if>
          <#if ((ftlUtil)??)>          
	        	<#assign Avatar=((ftlUtil.getAvatar((user.domainUserName)!''))) />
          </#if>
          <img src="${Avatar!'dist/img/role-${roleImage}.png'}" style="height:45px;width:45px;" class="img-circle" alt="${Avatar!''}" onerror="this.src='dist/img/role-${roleImage}.png'">
        </div>
        <div class="pull-left info">
          <p>${(user.userName)!'未知用户'}</p>
          <span class="fa fa-circle text-success"></span>&nbsp;${(user.roleName)!'未知角色'}
        </div>
      </div>
      <!-- start sidebar-menu -->
      <ul class="sidebar-menu">
        <#list (user.moduleList)! as parent>
          <#if (((parent.subModuleList)![])?size >0)>
          <li class="treeview ${(((pageBean.locationList[0].name)!)=='${parent.modulename}')?string('active','')}">
            <a href="${parent.actionurl!}">
              <#if (parent.actionicon??) && parent.actionicon!="">
                <i class="${(parent.actionicon)!'fa fa-list'}"></i><span>${parent.modulename}</span><i class="fa fa-angle-left pull-right"></i>
              <#else>
                <i class="fa fa-list"></i><span>${parent.modulename}</span><i class="fa fa-angle-left pull-right"></i>
              </#if>
            </a>
            <#if (parent.subModuleList?size > 0)>
              <ul class="treeview-menu">
                <#list parent.subModuleList as sub>
                  <li class="${(((pageBean.locationList[1].name)!)=='${sub.modulename}')?string('active','')}">
                    <a href="${(sub.actionurl)???string('${(sub.actionurl)!}','javascript:void(0)')}">
                      <#if (sub.actionicon??) && sub.actionicon!="">
                        <i class="${(sub.actionicon)!'fa fa-link'}"></i>
                      <#else>
                        <i class="fa fa-link"></i>
                      </#if>
                    ${sub.modulename}</a>
                  </li>
                </#list>
              </ul>
            </#if>
          </li>
          </#if>
        </#list>
      </ul>
    </section>
  </aside>
  <!-- end left sidebar -->
      