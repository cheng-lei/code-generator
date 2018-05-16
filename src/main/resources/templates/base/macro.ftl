<#-- 
  输入框宏定义，参数说明：
    name    : (必传参数) 输入框的name属性
    id      : 输入框的id属性，取值顺序：inputId > inputName
    type    : 输入框的type属性，默认值：text即文本输入框，支持: hidden、password、button、checkbox、radio等
    value    : 输入框的value属性，默认为空字符串""
    extAttr    : 输入框扩展属性，即参数没有支持属性，直接传字符串即可，例如：valid="{required: true,noblank:true}"参数校验使用
    placeholder  : 输入框的placeholder属性，如果不传 则值判断labelText的值，如果labelText值不为空值为:请输入${labelText},否则为空字符串
    extClass  : 输入框的扩展样式, 例如日期选择功能可以使用extClass="date-selected"
    labelText  : 输入框label元素的值，如果不传取值顺序：labelText > id > name
    showWrap  : 是否输出外层div元素，默认输出
    showLabel  : 是否输出label标签，默认输出
    wrapClass  : 外层div的扩展样式，默认空字符串，当是修改页面的第1行时需要添加margin-top-6样式补充间距
    inputWrapClass : 指定input外部div样式，默认为col-md-6
    theme    : 外观样子，默认是适合于筛选条件区域使用的，theme取值：search(默认值，筛选区域使用)、update(修改页面使用，2-6分栏)
    required : 是否是必填项，默认值false	
  使用示例：
  <@input name="userName"/>
  <@input labelText="配置项ID" name="queryId" value=((queryList.queryId)!)/>
  <@input labelText="配置项ID" name="queryId" value=((queryList.queryId)!) theme="update" wrapClass="margin-top-6"/> # 修改页第1行
  <@input labelText="配置项ID" name="queryId" value=((queryList.queryId)!) theme="update"/>
 -->
<#macro input name id="" type="text" value="" extAttr="" placeholder="" extClass="" labelText="" theme="search" showWrap=true showLabel=true inputWrapClass="col-md-6" wrapClass="" required=false>
  <#local lblFor = (id=='')?string(name, id) />
  <#local lblText= (labelText=='')?string(lblFor, labelText) />
  <#local txtAlt = (placeholder=='')?string('请输入' + lblText, placeholder) />
  <#local txtSize= (theme=='update')?string('', "input-sm") />
  <#local lblCss = (theme=='update')?string('col-md-2 control-label', "") />
  <#local lblCss = required?string(lblCss + " text-red", lblCss) />
  <#if showWrap><div class="form-group ${wrapClass}"></#if>
  <#if showLabel><label class="${lblCss}" for="${lblFor}"><#if (required)>*&nbsp;</#if>${lblText}<#if (theme=='search')>&nbsp;</#if></label></#if>
  <#if (theme=='update')><div class="${inputWrapClass}"></#if>
    <input type="${type}" class="form-control input-sm ${txtSize} ${extClass}" id="${lblFor}" name="${name}" value="${value}" ${extAttr} placeholder="${txtAlt}" />
  <#if (theme=='update')></div></#if>
  <#if showWrap></div></#if>
</#macro>

<#-- 
  多选输入框型分类选择器宏定义，参数说明：
    hideName    : (必传参数) 隐藏输入框的name属性
    showName    : (必传参数) 显示的输入框的name属性
    hideValue   : 隐藏输入框的value值，默认为空字符串""
    showValue   : 输入框的value属性，默认为空字符串""
    hideId    : 隐藏的输入框的id属性，默认为queryBppCataIds
    showId      : 显示的输入框的id属性,默认为queryBppCatas
    extAttr    : 输入框扩展属性，即参数没有支持属性，直接传字符串即可，例如：valid="{required: true,noblank:true}"参数校验使用
    onFocus     : 输入框点击事件,默认为bppCataMultiChoicePopLayer(this)
    cataType    : 分类的类型  默认：bpp  bpp:基础分类 ,epg:前端分类,bppSport:基础分类下的体育分类
    placeholder  : 输入框的placeholder属性，如果不传 则值为:请选择分类
    extClass  : 输入框的扩展样式, 例如日期选择功能可以使用extClass="date-selected"
    labelText  : 输入框label元素的值，默认值为“基础分类”
    showWrap  : 是否输出外层div元素，默认输出
    showLabel  : 是否输出label标签，默认输出
    wrapClass  : 外层div的扩展样式，默认空字符串，当是修改页面的第1行时需要添加margin-top-6样式补充间距
  使用示例：
  <@catalogMultiSelector hideName="cataid" showName="cataTitle" />
  <@catalogMultiSelector hideName="cataid" showName="cataTitle" labelText="基础分类" />
  <@catalogMultiSelector hideName="cataid" showName="cataTitle" cataType="epg" labelText="前端分类" />
 -->
<#macro catalogMultiSelector hideName showName hideValue="" showValue="" hideId="queryBppCataIds" showId="queryBppCatas" type="text" extAttr="" onFocus="" cataType="bpp" placeholder="请选择分类" extClass="" labelText="基础分类" showWrap=true showLabel=true wrapClass="">
  <#if showWrap><div class="form-group ${wrapClass}"></#if>
  <#if showLabel><label for="${hideId}">${labelText}&nbsp;</label></#if>
  <div class="input-group">
    <input type="hidden" id="${hideId}" name="${hideName}" value="${hideValue}" />
    <input type="${type}" class="form-control bg-white input-sm input-fix-width ${extClass}" id="${showId}" name="${showName}" value="${showValue}" ${extAttr} placeholder="${placeholder}" onfocus="${(onFocus!='')?string("${(onFocus)!}","cataMultiChoicePopLayer(this,${cataType},'${showId}','${hideId}')")}" readonly/>
    <div class="input-group-btn">
      <a class="btn btn-sm btn-default bg-gray-light" onclick="$(this).closest('.input-group').find('input').val('');"><i class="fa fa-remove"></i></a>
    </div>
  </div>
  <#if showWrap></div></#if>
</#macro>


<#-- 
  单选修改页分类选择器宏定义，参数说明：
    hideName    : (必传参数) 隐藏输入框的name属性
    hideValue   : 隐藏输入框的value值，默认为空字符串""
    showValue   : 输入框的value属性，类型为list,默认为空list类型
    hideId    : 隐藏的输入框的id属性，默认为queryBppCataIds
    showId      : 显示的输入框的id属性,默认为queryBppCatas
    extAttr    : 输入框扩展属性，即参数没有支持属性，直接传字符串即可，例如：valid="{required: true,noblank:true}"参数校验使用
    onClick     : 输入框点击事件,默认为bppCataChoicePopLayer(this)
    cataType    : 分类的类型  默认：bpp  bpp:基础分类 ,epg:前端分类,bppSport:基础分类下的体育分类
    labelText  : 输入框label元素的值，默认值为“基础分类”
    showWrap  : 是否输出外层div元素，默认输出
    showLabel  : 是否输出label标签，默认输出
    wrapClass  : 外层div的扩展样式，默认空字符串，当是修改页面的第1行时需要添加margin-top-6样式补充间距
  使用示例：
  <@catalogSelector hideName="cataid" showName="cataTitle" />
  <@catalogSelector hideName="cataid" showName="cataTitle" labelText="基础分类" />
  <@catalogSelector hideName="cataid" showName="cataTitle" cataType="epg" labelText="前端分类" />
 -->
<#macro catalogSelector hideName hideValue="" btnSize="btn-sm" showValue=[] height="600" showInner=true hideId="bppCataId" showId="bppCata" extAttr="" onClick="" cataType="bpp" labelText="基础分类" showWrap=true showLabel=true wrapClass="margin-top-6">
  <#if showWrap><div class="form-group ${wrapClass}"></#if>
    <#if showLabel><label class="col-md-2 control-label text-red">*&nbsp;${labelText}</label></#if>
  <#if showInner><div class="col-md-6"></#if>
    <input type="hidden" id="${hideId}" name="${hideName}" value="${hideValue}" />
      <label id="${showId}"> 
        <#if (showValue?? && (showValue?size)>0) >
          <#list showValue as cataTitle>${(cataTitle_index==0)?string(((cataTitle)!'')?trim,"&nbsp;>&nbsp;"+(cataTitle)!)?trim}</#list>&nbsp;&nbsp;
        </#if>
      </label><button type="button" class="btn btn-warning ${btnSize}" onclick="${(onClick!='')?string("${(onClick)!}","cataChoicePopLayer(this,${cataType},'${showId}','${hideId}')")}">选择...</button>
  <#if showInner></div></#if>
  <#if showWrap></div></#if>
</#macro>

<#-- 
  多选修改页分类选择器宏定义，参数说明：
    hideName    : (必传参数) 隐藏输入框的name属性
    hideValue   : 隐藏输入框的value值，默认为空字符串""
    showValueMap   : 输入框的value属性，类型为list,默认为空list类型
    hideId    : 隐藏的输入框的id属性，默认为queryBppCataIds
    showId      : 显示的输入框的id属性,默认为queryBppCatas
    extAttr    : 输入框扩展属性，即参数没有支持属性，直接传字符串即可，例如：valid="{required: true,noblank:true}"参数校验使用
    onClick     : 输入框点击事件,默认为bppCataChoicePopLayer(this)
    cataType    : 分类的类型  默认：bpp  bpp:基础分类 ,epg:前端分类,bppSport:基础分类下的体育分类
    labelText  : 输入框label元素的值，默认值为“基础分类”
    showWrap  : 是否输出外层div元素，默认输出
    showLabel  : 是否输出label标签，默认输出
    wrapClass  : 外层div的扩展样式，默认空字符串，当是修改页面的第1行时需要添加margin-top-6样式补充间距
  使用示例：
  <@labelCatalogSelector hideName="cataid" showName="cataTitle" />
  <@labelCatalogSelector hideName="cataid" showName="cataTitle" labelText="基础分类" />
  <@labelCatalogSelector hideName="cataid" showName="cataTitle" cataType="epg" labelText="前端分类" />
 -->
<#macro labelCatalogSelector hideName hideValue="" extClass="btn-sm" showValueMap={} hideId="bppCataId" showId="bppCata" extAttr="" onClick="" cataType="bpp" labelText="基础分类" showWrap=true showLabel=true wrapClass="">
  <#if showWrap><div class="form-group margin-top-6"></#if>
    <#if showLabel><label class="col-md-2 control-label text-red">*&nbsp;${labelText}</label></#if>
  <div class="col-md-6">
    <input type="hidden" id="${hideId}" name="${hideName}" value="${hideValue}" />
    	<span>
        <#if (showValueMap?? && (showValueMap?size)>0) >
          <#list showValueMap?keys as showKey>
            <#if showKey !='' && showKey !='0'>
              <#if ((((showValueMap[showKey])![])?size)>0)>
                <#list showValueMap[showKey] as cataTitle>
          	      <#if cataTitle_index==0>
                    <div class="text-nowrap">
	                <label hidenvalue="${hideValue}">
	              </#if>
		          ${(cataTitle_index==0)?string((cataTitle)!,"&nbsp;>&nbsp;"+(cataTitle)!)}<#if !cataTitle_has_next><a class="btn btn-xs text-red" onclick="$(this).closest('div').remove();$('#${hideId}').val(resetLabelEpgCata(this));"><i class="fa fa-remove" style="font-size: 15px;"></i></a></#if>
		          <#if !cataTitle_has_next>
	          	    </label>
          	        </div>
          	      </#if>
                </#list>
          	  </#if>
          	</#if>
          </#list>
        </#if>
       </span> 
      <button type="button" class="btn btn-warning ${extClass}"  onclick="${(onClick!='')?string("${(onClick)!}","epgCataMultiLabelChoicePopLayer(this,${cataType},'${showId}','${hideId}')")}">选择...</button>
  </div>
  <#if showWrap></div></#if>
</#macro>

<#-- 
  单选组宏定义，参数说明：
    dataMap    : (必传参数) 单选组的数据，map格式例如:{'1':'上线','2':'下线','4':'删除'}
    name    : (必传参数) 单选组的name属性
    value    : 单选组单前选中的选项对象的value值，默认为空字符串""
    labelText  : 单选组label元素的值，如果不传取值顺序：labelText > name
    cols       : 控制单选组右栏占的宽度，默认为5列
    showLabel  : 是否输出label标签，默认输出
    showWrap    : 是否输出外层div元素，默认输出
    wrapClass  : 外层div的扩展样式，默认空字符串，当是修改页面的第1行时需要添加margin-top-6样式补充间距
  使用示例：
  <#assign dataMap={'1':'上线','2':'下线','4':'删除'}>
  <@radioGroup dataMap=dataMap name="bppChannel.status" value="2" labelText="状态" />
 -->
<#macro radioGroup dataMap name value="" labelText="" cols="5" onClick=""  disabled=false showLabel=true lblCss="col-md-2 control-label" showWrap=true wrapClass=""  required=false>
  <#local lblText= (labelText=='')?string(name, labelText) />
  <#local lblCss = required?string(lblCss + " text-red", lblCss) />
  <#if showWrap><div class="form-group ${wrapClass}"></#if>
    <#if showLabel><label class="${lblCss}">${lblText}</label></#if>
    <div class="col-md-${cols} label-group-custom-margin">
      <#list dataMap?keys as item>
      <label class="radio-inline">
        <input type="radio" name="${name}" value="${item}" ${(item == value)?string('checked','')} ${(disabled)?string('disabled','')} onclick="${onClick}" />${dataMap[item]}
      </label>
      </#list>
    </div>
  <#if showWrap></div></#if>
</#macro>

<#-- 
  平台终端checkbox宏定义，参数说明：
    platformList    : (必传参数)list
    labelText  : 单选组label元素的值，如果不传取值:终端
    value	: 如ikan,client 逗号分隔
            全选多终端checkbox 请引入lib/platform.js 文件
  使用示例：
  <@platformCheckbox platformList=platformList value="ikan,client" labelText="可见终端" />
 -->
<#macro platformCheckbox platformList value="" labelText="终端">
  <div class="form-group label-min-width">
	  <label class="col-xs-2 margin-top-6 text-right">${labelText}</label>
	  <div class="col-xs-10 label-group-custom-margin">
	    <label class="checkbox-inline text-red"><input type="checkbox" name="allCheck" onclick="checkedAll()">全部</label>
        <label class="checkbox-inline text-red"><input type="checkbox" name="smartCheck" onclick="checkedSmart()">多终端</label><br>
	    <#list platformList as item>
	      <#if item!='newwap'>
		    <label class="checkbox-inline pad-tb-6" >
		    	<input type="checkbox" name="visible" ${(value?split(",")?seq_contains(item))?string('checked','')} lang="${platformSmartList?seq_contains(item)?string('smart','')}" onclick="checkedAllAndSmartCheckBox()">${item!}
		    </label>
		  </#if>
	    </#list>
	  </div>
  </div>
</#macro>

<#-- 
  多选组宏定义，参数说明：
    dataMap    : (必传参数) 单选组的数据，map格式例如:{'1':'上线','2':'下线','4':'删除'}
    name    : (必传参数) 单选组的name属性
    extAttr : 扩展属性
    value    : 单选组单前选中的选项对象的value值，默认为空字符串""，多个值之间以逗号分隔，例如："2,4"
    labelText  : 单选组label元素的值，如果不传取值顺序：labelText > name
    cols       : 控制单选组右栏占的宽度，默认为5列
    showLabel  : 是否输出label标签，默认输出
    wrapClass  : 外层div的扩展样式，默认空字符串，当是修改页面的第1行时需要添加margin-top-6样式补充间距
  使用示例：
  <#assign dataMap={'1':'上线','2':'下线','4':'删除'}>
  <@checkboxGroup dataMap=dataMap name="bppChannel.status" value="2,3" labelText="状态"/>
 -->
<#macro checkboxGroup dataMap name  extAttr="" onClick=""  value="" labelText="" cols="5" showLabel=true wrapClass="">
  <#local lblText= (labelText=='')?string(name, labelText) />
  <#local checkStatus=false />
  <div class="form-group ${wrapClass} no-margin-bottom">
    <#if showLabel><label class="col-sm-2 control-label">${lblText}</label></#if>
    <div class="col-sm-${cols}">
      <#list dataMap?keys as item>
      <label class="checkbox-inline">
        <input type="checkbox" name="${name}" value="${item}" ${(value?split(",")?seq_contains(item))?string('checked','')}  ${extAttr} onclick="${onClick}">${dataMap[item]}
      </label>
      </#list>
    </div>
  </div>
</#macro>


<#-- 
  多选组宏定义，参数说明：
    dataMap    : (必传参数) 单选组的数据，map格式例如:{'1':'上线','2':'下线','4':'删除'}
    name    : (必传参数) 单选组的name属性
    extAttr : 扩展属性
    value    : 单选组单前选中的选项对象的value值，默认为空字符串""，多个值之间以逗号分隔，例如："2,4"
    labelText  : 单选组label元素的值，如果不传取值顺序：labelText > name
    cols       : 控制单选组右栏占的宽度，默认为5列
    showLabel  : 是否输出label标签，默认输出
    wrapClass  : 外层div的扩展样式，默认空字符串，当是修改页面的第1行时需要添加margin-top-6样式补充间距
  使用示例：
  <#assign dataMap={'1':'上线','2':'下线','4':'删除'}>
  <@checkboxGroup dataMap=dataMap name="bppChannel.status" value="2,3" labelText="状态"/>
 -->
<#macro checkboxAllClickGroup dataMap name  extAttr="" onClick="" allClick=""  value="" labelText="" cols="5" showLabel=true wrapClass="">
  <#local lblText= (labelText=='')?string(name, labelText) />
  <#local checkStatus=false />
  <div class="form-group ${wrapClass} no-margin-bottom">
    <#if showLabel><label class="col-sm-2 control-label">${lblText}</label></#if>
    <div class="col-sm-${cols}">
      <label class="checkbox-inline">
        <input type="checkbox" name="${name}_all" value="全选"  onclick="${allClick}">全选
      </label>
      <#list dataMap?keys as item>
      <label class="checkbox-inline">
        <input type="checkbox" name="${name}" value="${item}" ${(value?split(",")?seq_contains(item))?string('checked','')}  ${extAttr} onclick="${onClick}">${dataMap[item]}
      </label>
      </#list>
    </div>
  </div>
</#macro>

<#-- 
  下拉框宏定义，参数说明：
    dataMap    : (必传参数) 下拉框的循环option的Map数据，建议将常用的Map数据放在constant.ftl中
            格式： {'0':'普通标签','1':'常用标签'}
              说明: key为下拉框option的value值，value为下拉框option的显示名称
    name    : (必传参数) 下拉框的name属性
    id      : 下拉框的id属性，取值顺序：inputId > inputName
    value    : 下拉框当前选中值，主要用于做默认选中使用
    unlimitedValue : 下拉框显示不限时，不限这条记录的value的值，默认为-1,当需要使用字符串型的value时，可以通过此参数设置不限这条记录的value值
    onChange  : 下拉框的onChange事件函数，默认值“”表示不绑定事件
    labelText  : 下拉框的label元素的值，取值顺序：labelText > inputId > inputName
    showWrap  : 是否输出外层div元素，默认输出
    showLabel  : 是否输出label标签，默认输出
    showAllOption : 是否输出全部的option项，默认输出
    extAttr    : 下拉框的扩展属性，即参数没有支持属性，直接传字符串即可，例如：extAttr="lang='test'"
    wrapClass  : 外层div的扩展样式，默认空字符串，当是修改页面的第1行时需要添加margin-top-6样式补充间距
    selectWrapClass : 指定select外部div样式，默认为col-md-3
    selectClass : select的额外扩展类，默认为空字符串
    theme    : 外观样子，默认是适合于筛选条件区域使用的，theme取值：search(默认值，筛选区域使用)、update(修改页面使用，2-3分栏)
  使用示例：
  <@select labelText="标签级别" name="queryType" dataMap=tagType value=(((queryList.queryType)!-1)?string) onChange="formSubmit()"/>
 -->
<#macro select dataMap name id="" value="" unlimitedValue="-1" onChange="" labelText="" extAttr="" theme="search" showWrap=true showLabel=true showAllOption=true wrapClass="" selectWrapClass="col-md-3" selectClass="" >
  <#local lblFor = (id=='')?string(name, id) />
  <#local lblText= (labelText=='')?string(lblFor, labelText) />
  <#local lblCss  = (theme=='update')?string('class="col-md-2 control-label"', "") />
  <#if showWrap><div class="form-group ${wrapClass}"></#if>
  <#if showLabel><label ${lblCss} for="${lblFor}">${lblText}&nbsp;</label></#if>  
  <#if (theme=='update')><div class="${selectWrapClass}"></#if>         
    <select class="form-control input-sm ${selectClass}" id="${lblFor}" name="${name}" ${extAttr} onChange="${onChange}">
      <#if showAllOption><option value="${unlimitedValue}">--不限--</option></#if>
      <#list dataMap?keys as item>
        <option value="${item}" ${(item == value)?string('selected','')}>${dataMap[item]}</option>
      </#list>
    </select>
  <#if (theme=='update')></div></#if>
  <#if showWrap></div></#if>
</#macro>

<#-- 
  多选下拉框宏定义，参数说明：
    dataMap    : (必传参数) 下拉框的循环option的Map数据，建议将常用的Map数据放在constant.ftl中
            格式： {'0':'普通标签','1':'常用标签'}
              说明: key为下拉框option的value值，value为下拉框option的显示名称
    name    : (必传参数) 下拉框的name属性
    id      : 下拉框的id属性，取值顺序：inputId > inputName
    value    : 下拉框当前选中值的集合,为list格式,里面存储的值必须为java的Integer型,主要用于做默认选中使用
    labelText  : 下拉框的label元素的值，取值顺序：labelText > inputId > inputName
    showWrap  : 是否输出外层div元素，默认输出
    showLabel  : 是否输出label标签，默认输出
    extAttr    : 下拉框的扩展属性，即参数没有支持属性，直接传字符串即可，例如：extAttr="lang='test'"
    wrapClass  : 外层div的扩展样式，默认空字符串，当是修改页面的第1行时需要添加margin-top-6样式补充间距
    theme    : 外观样子，默认是适合于筛选条件区域使用的，theme取值：search(默认值，筛选区域使用)、update(修改页面使用，2-3分栏)
  使用示例：
  <@multiSelect labelText="标签级别" name="queryType" dataMap=tagType value=[1,2] />
 -->
<#macro multiSelect dataMap name id="" value=[] labelText="" extAttr="" theme="search" showWrap=true showLabel=true wrapClass=""  selectWrapClass="col-md-3">
  <#local lblFor = (id=='')?string(name, id) />
  <#local lblText= (labelText=='')?string(lblFor, labelText) />
  <#local lblCss  = (theme=='update')?string('class="col-md-2 control-label"', "") />
  <#if showWrap><div class="form-group ${wrapClass}"></#if>
  <#if showLabel><label ${lblCss} for="${lblFor}">${lblText}&nbsp;</label></#if>
  <#if (theme=='update')><div class="${selectWrapClass}"></#if>
    <select class="form-control input-sm" id="${lblFor}" name="${name}" multiple="multiple" ${extAttr}>
      <#list dataMap?keys as item>
        <option value="${item}" ${(value?seq_contains(item?eval) || value?seq_contains(item))?string('selected','')}>${dataMap[item]}</option>
      </#list>
    </select>
  <#if (theme=='update')></div></#if>
  <#if showWrap></div></#if>
</#macro>

<#-- 
  日期选择宏定义，参数说明：
    beginName  : (必传参数)开始日期输入框name属性
    endName    : (必传参数)结束日期输入框name属性
    beginValue  : 开始日期输入框value属性 
    endValue  : 结束日期输入框value属性
    labelText  : 日期选择的label元素的值
    showWrap  : 是否输出外层div元素，默认输出
    showLabel  : 是否输出label标签，默认输出
    wrapClass  : 外层div的扩展样式，默认空字符串，当是修改页面的第1行时需要添加margin-top-6样式补充间距
    dateFormat  : 日期格式
    size        : 日期输入框大小
  使用示例：
  <@dateRange labelText="更新日期" beginName="queryBeginDate" endName="queryEndDate"/>
  <@dateRange labelText="更新日期" beginName="queryBeginDate" endName="queryEndDate"
                   beginValue="${(queryList.queryStartDate)!}" endValue="${(queryList.queryEndDate)!}"/>
 -->
<#macro dateRange beginName endName beginValue="" endValue="" labelText="" showWrap=true showLabel=true wrapClass="" dateFormat="yyyy-MM-dd" size="10">
  <#if showWrap><div class="form-group ${wrapClass}"></#if>
    <#if showLabel><label>${labelText}&nbsp;</label></#if>
    <div class="input-daterange input-group" id="datepicker">
      <input type="text" id="queryStartDate" name="${beginName}" class="input-sm bg-white form-control" onClick="WdatePicker({dateFmt:'${dateFormat}',maxDate:'#F{$dp.$D(\'queryEndDate\')||\'\'}'})" value="${beginValue}" size="${size}" placeholder="开始时间" readonly />
      <span class="input-group-addon">-</span>
      <input type="text" id="queryEndDate" name="${endName}" class="input-sm form-control bg-white valid" onClick="WdatePicker({dateFmt:'${dateFormat}',minDate:'#F{$dp.$D(\'queryStartDate\')||\'\'}'})" value="${endValue}" size="${size}" placeholder="结束时间" readonly />
    </div>
  <#if showWrap></div></#if>
</#macro>

<#-- 
  按钮组宏定义，参数说明：
    dataMap    : (必传参数) 下拉框的循环option的Map数据，建议将常用的Map数据放在constant.ftl中
            格式： {'0':'普通标签','1':'常用标签'}
    name    : (必传参数)按钮组button元素的name属性
    value    : 按钮组button元素、及checkbox的选中效果
    labelText  : 按钮组的label元素的值
    showWrap  : 是否输出外层div元素，默认输出
    showLabel  : 是否输出label标签，默认输出
    wrapClass  : 外层div的扩展样式，默认空字符串，当是修改页面的第1行时需要添加margin-top-6样式补充间距
  使用示例：
  <@buttonGroup dataMap=channelVt labelText="频道类型" name="queryVt" value=((queryList.queryVt)![])/>
 -->
<#macro buttonGroup dataMap name value labelText="" showWrap=true showLabel=true wrapClass="">
  <#if showWrap><div class="form-group ${wrapClass}"></#if>
    <#if showLabel><label>${labelText}&nbsp;</label></#if>
    <div class="btn-group bootstrap-multiselect-btn-group">
      <#list dataMap?keys as item>
        <#local isChecked=((value![])?seq_contains(item?eval)) />
        <button type="button" class="btn btn-default${isChecked?string(' btn-checked','')}">${dataMap[item]}
          <input type="checkbox" name="${name}" value="${item}" ${(isChecked)?string('checked','')}>
        </button>
      </#list>
    </div>
  <#if showWrap></div></#if>
</#macro>

<#-- 
  文本域宏定义，参数说明：
    name    : (必传参数) 输入框的name属性
    id      : 输入框的id属性，取值顺序：id > name
    rows    : 文本域的行数，默认值1
    value    : 输入框的value属性，默认为空字符串""
    placeholder  : 输入框的placeholder属性，如果不传 则值判断labelText的值，如果labelText值不为空值为:请输入${labelText},否则为空字符串
    extClass  : 输入框的扩展样式, 例如日期选择功能可以使用extClass="date-selected"
    labelText  : 输入框label元素的值，如果不传取值顺序：labelText > id > name
    showWrap  : 是否输出外层div元素，默认输出
    showLabel  : 是否输出label标签，默认输出
    wrapClass  : 外层div的扩展样式，默认空字符串，当是修改页面的第1行时需要添加margin-top-6样式补充间距
    theme    : 外观样子，默认是适合于筛选条件区域使用的，theme取值：search(默认值，筛选区域使用)、update(修改页面使用，2-6分栏)
  使用示例：
  <@textarea name="userName"/>
  <@textarea labelText="配置项ID" name="queryId" value=((queryList.queryId)!)/>
  <@textarea labelText="配置项ID" rows="3" name="queryId" value=((queryList.queryId)!) theme="update" wrapClass="margin-top-6"/> # 修改页第1行
  <@textarea labelText="配置项ID" rows="3" name="queryId" value=((queryList.queryId)!) theme="update"/>
 -->
<#macro textarea name id="" rows="1" value="" placeholder="" extClass="" labelText="" extAttr="" theme="search" showWrap=true textareaWrapClass="col-md-6" showLabel=true wrapClass="">
  <#local lblFor = (id=='')?string(name, id) />
  <#local lblText= (labelText=='')?string(lblFor, labelText) />
  <#local txtAlt = (placeholder=='')?string('请输入' + lblText, placeholder) />
  <#local txtSize = (theme=='update')?string('', "input-sm") />
  <#local lblCss  = (theme=='update')?string('class="col-md-2 control-label"', "") />
  <#if showWrap><div class="form-group ${wrapClass}"></#if>
  <#if showLabel><label ${lblCss} for="${lblFor}">${lblText}<#if (theme=='search')>&nbsp;</#if></label></#if>
  <#if (theme=='update')><div class="${textareaWrapClass}"></#if>
  <textarea class="form-control ${txtSize} ${extClass}" id="${lblFor}" name="${name}" rows="${rows}" placeholder="${txtAlt}" ${extAttr}>${value}</textarea>
  <#if (theme=='update')></div></#if>
  <#if showWrap></div></#if>
</#macro>


<#-- 
  文本域宏定义，参数说明：
    keys    : (必传参数) key值逗号分隔字符串
    dataMap      : (必传参数) key对应的map
  使用示例：根据1,2,3 得到对应的value值 一,二,三,
  <@keysToValues keys=(copyright.authorizedterminal)!'' dataMap=authTerminalMap />
 -->
<#macro keysToValues keys dataMap>
	<#assign values=''>
	<#if keys!=''>
	  <#list keys?split(',') as item>
	    <#if dataMap[(item!'')?string]?? >
    	<#assign values=values+dataMap[item?string] + ',' >  
    	</#if>  
      </#list>
    </#if>
    ${values}
</#macro>

<#-- 
  修改页提交返回按钮宏定义，参数说明：
    type    : 提交按钮的类型，默认submit
    onClick    : 提交按钮的onClick事件，用于异步提交
    theme    : 支持:normal、float，默认值是normal，如果是float表示是相对定位
    size    : 提交按钮大小，支持:normal、small
    clickBack    : 返回按钮的onClick事件，默认history.back()
  使用示例：
  <@submit />    # 同步提交
  <@submit type="button" onClick="test()"/>  # 异步提交
  <@submit theme="float" size="small"/>    # 频道列表页相对定位的提交按钮宏
 -->
<#macro submit type="submit" onClick="" theme="normal" size="normal" clickBack="history.back()">
  <#local clickEvent = (onClick=='')?string('', 'onclick="${onClick}"') />
  <#local backEvent = (clickBack=='')?string('', 'onclick="${clickBack}"') />
  <#local wrapClass = (theme=='normal')?string('col-sm-12 text-center', 'btn-group btn-group-custom-fixed-float') />
  <#local btnSize = (size=='normal')?string('', 'btn-sm') />
  <#if (theme=='normal')><div class="form-group"></#if>
    <div class="${wrapClass}" lang="submitButtonGroup">
      <button type="${type}" class="btn btn-success ${btnSize}" ${clickEvent}">&nbsp;&nbsp;提&nbsp;交&nbsp;&nbsp;</button>
      <button type="button" class="btn btn-primary ${btnSize}" ${backEvent}>&nbsp;&nbsp;返&nbsp;回&nbsp;&nbsp;</button>
   </div>
  <#if (theme=='normal')></div></#if>
</#macro>

<#-- 
  列表页搜索清空按钮宏定义，无参数；使用示例：<@search />
 -->
<#macro search hasBack=false onlySubmit=false>
  <div class="form-group">
    <button class="btn btn-primary btn-sm pad-lr-16" type="submit">搜索</button>
    <#if !onlySubmit >
	    <button type="button" onclick="clearForm(event)" class="btn btn-warning btn-sm pad-lr-16">清空</button>
	    <#if hasBack >
	    	<button type="button" class="btn btn-primary btn-sm pad-lr-16" onclick="javascript:history.back()">返回</button>
	    </#if>
    </#if>
  </div>
</#macro>

<#-- 
  列表页搜索头宏定义，无参数；使用示例：<@searchTitle />
 -->
<#macro searchTitle>
  <div class="box-header with-border">
    <h3 class="box-title">筛选条件</h3>
    <div class="box-tools pull-right">
      <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
      </button>
    </div>
  </div>
</#macro>

<#-- 
  列表页搜索隐藏的分页及排序的表单元素宏定义，参数说明；
    pageSize   : 列表页搜索时每页的显示页数，默认值为(pageList.pageSize)!20
    pageNum    : 列表页搜索时隐藏的页码表单元素，默认值为1
    orderBy    : 列表页搜索时排序的隐藏表单，默认值为(queryList.orderBy)!
        使用示例：<@pageHidden />
 -->
<#macro pageHidden pageSize=(pageList.pageSize)!20 pageNum=1 orderBy=(queryList.orderBy)! >
  <input type="hidden" id="pageSize" name="pageSize" value="${pageSize}" />
  <input type="hidden" id="pageNum" name="pageNum" value="${pageNum}" />
  <input type="hidden" id="orderBy" name="orderBy" value="${orderBy}" />
</#macro>

<#--
  页内搜索宏定义，无参数；使用示例：<@pageSearch />
 -->
<#macro pageSearch>
<div class="btn-group pull-right">
  <div class="input-group" style="width: 150px;">
    <input type="text" class="form-control input-sm" placeholder="页内查找" onkeyup="filterPage(event)">
    <div class="input-group-btn">
      <button class="btn btn-sm btn-default" onclick="filterPage(event)"><i class="fa fa-search"></i></button>
    </div>
  </div>
</div>
</#macro>

<#-- 
  表格表头排序宏定义，参数说明：
      data    : (必传参数) 表头系列显示的Map数据，建议将常用的Map数据放在constant.ftl中
              格式：{'标签组ID':'taggroup.id', '标签名称':'taggroup.name', '引用次数':''}
              说明: key为显示的列名称，value为排序的字段名称，若value为空则表示此列不支持排序
      sort    : (必传参数) 当前排序的列，如：taggroup.groupname或taggroup.groupname desc; desc表示降序
      showCheck  : 是否输出勾选框，默认值为true
      formId    : 默认为空，当页面有多个form时需要指定排序的form的Id属性，单个form可以不传
      position  : 表头位置，支持head、foot分别对应thead、tfoot标签，默认值为head
  使用示例：
  <#assign dataMap={'ID':'id','用户':'username','操作':'operate','内容':'content','时间':'createtime','IP':'ip'}>
    <@sortTable dataMap=dataMap sort=(queryList.orderBy)!'' showCheck=false/>
  <@sortTable dataMap=dataMap sort=(queryList.orderBy)!'' showCheck=false position="foot"/>
-->
<#macro sortTable dataMap sort showCheck=true position="head" formId="">
<#local sortType =((sort?index_of('desc') >=0)?string('sorting_desc','sorting_asc')) >
  <t${position} class="text-nowrap">
    <tr>
      <#if showCheck><th class="no-padding text-center" width="26"><input type="checkbox" title="全选/取消"></th></#if>
      <#list dataMap?keys as item >
        <#local sortname = (dataMap[item])!'' >
        <#if sortname == '' >
          <th>${item}</th>
        <#else>
          <th class="sorting ${(sort?index_of(sortname)>=0)?string(sortType,'')}" onclick="queryBySort(this,'${sortname}')">${item}</th>
        </#if>
      </#list>
    </tr>
  </t${position}>
</#macro>

<#-- 
  空白行自动补全宏定义，参数说明：
    col    : (必传参数)每行的列数
    minRow : 希望显示的最小行数
    data   : pageBean数据对象，用于获取当前pageSize及数据size，默认值pageList
  使用示例：
  <@fixBlankTr col=8/>
-->
<#macro fixBlankTr col data=(pageList) minRow=pageList.pageSize>
  <#if ((pageList.size < pageList.pageSize) && (minRow>=1) && (pageList.size < minRow))>
    <#list 1 .. (minRow - pageList.size) as r>
      <tr>
      <#list 1 .. col?int as c>
        <td>&nbsp;</td>
      </#list>
      </tr>
    </#list>
  </#if>
</#macro>

<#--
  分页宏定义（当pageInfo的total为-1时，表示以只显示当前页码，否则显示相邻的10个页码)，参数说明：
    attr    : pageInfo对象，主要是获取pageSize、pageNum、total用于显示分页页码，默认值：${pageList}
    action    : 分页提交的actionUrl，默认值：${request.getRequestUri()}
    queryStr  : 保存筛选条件的字符串，默认值：${(queryList.queryString)!}
    orderBy   : 页面排序，默认值: ${(queryList.orderBy)!}
    lockSize  : 是否固定每页的条数，默认值：-1表示不固定每页条数(可以通过下拉框切换每页条数)，当弹出的iframe列表页可以使用lockSize属性
    count    : 显示页码数量，默认10，取值范围5~15，超出范围则取默认值10
    ajaxTotal  : 异步获取总记录数事件，默认值：ajaxPageTotal()
  使用示例：
  <@pager/>
  <@pager lockSize=15/>
  <@pager attr=${pageInfo} lockSize=15/>
 -->
<#macro pager attr=(pageList) action=(request.getRequestUri()) orderBy=((queryList.orderBy)!'') queryStr=((queryList.queryString)!'') lockSize=-1 count=8 showMaxSize=false>
  <!-- start paginator -->
  <input type="hidden" id="queryStr" value="${(queryStr)?replace('\r','%0d')?replace('\n','%0a')?html}" />
  <input type="hidden" id="curPageNum" value="${(attr.pageNum)!1}" />
  <#local orderByStr=((((queryList.orderBy)!'') =='')?string('','&orderBy='+((queryList.orderBy)!'')))>
  <#if (attr.total > -1)>
    <div class="col-xs-4 no-padding">
      <div class="form-inline input-page text-left margin-top-4">
                           总计${attr.total}条&nbsp;/&nbsp;共${attr.pages}页&nbsp;&nbsp;每页显示<#if (lockSize > -1)><b style="line-height: 23px;">${lockSize}</b>&nbsp;条
    <#else>
      <select class="form-control input-sm inline" style="width: auto;vertical-align: baseline;" onChange="changePageSize(this)">
        <option value="10" ${(((attr.pageSize)!20)==10)?string('selected','')}>10</option>
        <option value="15" ${(((attr.pageSize)!20)==15)?string('selected','')}>15</option>
        <option value="20" ${(((attr.pageSize)!20)==20)?string('selected','')}>20</option>
        <option value="25" ${(((attr.pageSize)!20)==25)?string('selected','')}>25</option>
        <option value="30" ${(((attr.pageSize)!20)==30)?string('selected','')}>30</option>
        <option value="100" ${(((attr.pageSize)!20)==100)?string('selected','')}>100</option>
        <#if (showMaxSize)>
          <option value="500" ${(((attr.pageSize)!20)==500)?string('selected','')}>500</option>
        </#if>
        <#if (!showMaxSize) && (user.roleName == '超级管理员')>
          <option value="${ftlUtil.getSuperAdminMaxPageSize()}" ${(((attr.pageSize)!20)==(ftlUtil.getSuperAdminMaxPageSize()))?string('selected','')}>${ftlUtil.getSuperAdminMaxPageSize()}</option>
        </#if>
      </select>&nbsp;条
        </#if>
      </div>
    </div>
    <div class="col-xs-8 pull-right no-padding">
      <div class="dataTables_paginate">
        <ul class="pagination pagination-sm">
          <#if ((attr.pageNum)==1 || attr.total ==0)>
          <li class="previous disabled"><a href="javascript:void(0)">首页</a></li>
          <li class="previous disabled"><a href="javascript:void(0)">上一页</a></li>
          <#else>
            <li class="previous"><a href="${action}?pageSize=${attr.pageSize}&pageNum=1${(orderByStr+queryStr)?replace('\r','%0d')?replace('\n','%0a')?html}">首页</a></li>
            <li class="previous"><a href="${action}?pageSize=${attr.pageSize}&pageNum=${(attr.pages==0 || attr.pageNum==1)?string("1",(attr.pageNum-1)?string)}${(orderByStr+queryStr)?replace('\r','%0d')?replace('\n','%0a')?html}">上一页</a></li>
          </#if>
          <#local bc=(count < 5 || count > 15)?string("10", count?string)?eval />
          <#local begin=(attr.pages<count+1 || attr.pageNum<((count/2)?int + 2))?string("1",((attr.pages-attr.pageNum)<(count-(count/2)?int -1))?string((attr.pages-count+1)?string,(attr.pageNum-(count/2)?int)?string))?eval>
          <#local end=((attr.pages==0)?string("1",(attr.pages<(count+1))?string(attr.pages?string,(begin+count-1)?string)))?eval >
          <#list begin .. end  as num>
            <#if (num==attr.pageNum || attr.pageNum ==0)>
              <li class="active"><a href="${action}?pageSize=${attr.pageSize}&pageNum=${num}${(orderByStr+queryStr)?replace('\r','%0d')?replace('\n','%0a')?html}">${num}</a></li>
            <#else>
              <li><a href="${action}?pageSize=${attr.pageSize}&pageNum=${num}${(orderByStr+queryStr)?replace('\r','%0d')?replace('\n','%0a')?html}">${num}</a></li>
            </#if>
          </#list>
          <#if ((pageList.pages)<=(pageList.pageNum))>
          <li class="next disabled"><a href="javascript:void(0)">下一页</a></li>
          <li class="next disabled"><a href="javascript:void(0)">尾页</a></li>        
          <#else>
          <li class="next"><a href="${action}?pageSize=${attr.pageSize}&pageNum=${(attr.pages==0)?string("1",((attr.pages>attr.pageNum)?string((attr.pageNum+1)?string,attr.pages?string)))}${(orderByStr+queryStr)?replace('\r','%0d')?replace('\n','%0a')?html}">下一页</a></li>
          <li class="next"><a href="${action}?pageSize=${attr.pageSize}&pageNum=${(attr.pages==0)?string("1",attr.pages?string)}${(orderByStr+queryStr)?replace('\r','%0d')?replace('\n','%0a')?html}">尾页</a></li>        
          </#if>
        </ul>
        <div class="input-group pull-right" name="skipPageDiv" style="width: 78px;margin-top: 2px;margin-left: 5px;">
          <input type="text" class="form-control input-sm" placeholder="页数" value="${(end<(attr.pages))?string(((end+1)?string),((attr.pages)?string))}">
          <div class="input-group-btn">
            <button type="button" class="btn btn-sm btn-default text-green" onclick="skipToSomePage(this,${attr.pageSize})"><i class="fa fa-arrow-right"></i></button>
          </div>
        </div>
      </div>
    </div>
  <#else>
    <div class="col-sm-4 no-padding">
      <div class="dataTables_info form-inline input-page">
        <span name="showTotal_block" class="pull-left" style="padding:3px 0;"><a href="javascript:void(0);" onclick="ajaxPageTotal('${action}','${(queryStr)?replace('\r','%0d')?replace('\n','%0a')}',${(lockSize>-1)?string((lockSize?string),(((attr.pageSize)!20)?string))})">显示总页数</a></span>&nbsp;&nbsp;每页显示 <#if (lockSize > -1)><b style="line-height: 23px;">${lockSize}</b>&nbsp;条
        <#else>
        <select class="form-control input-sm" id="page_size" onChange="changePageSize(this)">
          <option value="10" ${(((attr.pageSize)!20)==10)?string('selected','')}>10</option>
          <option value="15" ${(((attr.pageSize)!20)==15)?string('selected','')}>15</option>
          <option value="20" ${(((attr.pageSize)!20)==20)?string('selected','')}>20</option>
          <option value="25" ${(((attr.pageSize)!20)==25)?string('selected','')}>25</option>
          <option value="30" ${(((attr.pageSize)!20)==30)?string('selected','')}>30</option>
          <option value="100" ${(((attr.pageSize)!20)==100)?string('selected','')}>100</option>
          <#if (showMaxSize)>
            <option value="500" ${(((attr.pageSize)!20)==500)?string('selected','')}>500</option>
          </#if>
          <#if (!showMaxSize) && (user.roleName == '超级管理员')>
            <option value="${ftlUtil.getSuperAdminMaxPageSize()}" ${(((attr.pageSize)!20)==(ftlUtil.getSuperAdminMaxPageSize()))?string('selected','')}>${ftlUtil.getSuperAdminMaxPageSize()}</option>
          </#if>
        </select>&nbsp;条
        </#if>
      </div>
    </div>
    <div class="col-sm-8 pull-right no-padding">
      <div class="dataTables_paginate">
        <ul class="pagination pagination-sm">
          <#if ((attr.pageNum)==1 || attr.total ==0)>
            <li class="previous disabled"><a href="javascript:void(0)">首页</a></li>
            <li class="previous disabled"><a href="javascript:void(0)">上一页</a></li>
          <#else>
            <li class="previous"><a href="${action}?pageSize=${attr.pageSize}&pageNum=1${(orderByStr+queryStr)?replace('\r','%0d')?replace('\n','%0a')?html}">首页</a></li>
            <li class="previous"><a href="${action}?pageSize=${attr.pageSize}&pageNum=${(attr.size==0 || attr.pageNum<=1)?string("1",(attr.pageNum-1)?string)}${(orderByStr+queryStr)?replace('\r','%0d')?replace('\n','%0a')?html}">上一页</a></li>
          </#if>
          <li class="active"><a href="${action}?pageSize=${attr.pageSize}&pageNum=${(attr.size==0)?string('1',attr.pageNum?string)}${(orderByStr+queryStr)?replace('\r','%0d')?replace('\n','%0a')?html}">${(attr.pageNum==0)?string('1',attr.pageNum?string)}</a></li>
          <#if ((attr.pageSize)>(attr.size))>
            <li class="next disabled"><a href="javascript:void(0)">下一页></a></li>
          <#else>
            <li class="next"><a href="${action}?pageSize=${attr.pageSize}&pageNum=${(attr.size==0)?string("1",((attr.pageSize>attr.size)?string(attr.pageNum?string,(attr.pageNum+1)?string)))}${(orderByStr+queryStr)?replace('\r','%0d')?replace('\n','%0a')?html}">下一页</a></li>
          </#if>
        </ul>
      </div>
    </div>
  </#if>
  <!-- end paginator -->
</#macro>