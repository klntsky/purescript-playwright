/* global exports */

export const onForeign = (obj) => (eventName) => (effCallback) => () => {
  obj.on(eventName, (argument) => {
    effCallback(argument)();
  });
};
