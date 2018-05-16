<#-- 页面常量(后端常用统一在ConstantUtil类中处理) -->
<#assign channelStatusColor={'0':'danger','1':'primary','3':'default','4':'warning'} >
<#-- 花絮关联对应关联内容类型中文含义 -->
<#assign tidbitRelateContentType={'1':'相关预告','2':'相关花絮','3':'相关资讯','4':'相关看点','0':'正片资讯'} >  
<#-- bpp频道部分状态中文含义 -->
<#assign bppChannelStatus={'1':'上线','3':'下线','4':'删除'} >
<#-- 各端频道状态对应中文含义 -->
<#assign terminalChannelStatus={'1':'上线','2':'隐藏','3':'下线','4':'废弃'} >
<#-- 各端状态对应颜色-->
<#assign terminalChannelStatusColor={'0':'danger','1':'primary','2':'info','3':'success','4':'default'} >
<#-- 频道定时任务状态对应中文含义 -->
<#assign channelTimerStatus={'0':'未开始','1':'已开始','2':'已结束'} >
<#-- bpp频道弹幕开关状态对应字段中文名及颜色 -->
<#assign bppBarrageSwitch={'0':'默认','-1':'关闭','1':'开启'} >
<#assign bppBarrageSwitchColor={'0':'gray','-1':'red','1':'blue'}>
<#-- bpp频道对应ordertype字段中文含义 -->
<#assign bppChannelOrderType={'0':'正序','1':'倒序'} >
<#-- 各端频道rectype字段各个值中文含义 -->
<#assign rectype={'0',"默认",'1':"最新",'2':"推荐",'3':"最热"} >
<#-- bpp频道对应ordertype字段各个值对应颜色 -->
<#assign channelOrderTypeColor={'0':'red','1':'blue'} >
<#-- bpp频道视频雷达扫描状态 -->
<#assign smartClickScanStatus={'Untreated':'未处理','Scanning':'正在扫描','ScanFailed':'扫描失败','Abandon':'废弃','Scanned':'已扫描'} >
<#-- bpp频道打点状态 -->
<#assign pointStatus={'0':'未打点','1':'已打点'} >                  
<#-- 频道cdn删除审核状态对应中文含义 -->
<#assign channelCdnDeleteStatus={'-1':'全部','0':'未审核','1':'用户取消','2':'审核通过','3':'审核未通过','4':'删除失败'} >
<#assign channelCdnDeleteColor={"-1":"default","0":"primary","1":"default",'2':'success',"3":"danger","4":"warning"} >
<#-- bpp频道打点类型各个值对应中文含义 -->
<#assign bppPointType={'5':'内容提示','8':'广告打点'}>
<#-- bpp频道广告打点类型各个值对应中文含义 -->
<#assign bppPointSubType={'0':'中插','1':'后插','2':'视频链','3':'视频雷达','4':'smartClick','5':'角标'}>
<#-- bpp属性类型各个值对应中文含义及颜色 -->
<#assign bppPropType={'0':'单选','1':'多选'} >
<#assign bppPropTypeColor={'0':'green','1':'red'} >
<#-- bpp属性值的状态-->
<#assign propValueStatus ={'0':'正常','1':'已废弃'}>
<#-- 剧集显示模式各个值对应中文含义及颜色 -->
<#assign episodeDisplayMode={'-1':'默认','1':'数字排版','0':'文字排版'} >
<#assign episodeDisplayModeColor={'-1':'gray','0':'red','1':'blue'} >
<#-- 视频文件format对应图标名 -->
<#assign bppFileFormatIcoName={'1':'icon_file_h265','2':'icon_drm','3':'icon_file_dolby','99':'icon_file_unkown'} > 

<#-- 虚拟频道管理 -->
<#assign virtualChannelStatus={'0':'在线','3':'下线','4':'删除'} >
<#assign virtualChannelStatusColor={'0':'primary','3':'default','4':'warning'} >
<#assign virtualChannelUseBkType={'0':'电影','1':'电视剧','2':'综艺节目','3':'动漫卡通'} >
<#assign virtualManualCrawStatus={'0':'未抓取','1':'已抓取'} >
<#assign virtualManualCrawResult={'1':'成功','2':'失败'} >
<#assign bkTypeAll={'0':'电影','1':'电视剧','2':'综艺','3':'动漫','4':'人物','5':'图片','6':'图集','8':'电视台','9':'体育','10':'资讯','11':'新闻','12':'游戏','13':'潮流'} >
<#-- 是否禁止下载 -->
<#assign virtualChannelDenyDownloadYesOrNo={'0':'否','1':'是'} >
<#-- 禁止下载 -->
<#assign virtualChannelDenyDownload={'0':'不禁止','1':'禁止'} >

<#-- 虚拟频道打开模式，1=播放器打开，2=浏览器打开，3=系统默认浏览器，4=不呈现 -->
<#assign openMode={'1':'播放器打开','2':'浏览器打开','3':'系统默认浏览器','4':'不呈现'} >
<#assign openModeClass={'1':'label-primary','2':'label-info','3':'label-success','4':'label-default'} >

<#-- 平台相关 -->
<#assign platformStatus={'0':'正常','1':'已废弃'} >
<#assign platformVisable={'0':'不可见','1':'可见'} >

<#-- sys相关常量 -->
<#assign sysOpLogType={'Add':'添加','Update':'修改','Delete':'删除','BatchAdd':'批量添加','BatchUpdate':'批量修改','BatchDelete':'批量删除','Other':'其它'}>
<#assign sysDemandType={'0':'新需求','1':'BUG修复'}>
<#assign sysDemandStatus={'0':'未确认','1':'已确认','2':'已完成'}>
<#assign sysDemandStatusColor={'0':'danger','1':'success','2':'primary'} >
<#assign sysDemandTypeColor={'0':'green','1':'danger'} >

<#-- 我的设置 -->
<#assign sysFontSize={'12':'小(12号字体)','14':'中(14号字体)','16':'大(16号字体)'} >

<#-- tag包常量-->
<#assign tagType={'0':'普通标签','1':'常用标签'} >

<#-- misc常量-->
<#assign playCountType={"1":"bpp分类","2":"频道"} >
<#assign playCountChannelQueryType={"0":"频道ID","1":"频道名"} >
<#-- 多终端 -->
<#assign platformSmartList=["tvbox","phone","pad","androidphone","androidpad","winphone","win8"]>

<#-- catalog常量 -->
<#assign epgCatalogType={"1":"分类ID","2":"父分类ID"} >
<#-- lib常量 -->
<#assign isContractDescType={"0":"有","1":"无"} >
<#assign contractStatusType={"0":"未删除","1":"已删除"} >
<#assign isOnlyType={"0":"非独家","1":"独家"} >
<#assign isOnlyPlayType={"0":"非独播","1":"独播"} >
<#assign contractAbcType={"A":"A","B+":"B+","B":"B","B-":"B-","C":"C"} >
<#assign contractOldAbcType={"A":"A","B":"B","C":"C","D":"D"} >
<#assign contractBuyDeparment={"0":"商务","1":"运营VIP","2":"多终端运营内容部","3":"电视台媒体合作部"} >
<#assign titleOrPartnerMap={"0":"片名","1":"合作方名称"} >
<#assign bkidOrContractno={"0":"百科id","1":"合同号"} >
<#assign partnerOrPptvOnly={"0":"合作方独家","1":"我方独家"} >
<#assign copyrightStatus={"0":"授权未开始","1":"授权期限中","2":"授权已过期","3":"本月到期","4":"本月开始"} >
<#assign copyrightStatusClass={"0":"label-default","1":"label-primary","2":"label-danger","3":"label-success","4":"label-warning"} >
<#assign otherTypeMap={"0":"无百科","1":"未关联合同","2":"有虚拟频道","3":"已删除","4":"去重","5":"有冲突","6":"授权终端无数据"} >
<#assign authorizedClass={"0":"pc","1":"移动端","2":"ppbox","3":"互联网电视"} >
<#assign licenceTypeMap={"NetDramaRecordNum":"网络剧备案号","AppContentLicenceNum":"申报内容许可证号","ReleaseLicenceNum":"公映许可证号","TVstationLicenceNum":"电视台发行许可证号","ImportAudApprovalNum":"进口音像制品批准文号"} >
<#assign authTerminalMap={"0":"网站节目管理","1":"客户端节目管理","2":"客户端3.0节目管理","3":"多终端节目管理","4":"手机节目管理","5":"wap节目管理","6":"TVBOX节目管理","7":"PHONE节目管理","8":"PAD节目管理"} >

<#-- 直播中心常量 -->
<#assign auditStatus={'0':'未审核','1':'通过', '2':'打回'} >
<#assign auditStatusColor={'0':'default','1':'primary', '2':'danger'} >
<#assign streamIsPay={'1':'付费','0':'免费'} >
<#assign streamVisible={'1':'显示','0':'隐藏'} >
<#assign streamVedioType={'4':'直播流','3':'点播流'}>
<#assign streamTitleType={'1':'节目名称','2':'标题名称'}>
<#assign programStreamPosition={'0','一直','1','直播前','2','直播中','3','直播后'}>
<#assign authorizedClass={"0":"pc","1":"移动端","2":"ppbox","3":"互联网电视"} >
<#assign vasPushStatusMap={"0":"推送失败","1":"已推送","2":"已定价","3":"取消推送"} >
<#assign vasPushStatusMapAll={"-1":"未推送","0":"推送失败","1":"已推送","2":"已定价","3":"取消推送"} >
<#assign vasChannelTypeMap={'0':'频道','1':'直播节目'} >

<#--
  皮肤控制:body标签class样式；使用示例：<@getSkinClass />
 -->
<#macro getSkinClass overflow=true>
"hold-transition skin-blue no-overflow sidebar-mini sidebar-collapse font-12"
</#macro>

<#--
避免url反斜线重复问题；使用示例：<@fixUrl url=mipWikiUrl />
 -->
<#macro fixUrl url=''>
${url!''}${(url!'')?ends_with("/")?string("","/")}
</#macro>