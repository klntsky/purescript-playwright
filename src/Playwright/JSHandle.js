/* global exports */

exports.getProperties_ = function (insert) {
    return function (emptyMap) {
        return function (jsHandle) {
            return function () {
                return jsHandle.getProperties().then(function (props) {
                    var acc = emptyMap;
                    props.entries().forEach(function (pair) {
                        acc = insert(pair[0])(pair[1])(acc);
                    });
                    return acc;
                });
            };
        };
    };
};
