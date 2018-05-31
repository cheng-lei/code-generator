/*
 * popWindow
 * @autor zxj
 * @date 2015/11/16 13:17
 */
(function ($) {

    //popLayer 定义
    popLayer = $.fn;

    //常量
    var popWindowObject = {
        maskHtml: '<div id="mask" class="pop-mask"></div>',
        popLayerHtml: '<div class="pop-window" id="popWindow">'
        + '    <div class="pop-header minsc">'
        + '     <div class="headerToolbar"><i class="fa fa-remove pull-right" title="关闭"></i></div>'
        + '     <input type="text" id="poplayer-focus"><span class="title">请选择</span>&nbsp;&nbsp;<span class="time"></span>'
        + '   </div>'
        + '    <div class="pop-body"><div class="overlay"><i class="fa fa-spinner fa-spin"></i></div></div>'
        + '</div>'
    };

    /**
     * 方法
     * @type {{popLayer: Function, initMask: Function, initPopLayer: Function, initPopHeader: Function, initPopFooter: Function, initPopBody: Function, initCloseEvents: Function, initMoveEvents: Function, closePopLayer: Function}}
     */
    var methods = {
        showLoading: function(){
            var $this = $(this),
                pos = "absolute";
            if($this.length < 1) {
                $this = $("body");
                pos = "fixed";
            }
            $this.css("position","relative");
            $this.append('<div class="overlay" style=""><i class="fa fa-spinner fa-spin"></i></div>');
            $this.children(".overlay").css({"height":"100%","width":"100%","z-index":1060,"top":0,"left":0,"position":pos,"background":"black","filter":"Alpha(opacity=60)","opacity":0.6});
            $this.children(".overlay").children("i.fa").css({"top": "45%","left":"50%","position":"absolute","margin-left":"-15px","margin-top":"-15px","color":"rgba(255, 255, 255, 0.74)","font-size":"65px"});
        },
        closeLoading: function(){
            var $this = $(this);
            if($this.length < 1) {
                $this = $("body");
            }
            $this.children(".overlay").remove();
        },
        /**
         * 初始化页面HTML
         */
        popLayer: function (options) {
            var settings = $.extend({}, this.popLayer.defaults, options);

            $(this).popLayer('initMask', settings);
            $(this).popLayer('initPopLayer', settings);
            $(this).popLayer('initPopHeader', settings);
            $(this).popLayer('initPopFooter', settings);
            $(this).popLayer('initPopBody', settings);

            var ofy = $("body").css("overflow-y");
            if(ofy != "hidden") {
                $("#poplayer-focus").val(ofy)
                $("body").css("overflow-y","hidden");
            }

            $(this).popLayer('initCloseEvents', settings);
            if(settings.drag){
                $(this).popLayer('initMoveEvents');
            } else {
                $(this).popLayer('unbindMoveEvents');
            }
            $(this).popLayer('initResizeEvents', settings);
        },

        /**
         * 初始化遮罩层
         *
         * @param {Object} options
         * @returns {Object[]}
         */
        initMask: function (settings) {
            if(settings.mask){
                if ($("#mask").length < 1) {
                    $("body").append(popWindowObject.maskHtml);
                }
                $("#mask").css("height", $(document).height());
                $("#mask").css("width", $(document).width());
                $("#mask").show();
            }
        },

        /**
         * 初始化窗口规格以及位置
         *
         * @param {Object} options
         * @returns {Object[]}
         */
        initPopLayer: function (settings) {
            if ($("#popWindow").length < 1) {
                $("body").append(popWindowObject.popLayerHtml);
            } else {
                $("#popWindow .pop-body").html('<div class="overlay"><i class="fa fa-spinner fa-spin"></i></div>');
            }
            //窗口规格 4: border width * 2 38: header height 51 :footer height
            if (settings.type == 'modal') {
                $("#popWindow").css({"width": "896px", "height": "586px"});
                if (settings.footer) {
                    $("#popWindow .pop-body").css({"height": 586 - 38 - 51});
                } else {
                    $("#popWindow .pop-body").css({"height": 586 - 38 - 4});
                }
            } else if (settings.type == 'window') {
                $("#popWindow").css({"width": settings.width, "height": settings.height});
                if (settings.footer) {
                    $("#popWindow .pop-body").css({"height": settings.height - 38 - 51});
                } else {
                    $("#popWindow .pop-body").css({"height": settings.height - 38 - 4});
                }
            }

            initPosition(this, settings);
            $("#popWindow").show();
        },

        /**
         * 初始化popheader数据
         * @param setting
         */
        initPopHeader: function (setting) {
            if(setting.title){
                $("#popWindow").find('.pop-header .title').html(setting.title);
            } else {
                $("#popWindow").find('.pop-header .title').html('弹出层');
            }
            if (setting.type == 'modal') {
                $("#popWindow").find('.pop-header .title').css("max-width",(896 * 2/3));
            } else {
                $("#popWindow").find('.pop-header .title').css("max-width",(setting.width * 2/3));
            }
            //双击最大化
            if(setting.dbClick){
                $("#popWindow").find('.pop-header').dblclick(function(){
                    if($(this).hasClass('minsc')){//小屏变大
                        setMaxScreen(setting);
                    } else if($(this).hasClass('maxsc')){//大屏变小
                        setMinScreen(setting);
                    }
                });
            }
            //全屏最大化按钮
            if(setting.maxBtn){
                $("#popWindow").find('.pop-header .headerToolbar .maxBtn').remove();
                $("#popWindow").find('.pop-header .headerToolbar').append('<i class="fa fa-square-o pull-right maxBtn" title="全屏"></i>');
                $("#popWindow").find('.pop-header .headerToolbar>i.maxBtn').click(function(){
                    if($(this).hasClass('fa-square-o')){
                        setMaxScreen(setting);
                    } else if($(this).hasClass('fa-clone')){
                        setMinScreen(setting);
                    }
                });
            }
        },

        /**
         * 初始化popfooter数据
         * @param setting
         */
        initPopFooter: function (setting) {
            $("#popWindow .pop-footer").remove();
            if (setting.footer || setting.closeBtn) {
                $("#popWindow").append('<div class="pop-footer"></div>');
                if (setting.footer){
                    setting.footer.forEach(function (obj) {
                        var button = $('<button type="button"></button>');
                        button.html(obj.text);
                        button.addClass(obj.class);
                        if ((typeof obj.handler) == "function") {
                            button.bind("click", {}, function (event) {
                                obj.handler.apply(button, [button, event]);
                            });
                        } else if ((typeof obj.handler) == "string") {
                            button.bind("click", {}, function (event) {
                                eval("var _function = " + obj.handler);
                                _function(button, event);
                            });
                        }
                        button.appendTo("#popWindow .pop-footer");
                    });
                }
                if(setting.closeBtn) {
                    $('<button type="button" class="btn btn-default">关闭</button>').bind("click", {}, function () {
                        $(this).popLayer("closePopLayer");
                    }).appendTo("#popWindow .pop-footer");
                }
            }
        },

        /**
         * 初始化popBody数据
         * @param setting
         */
        initPopBody: function (setting) {
            var popBody = $("#popWindow").find('.pop-body');
            if (setting.data) {
                if(setting.data.source == "local") {
                    //非远程URL获取
                    if($("#" + setting.data.id).length > 0){
                        popBody.html($("#" + setting.data.id).html());
                    } else {
                        popBody.html("");
                    }
                    popBody.css("overflow-y","auto");
                    if ((typeof setting.data.callback) == "function") {
                        setting.data.callback.apply($(this), [popBody]);
                    } else if ((typeof setting.data.callback) == "string") {
                        eval("var _function = " + setting.data.callback);
                        _function(popBody);
                    }
                } else {
                    var url = setting.data.url;

                    if (!url) {
                        url = "";
                    }
                    if (setting.data.id) {
                        url += " #" + setting.data.id;
                    }
                    if (setting.data.data) {
                        popBody.load(url, setting.data.data, function (responseTxt, statusTxt, xhr) {
                            handler();
                            if ($("#popWindow .pop-footer").length < 1) {
                                $("#popWindow .pop-body>div").css("bottom", 0);
                            }
                            if ((typeof setting.data.callback) == "function") {
                                setting.data.callback.apply($(this), [responseTxt, statusTxt, xhr]);
                            } else if ((typeof setting.data.callback) == "string") {
                                eval("var _function = " + setting.data.callback);
                                _function(responseTxt, statusTxt, xhr);
                            }
                        });
                    } else {
                        popBody.load(url, function (responseTxt, statusTxt, xhr) {
                            handler();
                            if ($("#popWindow .pop-footer").length < 1) {
                                $("#popWindow .pop-body>div").css("bottom", 0);
                            }
                            if ((typeof setting.data.callback) == "function") {
                                setting.data.callback.apply($(this), [responseTxt, statusTxt, xhr]);
                            } else if ((typeof setting.data.callback) == "string") {
                                eval("var _function = " + setting.data.callback);
                                _function(responseTxt, statusTxt, xhr);
                            }
                        });
                    }
                }
            } else {
                popBody.html("<div class='text-warning container'>" + setting.noDataText + "<div>");
            }
        },

        /**
         * 初始化关闭事件
         */
        initCloseEvents: function (settings) {
            $("#popWindow").find(".pop-header i.fa.fa-remove").click(function () {
                $(this).popLayer('closePopLayer');
                var closeFun = settings.closeTrigerFun;
                if(closeFun) {
                    if ((typeof closeFun) == "function") {
                        closeFun.apply($(this), [settings]);
                    } else if ((typeof closeFun) == "string") {
                        eval("var _function = " + closeFun);
                        _function(settings);
                    }
                }
            });

            if(settings.mask) {
                $("#mask").click(function (e) {
                    $(this).popLayer('closePopLayer');
                });
            }
        },

        /**
         * 取消拖拽事件
         */
        unbindMoveEvents: function(){
            $("#popWindow.pop-window .pop-header").unbind();
        },

        /**
         * 弹出框拖动功能
         */
        initMoveEvents: function () {
            var _move = false;//移动标记
            var _x, _y;//鼠标离控件左上角的相对位置

            $("#popWindow.pop-window .pop-header").click(function () {
                _move = false;
                $("#popWindow").fadeTo("fast", 1);//松开鼠标后停止移动并恢复成不透明
            }).mousedown(function (e) {
                _move = true;
                _x = e.pageX - parseInt($("#popWindow").css("left"));
                _y = e.pageY - parseInt($("#popWindow").css("top"));
                $("#popWindow").fadeTo(20, 0.7);//点击后开始拖动并透明显示
            });

            $(document).mousemove(function(e){
                if (_move) {
                    var x = e.pageX - _x;//移动时根据鼠标位置计算控件左上角的绝对位置
                    var y = e.pageY - _y;
                    var posi = setRange(y, x);
                    $("#popWindow").css({
                        top: posi[0],
                        left: posi[1]
                    });//控件新位置
                }
            }).mouseup(function(){
                _move = false;
                $("#popWindow").fadeTo("fast", 1);//松开鼠标后停止移动并恢复成不透明
            });

        },

        /**
         * resize事件绑定
         */
        initResizeEvents: function (settings) {
            var component = $(this);
            $(window).resize(function () {
                if($("#popWindow").find('.pop-header').hasClass('maxsc')){
                    setMaxScreen(settings);
                } else {
                    if ($("#popWindow").length > 0 && $("#popWindow")[0].style.display != "none") {
                        initPosition(component, settings);
                    }
                    if ($("#mask").length > 0) {
                        $("#mask").css("height", $(document).height());
                        $("#mask").css("width", $(document).width());
                    }
                }
            });
        },

        /**
         * 设置标题
         * @param title
         */
        setTitle: function (title) {
            $("#popWindow").find('.pop-header .title').html(title);
        },

        /**
         * 标题备注更新
         * @param title
         */
        updateTime: function (remark) {
            $("#popWindow").find('.pop-header .time').html(remark);
        },

        /**
         * 关闭弹出层
         */
        closePopLayer: function () {
            var ofy = $("#poplayer-focus").val();
            if(ofy != "hidden" && "" != ofy) {
                $("body").css("overflow-y",ofy);
                $("#poplayer-focus").val("");
            }
            $("#mask,#popWindow").remove();
        }
    };

    /**
     * 后续处理函数
     * 处理一些必要的页面操作
     */
    var handler = function(){
        $("#popWindow form").keydown(function(e){
            var evt = e || event;
            var ecd = evt.which || evt.keyCode;
            return ecd == 13 ? false : true;
        });
    }

    /**
     * 最大化窗口
     */
    var setMaxScreen = function(setting){

        $("#popWindow").css({"width": $(window).width() -10, "height": $(window).height()-10});
        if (setting.footer) {
            $("#popWindow .pop-body").css({"height": $(window).height() - 38 - 51});
        } else {
            $("#popWindow .pop-body").css({"height": $(window).height() - 38});
        }
        $("#popWindow").css("top", 0).css("left",0);

        if(setting.maxBtn) {
            var maxBtn = $("#popWindow").find('.pop-header .headerToolbar>i.maxBtn');
            if(maxBtn.hasClass('fa-square-o')) {
                maxBtn.attr('title', '恢复');
                maxBtn.removeClass('fa-square-o');
                maxBtn.addClass('fa-clone');
            }
        }
        if(setting.dbClick) {
            $("#popWindow").find('.pop-header').removeClass('minsc');
            $("#popWindow").find('.pop-header').addClass('maxsc');
        }
    }

    /**
     * 最小化窗口
     */
    var setMinScreen = function(setting){

        if (setting.type == 'modal') {
            $("#popWindow").css({"width": "896px", "height": "586px"});
            if (setting.footer) {
                $("#popWindow .pop-body").css({"height": 586 - 38 - 51});
            } else {
                $("#popWindow .pop-body").css({"height": 586 - 38});
            }
        } else if (setting.type == 'window') {
            $("#popWindow").css({"width": setting.width, "height": setting.height});
            if (setting.footer) {
                $("#popWindow .pop-body").css({"height": setting.height - 38 - 51});
            } else {
                $("#popWindow .pop-body").css({"height": setting.height - 38});
            }
        }

        initPosition(this, setting);
        $("#popWindow").show();

        if(setting.maxBtn) {
            var maxBtn = $("#popWindow").find('.pop-header .headerToolbar>i.maxBtn');
            if(maxBtn.hasClass('fa-clone')) {
                maxBtn.attr('title', '全屏');
                maxBtn.removeClass('fa-clone');
                maxBtn.addClass('fa-square-o');
            }
        }
        if(setting.dbClick) {
            $("#popWindow").find('.pop-header').removeClass('maxsc');
            $("#popWindow").find('.pop-header').addClass('minsc');
        }
    }

    /**
     * 初始化组件位置 private
     * @param obj
     */
    var initPosition = function (obj, settings) {
        //窗口位置
        var popTop, popLeft;
        if (obj.length < 1 || settings.position == "center") {
            popLeft = ($(window).width() - $("#popWindow").width()) / 2;
            popTop = ($(window).height() - $("#popWindow").height()) / 2 + $(document).scrollTop();
        } else {
            var position = settings.position;
            //7 : popwindow margin width(5) + border width(2)
            //12 : popwindow margin width(5*2) + border width(2)
            if (!position || position == 'down') {
                popTop = obj.offset().top + obj.outerHeight() - 5;
                popLeft = obj.offset().left - 7;
            } else if (position == 'up') {
                popTop = obj.offset().top - $("#popWindow").outerHeight() - 12;
                popLeft = obj.offset().left - 7;
            } else if (position == 'left') {
                popTop = obj.offset().top - $("#popWindow").outerHeight() / 2;
                popLeft = obj.offset().left - $("#popWindow").outerWidth() - 7;
            } else if (position == 'leftdown') {
                popTop = obj.offset().top + obj.outerHeight() - 5;
                popLeft = obj.offset().left - $("#popWindow").outerWidth() - 7;
            } else if (position == 'leftup') {
                popTop = obj.offset().top - $("#popWindow").outerHeight() - 12;
                popLeft = obj.offset().left - $("#popWindow").outerWidth() - 7;
            } else if (position == 'right') {
                popTop = obj.offset().top - $("#popWindow").outerHeight() / 2;
                popLeft = obj.offset().left + obj.outerWidth() - 7;
            } else if (position == 'rightup') {
                popTop = obj.offset().top - $("#popWindow").outerHeight() - 12;
                popLeft = obj.offset().left + obj.outerWidth() - 7;
            } else if (position == 'rightdown') {
                popTop = obj.offset().top + obj.outerHeight() - 5;
                popLeft = obj.offset().left + obj.outerWidth() - 7;
            } else {
                popLeft = ($(window).width() - $("#popWindow").width()) / 2;
                popTop = ($(window).height() - $("#popWindow").height()) / 2 + $(document).scrollTop();
            }
        }

        //判断是否超出界限
        var posi = setRange(popTop, popLeft);
        $("#popWindow").css("top", posi[0]).css("left", posi[1]);
    };

    /**
     * 设置范围 private
     * @param popTop
     * @param popLeft
     */
    var setRange = function (popTop, popLeft) {
        if ((popTop + $("#popWindow").height() > $('body').height() - 15)) {
            popTop = $('body').height() - $("#popWindow").height() - 15;
        }
        if (popTop < 0) {
            popTop = 0;
        }
        if (popLeft < 0) {
            popLeft = 0;
        }
        if ((popLeft + $("#popWindow").width() > $('body').width() - 10)) {
            popLeft = $('body').width() - $("#popWindow").width() - 10;
        }
        return [popTop, popLeft];
    };

    /**
     * 方法调用
     * @param method
     * @returns {*}
     */
    $.fn.popLayer = function (method) {
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.popLayer.apply(this, arguments);
        } else {
            $.error('Method with name ' + method + ' does not exists for jQuery.popLayer');
        }
    };

    /**
     *默认全局参数
     * @type {{title: string, type: string, mask: boolean, closeBtn: boolean, footer: boolean, drag: boolean, width: number, height: number, position: string, data: boolean, noDataText: string}}
     */
    $.fn.popLayer.defaults = {
        title: '请选择',
        title: '请选择',
        type: 'window',
        closeBtn: false,
        footer: false,
        mask: true,
        maxBtn:false,
        closeTrigerFun:false,
        dbClick:false,
        source:'remote',
        drag:true,
        width: 500,
        height: 492,
        position: 'rightdown',
        data: false,
        noDataText: '无数据，请正确操作'
    };

    /*******************************************************************Alert Confirm*************************************************************/
    /**
     * 提示框 确认框
     * @type {{Alert: Function, Confirm: Function}}
     */
    $.MsgBox = {
        /**
         * 提示框
         * @param parm1 标题
         * @param parm2 提示正文
         * @param parm3 : info(default) error warning，可为空
         * @param parm4 : callback,可为空
         * @constructor
         */
        Alert: function (parm1, parm2, parm3, parm4) {
            /**
             * 参数判断
             * callback:function
             * 0个参数：
             * 一个参数：msg
             * 二个参数：msg + callback
             *           msg + status
             *           msg + title
             *  三个参数：msg + status + callback
             *            msg + status + title
             *            msg + title + status
             *  四个参数：title + msg + status + callback
             */
            if (parm1 && !parm2 && !parm3 && !parm4) {
                if (typeof parm1 == "function") {
                    initMsgBoxHtml("alert", "提示", "提示", "info");
                    initMsgBoxEvents(parm1);
                } else {
                    initMsgBoxHtml("alert", "提示", parm1, "info");
                    initMsgBoxEvents();
                }
            } else if (parm1 && parm2 && !parm3 && !parm4) {
                if (typeof parm2 == "function") {
                    initMsgBoxHtml("alert", "提示", parm1, "info");
                    initMsgBoxEvents(parm2);
                } else if ($.inArray(parm2, alertStatus) >= 0) {
                    initMsgBoxHtml("alert", "", parm1, parm2);
                    initMsgBoxEvents();
                } else {
                    initMsgBoxHtml("alert", parm1, parm2, "info");
                    initMsgBoxEvents();
                }
            } else if (parm1 && parm2 && parm3 && !parm4) {
                if (typeof parm3 == "function") {
                    if ($.inArray(parm2, alertStatus) >= 0) {
                        initMsgBoxHtml("alert", "", parm1, parm2);
                    } else {
                        initMsgBoxHtml("alert", parm1, parm2, "info");
                    }
                    initMsgBoxEvents(parm3);
                } else {
                    initMsgBoxHtml("alert", parm1, parm2, parm3);
                    initMsgBoxEvents();
                }
            } else if (parm1 && parm2 && parm3 && parm4 && typeof parm4 == "function") {
                initMsgBoxHtml("alert", parm1, parm2, parm3);
                if(typeof parm4 == "function") {
                    initMsgBoxEvents(parm4);
                } else {
                    initMsgBoxEvents();
                }
            } else {
                initMsgBoxHtml("alert", "提示", "随便提示点东东吧！", "info");
                initMsgBoxEvents();
            };
            $("#mb_btn_ok").focus();
        },
        /**
         * 确认框
         * @param title 标题
         * @param msg 消息正文
         * @param callback 回调函数，参数true false
         * @constructor
         */
        //Confirm: function (title, msg, callback) {
        Confirm: function ( parm1, parm2, parm3) {
            /**
             * 参数判断
             * callback:必输
             * 一个参数：callback:function
             * 二个参数：msg + callback
             *  三个参数：msg + title + callback
             */
            if(parm1 && !parm2 && !parm3) {
                if(typeof parm1 == "function") {
                    initMsgBoxHtml("confirm", "请确认", "请确认");
                    initMsgBoxEvents(parm1);
                } else {
                    initMsgBoxHtml("confirm", "请确认", parm1);
                    initMsgBoxEvents();
                }
            } else if(parm1 && parm2 && !parm3){
                if(typeof parm2 == "function") {
                    initMsgBoxHtml("confirm", "请确认", parm1);
                    initMsgBoxEvents(parm2);
                } else {
                    initMsgBoxHtml("confirm", parm1, parm2);
                    initMsgBoxEvents();
                }
            } else if(parm1 && parm2 && parm3){
                if(typeof parm3 == "function") {
                    initMsgBoxHtml("confirm", parm1, parm2);
                    initMsgBoxEvents(parm3);
                } else {
                    initMsgBoxHtml("confirm", parm1, parm2);
                    initMsgBoxEvents();
                }
            }
            $("#mb_btn_ok").focus();
        }
    };

    /**
     * alert框状态
     * @type {string[]}
     */
    var alertStatus = ["info", "error", "warning"];

    /**
     * 初始化MsgBox容器
     * @param type
     * @param title
     * @param msg
     */
    var initMsgBoxHtml = function (type, title, msg, status) {

        $("#mb_box,#mb_con").remove();

        if (!title) {
            //status 状态设定
            if (type == "alert") {
                if (status == "error") {
                    title = "错误";
                } else if (status == "warning") {
                    title = "警告";
                } else {
                    title = "提示";
                }
            } else {
                title = "请确认";
            }
        }

        if (!msg) {
            msg = "";
        }

        var faIcon = "";
        if (type == "alert") {
            faIcon = "fa-warning";
        } else {
            faIcon = "fa-question-circle";
        }
        var _html = "";
        _html += '<div id="mb_box"></div>'
            + '<div id="mb_con">'
            + '  <span id="mb_tit"><i class="fa ' + faIcon + ' text-primary" style="margin-right: 10px;"></i><span class="title">' + title + '</span></span>'
            + '  <i id="mb_ico" class="fa fa-remove" title="取消"></i>'
            + '  <div id="mb_msg">' + msg + '</div>'
            + '  <div id="mb_btnbox">';

        if (type == "alert") {
            _html += '<input id="mb_btn_ok" type="button" value="确定" />';
        }
        if (type == "confirm") {
            _html += '<input id="mb_btn_ok" type="button" value="确定" />';
            _html += '<input id="mb_btn_no" type="button" value="取消" />';
        }
        _html += '</div></div>';

        $("body").append(_html);

        //初始化提示框位置中间显示
        var popLeft = ($(window).width() - $("#mb_con").width()) / 2,
            popTop = ($(window).height() - $("#mb_con").height()) / 2;

        //让提示框居中
        $("#mb_con").css({top: popTop, left: popLeft});

        //status 状态设定
        if (type == "alert") {
            if (status == "error") {
                $("#mb_tit i").addClass("text-red");
                $("#mb_tit").css("border-bottom", "3px solid #F98686");
            } else if (status == "warning") {
                $("#mb_tit i").addClass("text-yellow");
                $("#mb_tit").css("border-bottom", "3px solid #F39C12");
            } else {
                $("#mb_tit i").addClass("text-blue");
                $("#mb_tit").css("border-bottom", "3px solid #009BFE");
            }
        }
    };

    /**
     * 初始化事件
     * @param callback
     */
    var initMsgBoxEvents = function (callback) {
        //防止关闭popLayer
        $("#mb_box").click(function (e) {
            e.stopPropagation();
        });
        $("#mb_con").click(function (e) {
            e.stopPropagation();
        });
        //确定按钮事件
        $("#mb_btn_ok").click(function (e) {
            $("#mb_box,#mb_con").remove();
            if (typeof (callback) == 'function') {
                callback(true);
            }
            e.stopPropagation();
        });
        //取消按钮事件
        $("#mb_btn_no,#mb_ico").click(function (e) {
            $("#mb_box,#mb_con").remove();
            if (typeof (callback) == 'function') {
                callback(false);
            }
            e.stopPropagation();
        });
    }
})(jQuery);
