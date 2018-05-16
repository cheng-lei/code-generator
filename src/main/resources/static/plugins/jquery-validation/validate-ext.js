/**
 * Created by xujinzhang on 2015/11/18.
 */
jQuery.extend(jQuery.validator.messages, {
    required: "必选字段",
    remote: "内容冲突",
    email: "邮件格式不正确",
    url: "网址格式不正确",
    date: "日期格式不正确",
    dateISO: "日期(ISO)格式不正确.",
    number: "只能输入数字",
    digits: "只能输入整数",
    creditcard: "信用卡号格式不正确",
    equalTo: "两次输入的值不一致",
    accept: "后缀名格式不正确",
    maxlength: jQuery.validator.format("最大长度不能超过 {0} "),
    minlength: jQuery.validator.format("最小长度不能短于 {0} "),
    rangelength: jQuery.validator.format("长度介于 {0} 和 {1} 之间"),
    range: jQuery.validator.format("值介于 {0} 和 {1} 之间"),
    max: jQuery.validator.format("值最大为{0}"),
    min: jQuery.validator.format("值最小为{0}")
});

/**
 * 自定义规则
 * class --> valid
 */
jQuery.extend(jQuery.validator,{

    classRules: function(element){
        var rules = {},
            classes = $( element ).attr( "valid");
        if (classes) {
            var obj = eval("(" + $.trim(classes) + ")");
            $.each( obj, function(key,value) {
                if ( key in $.validator.classRuleSettings ) {
                    $.extend( rules, $.validator.classRuleSettings[ key ]);
                }
            });
        }
        return rules;
    }
});

jQuery.extend( jQuery.validator.methods, {

    // http://jqueryvalidation.org/remote-method/
    remote: function( value, element, param ) {
        if ( this.optional( element ) ) {
            return "dependency-mismatch";
        }

        var previous = this.previousValue( element ),
            validator, data;

        if (!this.settings.messages[ element.name ] ) {
            this.settings.messages[ element.name ] = {};
        }
        previous.originalMessage = this.settings.messages[ element.name ].remote;
        this.settings.messages[ element.name ].remote = previous.message;

        param = typeof param === "string" && { url: param } || param;

        if ( previous.old === value ) {
            return previous.valid;
        }

        previous.old = value;
        validator = this;
        this.startRequest( element );
        data = {};
        data[ element.name ] = value;
        $.ajax( $.extend( true, {
            mode: "abort",
            port: "validate" + element.name,
            dataType: "json",
            data: data,
            context: validator.currentForm,
            success: function( response ) {
                var valid = response === true || response === "true",
                    errors, message, submitted;

                validator.settings.messages[ element.name ].remote = previous.originalMessage;
                if ( valid ) {
                    submitted = validator.formSubmitted;
                    validator.prepareElement( element );
                    validator.formSubmitted = submitted;
                    validator.successList.push( element );
                    delete validator.invalid[ element.name ];
                    validator.showErrors();
                } else {
                    errors = {};
                    if(typeof response == 'object') {
                        message = response.message || validator.defaultMessage( element, "remote" );
                    } else {
                        message = response || validator.defaultMessage( element, "remote" );
                    }
                    errors[ element.name ] = previous.message = $.isFunction( message ) ? message( value ) : message;
                    validator.invalid[ element.name ] = true;
                    validator.showErrors( errors );
                }
                previous.valid = valid;
                validator.stopRequest( element, valid );
            }
        }, param ) );
        return "pending";
    }
});

jQuery.extend( jQuery.validator.prototype, {
    /**
     * 自定义错误显示
     */
    customShowErrors: function(){
        var i, elements, error;
        for ( i = 0; this.errorList[ i ]; i++ ) {
            error = this.errorList[ i ];
            if ( this.settings.highlight ) {
                this.settings.highlight.call( this, error.element, this.settings.errorClass, this.settings.validClass );
            }
            this.showCustomLabel( error.element, error.message );
        }
        if ( this.errorList.length ) {
            this.toShow = this.toShow.add( this.containers );
        }
        if ( this.settings.success ) {
            for ( i = 0; this.successList[ i ]; i++ ) {
                this.showCustomLabel( this.successList[ i ] );
            }
        }
        if ( this.settings.unhighlight ) {
            for ( i = 0, elements = this.validElements(); elements[ i ]; i++ ) {
                this.settings.unhighlight.call( this, elements[ i ], this.settings.errorClass, this.settings.validClass );
            }
        }
        this.toHide = this.toHide.not( this.toShow );
        this.hideErrors();
        this.addWrapper( this.toShow ).show();
        if(this.errorList.length > 0 ) {
            var docSTop = $(document).scrollTop(),
                cptSTop = this.errorList[0].element.offsetParent.offsetTop;
            console.log(docSTop + " : " + cptSTop);
            if(cptSTop < docSTop || cptSTop > (docSTop + $(window).height())){
                scrollTo(0,this.errorList[0].element.offsetParent.offsetTop);                
            }
        }
    },
    formatAndAdd: function( element, rule ) {
        var msgs = $( element ).attr( "messages"),
            self = this,
            message;
        if(msgs) {
            var obj = eval("(" + $.trim(msgs) + ")");
            $.each( obj, function(key,value) {
                if ( key in $.validator.classRuleSettings && key == rule.method) {
                    message = value;
                    self.errorList.push({
                        message: message,
                        element: element,
                        method: key
                    });
                }
            });
        } else {
           message = this.defaultMessage( element, rule.method );
            var theregex = /\$?\{(\d+)\}/g;
            if ( typeof message === "function" ) {
                message = message.call( this, rule.parameters, element );
            } else if ( theregex.test( message ) ) {
                message = $.validator.format( message.replace( theregex, "{$1}" ), rule.parameters );
            }
            this.errorList.push({
                message: message,
                element: element,
                method: rule.method
            });
        }
        this.errorMap[ element.name ] = message;
        this.submitted[ element.name ] = message;
    },
    showLabel: function(element, message){
        var place, group, errorID,
            error = this.errorsFor( element ),
            elementID = this.idOrName( element ),
            describedBy = $( element ).attr( "aria-describedby" );
        if ( error.length ) {
            // refresh error/success class
            error.removeClass( this.settings.validClass ).addClass( this.settings.errorClass );
            // replace message on existing label
            error.html( "<i class='fa fa-warning'></i>&nbsp;&nbsp;" + message );
        } else {
            // create error element
            error = $( "<" + this.settings.errorElement + ">" )
                .attr( "id", elementID + "-error" )
                .addClass( this.settings.errorClass )
                .html("<i class='fa fa-warning'></i>&nbsp;&nbsp;" +  message || "" );

            // Maintain reference to the element to be placed into the DOM
            place = error;
            if ( this.settings.wrapper ) {
                // make sure the element is visible, even in IE
                // actually showing the wrapped element is handled elsewhere
                place = error.hide().show().wrap( "<" + this.settings.wrapper + "/>" ).parent();
            }
            if ( this.labelContainer.length ) {
                this.labelContainer.append( place );
            } else if ( this.settings.errorPlacement ) {
                this.settings.errorPlacement( place, $( element ) );
            } else {
                place.insertAfter( element );
            }

            // Link error back to the element
            if ( error.is( "label" ) ) {
                // If the error is a label, then associate using 'for'
                error.attr( "for", elementID );
            } else if ( error.parents( "label[for='" + elementID + "']" ).length === 0 ) {
                // If the element is not a child of an associated label, then it's necessary
                // to explicitly apply aria-describedby

                errorID = error.attr( "id" ).replace( /(:|\.|\[|\]|\$)/g, "\\$1");
                // Respect existing non-error aria-describedby
                if ( !describedBy ) {
                    describedBy = errorID;
                } else if ( !describedBy.match( new RegExp( "\\b" + errorID + "\\b" ) ) ) {
                    // Add to end of list if not already present
                    describedBy += " " + errorID;
                }
                $( element ).attr( "aria-describedby", describedBy );

                // If this element is grouped, then assign to all elements in the same group
                group = this.groups[ element.name ];
                if ( group ) {
                    $.each( this.groups, function( name, testgroup ) {
                        if ( testgroup === group ) {
                            $( "[name='" + name + "']", this.currentForm ).attr( "aria-describedby", error.attr( "id" ) );
                        }
                    });
                }
            }
        }
        if ( !message && this.settings.success ) {
            error.text( "" );
            if ( typeof this.settings.success === "string" ) {
                error.addClass( this.settings.success );
            } else {
                this.settings.success( error, element );
                error.html("<i class='fa fa-check-circle'></i>&nbsp;&nbsp;" + error.html());
            }
        } else {
            error.removeClass("success");
        }
        this.toShow = this.toShow.add( error );
    },
    showCustomLabel: function(element, message){
        var place, group, errorID,
            error = this.errorsFor( element ),
            elementID = this.idOrName( element ),
            describedBy = $( element ).attr( "aria-describedby" );
        if ( error.length ) {
            // refresh error/success class
            error.removeClass( this.settings.validClass ).addClass( this.settings.errorClass );
            // replace message on existing label
            error.html( "<i class='fa fa-warning'></i>&nbsp;&nbsp;" + message );
        } else {
            this.settings.errorElement = "span";
            error = $( "<" + this.settings.errorElement + " class='text-red'>" )
                .attr( "id", elementID + "-error" )
                .addClass( this.settings.errorClass )
                .html("<i class='fa fa-warning'></i>&nbsp;&nbsp;" +  message || "" );

            // Maintain reference to the element to be placed into the DOM
            place = error;
            this.settings.wrapper = "div";
            if ( this.settings.wrapper ) {
                // make sure the element is visible, even in IE
                // actually showing the wrapped element is handled elsewhere
                place = error.hide().show().wrap( "<" + this.settings.wrapper + " class='message-box'/>" ).parent();
                place.append('<div class="triangle-border tb-background"></div><div class="triangle-border tb-border"></div>')
            }
            if ( this.labelContainer.length ) {
                this.labelContainer.append( place );
            } else if ( this.settings.errorPlacement ) {
                this.settings.errorPlacement( place, $( element ) );
            } else {
                place.insertAfter( element );
            }
            place.css("margin-left",element.offsetWidth/2);
            // Link error back to the element
            if ( error.is( "label" ) ) {
                // If the error is a label, then associate using 'for'
                error.attr( "for", elementID );
            } else if ( error.parents( "label[for='" + elementID + "']" ).length === 0 ) {
                // If the element is not a child of an associated label, then it's necessary
                // to explicitly apply aria-describedby

                errorID = error.attr( "id" ).replace( /(:|\.|\[|\]|\$)/g, "\\$1");
                // Respect existing non-error aria-describedby
                if ( !describedBy ) {
                    describedBy = errorID;
                } else if ( !describedBy.match( new RegExp( "\\b" + errorID + "\\b" ) ) ) {
                    // Add to end of list if not already present
                    describedBy += " " + errorID;
                }
                $( element ).attr( "aria-describedby", describedBy );

                // If this element is grouped, then assign to all elements in the same group
                group = this.groups[ element.name ];
                if ( group ) {
                    $.each( this.groups, function( name, testgroup ) {
                        if ( testgroup === group ) {
                            $( "[name='" + name + "']", this.currentForm ).attr( "aria-describedby", error.attr( "id" ) );
                        }
                    });
                }
            }
        }
        if ( !message && this.settings.success ) {
            error.text( "" );
            if ( typeof this.settings.success === "string" ) {
                error.addClass( this.settings.success );
            } else {
                this.settings.success( error, element );
                error.html("<i class='fa fa-check-circle'></i>&nbsp;&nbsp;" + error.html());
            }
        } else {
            error.removeClass("success");
        }
        this.toShow = this.toShow.add( error );
    }
});

/**
 * 全角转半角
 * @param Str
 * @constructor
 */
function full2Half(Str) {
    var result = '';
    for (var i=0 ; i<Str.length; i++) {
        var code = Str.charCodeAt(i);//获取当前字符的Unicode编码
        if (code >= 65281 && code <= 65373)//在这个Unicode编码范围中的是所有的英文字母已及各种字符
        {
            result += String.fromCharCode(Str.charCodeAt(i) - 65248);//把全角字符的Unicode编码转换为对应半角字符的Unicode码
        } else if (code == 12288) {//空格
            result += String.fromCharCode(32);
        } else {
            result += Str.charAt(i);
        }
    }
    return result;
};

/**
 * 当返回的值符合正则时，返回true，否则false
 * 数字开头数字结尾逗号分隔："/^\\d+(,\\d+)*$/"
 * @name $.validator.methods.pattern
 * @type Boolean
 * @cat Plugins/Validate/Methods
 */
$.validator.addMethod("pattern", function(value, element, param) {
    if (this.optional(element)) {
        return true;
    }
    if (typeof param === "string") {
        param = eval("/" + $.trim(param) + "/");
    }
    return param.test(full2Half( $.trim(value)));
}, "无效格式.");

/**
 * 不能全部为空格
 * @name $.validator.methods.noblank
 * @type Boolean
 * @cat Plugins/Validate/Methods
 * @autor zxj
 */
$.validator.addMethod("noblank", function(value, element) {
    if(value.length > 0 && $.trim(value) == "") {
        return false;
    } else {
        return true;
    }
}, "不能全部为空格！");

/**
 * 不能全部为数字
 * @name $.validator.methods.noblank
 * @type Boolean
 * @cat Plugins/Validate/Methods
 * @autor zxj
 */
$.validator.addMethod("noOnlyNum", function(value, element) {
    return !/^[0-9]+$/.test($.trim(value));
}, "不能全部为数字！");


$.validator.addMethod("emailTrim", function(value, element) {
    $(element).val($.trim(value));
    return this.optional( element ) || /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/.test($.trim(value));
}, "邮件格式不正确！");

$.validator.addMethod("urlTrim", function(value, element) {
    $(element).val($.trim(value));
    return this.optional( element ) || /^(?:(?:(?:https?|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})).?)(?::\d{2,5})?(?:[/?#]\S*)?$/i.test( $.trim(value) );
}, "网址格式不正确！");

$.validator.addMethod("digitsTrim", function(value, element) {
    $(element).val($.trim(value));
    return this.optional( element ) || /^\d+$/.test( $.trim(value) );
}, "只能输入整数！");

$.validator.addMethod("numberTrim", function(value, element) {
    $(element).val($.trim(value));
    return this.optional( element ) || /^(?:-?\d+|-?\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test(  $.trim(value)  );
}, "只能输入数字！");

$.validator.addMethod("creditcardTrim", function(value, element) {
    $(element).val($.trim(value));
    if ( this.optional( element ) ) {
        return "dependency-mismatch";
    }
    // accept only spaces, digits and dashes
    if ( /[^0-9 \-]+/.test( $.trim(value) ) ) {
        return false;
    }
    var nCheck = 0,
        nDigit = 0,
        bEven = false,
        n, cDigit;

    value = $.trim(value).replace( /\D/g, "" );

    // Basing min and max length on
    // http://developer.ean.com/general_info/Valid_Credit_Card_Types
    if ( value.length < 13 || value.length > 19 ) {
        return false;
    }

    for ( n = value.length - 1; n >= 0; n--) {
        cDigit = value.charAt( n );
        nDigit = parseInt( cDigit, 10 );
        if ( bEven ) {
            if ( ( nDigit *= 2 ) > 9 ) {
                nDigit -= 9;
            }
        }
        nCheck += nDigit;
        bEven = !bEven;
    }

    return ( nCheck % 10 ) === 0;
}, "信用卡号格式不正确！");

/**
 * 汉子长度为2，最大规格
 * @name $.validator.methods.noblank
 * @type Boolean
 * @cat Plugins/Validate/Methods
 * @autor zxj
 */
$.validator.addMethod("maxSize", function( value, element, param ) {
    var value= value.replace(/[^\x00-\xff]/g, 'xx');
    var length = $.isArray( value ) ? value.length : this.getLength( value, element );
    return this.optional( element ) || length <= param;
}, jQuery.validator.format("最大长度不能超过 {0} "));