/* global require exports */

var P = require('playwright');

exports.chromium = P.chromium;
exports.firefox = P.firefox;
exports.webkit = P.webkit;

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
                return object[property].call(object, args);
            } else {
                args.push(arg);
                n--;
                return runner;
            }
        }

        return runner;
    };
}

exports._launch = effectfulGetter('launch', 1);
exports._close = effectfulGetter('close', 0);
exports.contexts = effectfulGetter('contexts', 0);
exports._newPage = effectfulGetter('newPage', 1);
