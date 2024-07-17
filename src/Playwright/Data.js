/* global require exports */
import {
  chromium as pwChromium,
  firefox as pwFirefox,
  webkit as pwWebkit,
} from "playwright";

export const png = "png";
export const jpg = "jpg";

export const chromium = pwChromium;
export const firefox = pwFirefox;
export const webkit = pwWebkit;

export const domcontentloaded = "domcontentloaded";
export const load = "load";
export const networkidle = "networkidle";

export const alt = "Alt";
export const control = "Control";
export const meta = "Meta";
export const shift = "Shift";

const _null = null;
export { _null as null };

export const left = "left";
export const right = "right";
export const middle = "middle";

export const attached = "attached";
export const detached = "detached";
export const visible = "visible";
export const hidden = "hidden";

export const raf = "raf";

export const strict = "Strict";
export const lax = "Lax";
export const none = "None";
