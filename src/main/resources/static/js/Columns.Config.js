Columns.Config = {
    TABLE: {
        LIST: {
            url: "http://localhost:8080/columns/page",
            colModel: [
                {label: 'ID', name: 'id'},
                {label: '表名称', name: 'tableName'},
                {label: '列名称', name: 'columnName'},
                {label: '数据类型', name: 'dataType'},
                {label: '注释', name: 'columnComment'},
                {
                    label: '操作', name: 'operation', formatter: function (o, v, r) {
                    return '<button class="btn btn-primary btn-sm my-btn-add" onclick="Columns.Action.Instance.saveOrUpdate(this)" data-id=' + r.id + '>编辑</button>' +
                        '|<button class="btn btn-danger btn-sm my-btn-del" onclick="Columns.Action.Instance.doBatchDelete(this)" data-id=' + r.id + '>删除</button>'
                }
                }
            ]
        }
    },
    DIALOG: {
        data: {
            url: "/columns/beforeSave/" //url可以应该更换
        },
        footer:[
            {text:"确定",class:"btn btn-info",handler:function (result) {
                $.MsgBox.Alert("测试确定成功!");
            }},{text:"取消",class:"btn btn-info",handler:function (result) {
                $.MsgBox.Alert("测试取消成功!");
            }}
        ]
    }
};