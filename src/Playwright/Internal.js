/* global exports */

/**
 * @param {string} property - method to call on object
 * @param {number} n - number of (curried) arguments
 *
 * E.g. these are equivalent:
 *
 * function (browser) {
 *   return function () {
 *     return browser.close();
 *   };
 * }
 *
 * and
 *
 * effectfulGetter('close', 0);
 */
function effectfulGetter (property, n) {
    var args = [];

    return function (object) {
        function runner (arg) {
            if (n == 0) {
                return object[property].apply(object, args);
            } else {
                args.push(arg);
                n--;
                return runner;
            }
        }

        return runner;
    };
}

exports.unsafeEffCall = function (method) {
    return function (argsCount) {
        return effectfulGetter(method, argsCount);
    };
};

exports.effProp = function (prop) {
    return function (object) {
        return function () {
            return object[prop];
        };
    };
}
