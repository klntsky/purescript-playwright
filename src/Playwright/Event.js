/* global exports */

exports.onForeign = function (obj) {
    return function (eventName) {
        return function (effCallback) {
            return function () {
                obj.on(eventName, function (argument) {
                    effCallback(argument)();
                });
            };
        };
    };
};
