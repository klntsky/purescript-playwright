/* global require exports */
var P = require('playwright');

exports.png = "png";
exports.jpg = "jpg";

exports.chromium = P.chromium;
exports.firefox = P.firefox;
exports.webkit = P.webkit;

exports.domcontentloaded = "domcontentloaded";
exports.load = "load";
exports.networkidle = "networkidle";
