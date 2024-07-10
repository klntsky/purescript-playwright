/* global exports */

export const exposeBinding_ = x => name => cb => opts => () => {
  return x.exposeBinding(
    name,
    function (info, arg) {
      return cb(info)(arg)()
    },
    opts
  )
}
