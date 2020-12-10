/* global exports */

exports.exposeBinding_ = function (x) {
    return function (name) {
        return function (cb) {
            return function (opts) {
                return function () {
                    return x.exposeBinding(name, function (info, arg) {
                        return cb(info)(arg)();
                    }, opts);
                };
            };
        };
    };
};
