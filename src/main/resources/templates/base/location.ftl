    <!-- start location bar -->
    <section class="content-header">
      <h1>${(pageBean.currLocation.name)!}
        <small>${(pageBean.currLocation.tableName)!}&nbsp;
          <small class="text-green text-bold">(响应时间:${(useTime)!}s)</small>
        </small>
      </h1>
      <ol class="breadcrumb">
        <#if ((pageBean.locationList)??)>
          <#list (pageBean.locationList) as item>
            <li>
              <#if (item_has_next)>
                <a href="${((item.actionUrl!'')!='')?string('${(item.actionUrl)!}','javascript:void(0)')}">
                  <#if (item_index==0)>
                    <i class="fa fa-dashboard"></i>
                  </#if>  
                  ${(item.name)!}
                </a>
              <#else>
                ${(item.name)!}
              </#if>
            </li>
          </#list>
        <#else>
          <li class="active"><i class="fa fa-dashboard"></i>&nbsp;${(pageBean.currLocation.name)!}</li>
        </#if>
      </ol>
    </section>
    <!-- end location bar -->
