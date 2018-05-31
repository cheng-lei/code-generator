var Columns = window.Columns || {};
var Base = window.Base || {};

Columns.Action = function () {
};
Columns.Action.prototype = new Base.Action();

Columns.Action.prototype.getSubConfig = function () {
    return Columns.Config;
};


