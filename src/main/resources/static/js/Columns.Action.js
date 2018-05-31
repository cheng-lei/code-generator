var Columns = window.Columns || {};
var Base = window.Base || {};

Columns.Action = function () {
};
Columns.Action.prototype = new Base.Action();
Columns.Action.prototype.getSubConfig = function () {
    var config = Columns.Config;
    config['$saveForm'] = $("#saveForm");
    config['saveUrl'] = "";
    config['deleteUrl'] = "";
    return config;
};
Columns.Action.Instance = (function () {
    var action = new Columns.Action();
    return action;
}());


