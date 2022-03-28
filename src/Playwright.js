/* global exports */

exports.onResponse = function (page) {
    return function (cb) {
        return function () {
            page.on('response', function (response) {
                cb(response)();
            });
        };
    };
};

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

exports.context = function (page) {
    return page.context();
};
