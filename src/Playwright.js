/* global exports */

export const exposeBinding_ = (x) => (name) => (cb) => (opts) => () => {
  return x.exposeBinding(
    name,
    function (info, arg) {
      return cb(info)(arg)();
    },
    opts,
  );
};

export const onResponse = function (page) {
  return function (cb) {
    return function () {
      page.on("response", function (response) {
        cb(response)();
      });
    };
  };
};
