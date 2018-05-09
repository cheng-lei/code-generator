<!DOCTYPE html>

<html lang="en">
<head>
    <!-- START_OF_DEP_SECTION -->
    <!-- The jQuery library is a prerequisite for all jqSuite products -->
    <script type="text/ecmascript" src="/js/jquery-1.11.0.min.js"></script>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script type="text/ecmascript" src="/js/jquery.validate.min.js"></script>
    <script type="text/ecmascript" src="/js/additional-methods.min.js"></script>
    <script type="text/ecmascript" src="/js/messages_zh.min.js"></script>

    <!-- END_OF_DEP_SECTION -->
    <meta charset="utf-8"/>
    <style type="text/css">
        .invalid-msg {
            color: red;
        }

        .invalid-field {
            border-color: red;
        }

        .flag {
            color: red;
        }
    </style>
</head>
<body class="container">
<h1>修改用户</h1>
<br/><br/>
<div class="with:80%">
    <form class="form-horizontal" id="saveForm">
        <input type="hidden" name="id" value="${(t.id)!}"/>
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">名称</label>
            <div class="col-sm-3">
                <input type="text" class="form-control" name="name" id="name" value="${(t.name)!}"
                       placeholder="名称"/>
            </div>
        </div>
        <div class="form-group">
            <label for="age" class="col-sm-2 control-label">年龄</label>
            <div class="col-sm-3">
                <input type="number" class="form-control" name="age" id="age" value="${(t.age)!}"
                       placeholder="年龄"/>
            </div>
        </div>
        <div class="form-group">
            <label for="chineseScore" class="col-sm-2 control-label">语文成绩</label>
            <div class="col-sm-3">
                <input type="text" class="form-control" name="chineseScore" id="chineseScore" value="${(t.chineseScore)!}"
                       placeholder="语文成绩"/>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <input type="submit" onclick="doSave()" value="提交" class="btn btn-info"/>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    function doSave() {
        var params = getParams("saveForm");
        console.log(params);
    }

    function getParams(formId) {
        var self = $("#" + formId), serializeParam = self.serializeArray(), param = {};
        $.map(serializeParam, function (k, v) {
            param[k.name] = k.value
        });
        return param;
    }

    $(document).ready(function () {
        $('#saveForm').validate({
            debug: 'true', // just for debug
            errorClass: 'invalid-msg',
            rules: {
                name: {
                    required: true,
                    maxlength: 30
                },
                age: {
                    required: true,
                    digits: true,
                    range: [1, 200]
                }
            }
        });
    });
</script>
</body>
</html>