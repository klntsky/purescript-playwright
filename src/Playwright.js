/* global require exports */

var P = require('playwright');

exports.chromium = P.chromium;
exports.firefox = P.firefox;
exports.webkit = P.webkit;
exports._launch = function (browser) {
    return function (opts) {
        return function () {
            return browser.launch(opts);
        };
    };
};

exports._close = function (browser) {
    return function () {
        return browser.close();
    };
};
