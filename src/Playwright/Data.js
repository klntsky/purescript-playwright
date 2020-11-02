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

exports.alt = "Alt";
exports.control = "Control";
exports.meta = "Meta";
exports.shift = "Shift";

exports.null = null;

exports.left = "left";
exports.right = "right";
exports.middle = "middle";

exports.attached = "attached";
exports.detached = "detached";
exports.visible = "visible";
exports.hidden = "hidden";

exports.raf = "raf";
