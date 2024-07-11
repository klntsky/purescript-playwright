/* global exports */

/**
 * @param {string} property - method to call on object
 * @param {number} argsCount - number of (curried) arguments
 * @param {effectRunnerWrapper} effectRunnerWrapper - a function to overrride
 * effect runner with. `toAffE` for `Aff`, `identity` for `Effect`.
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
 * effectfulGetter('close', 0, identity);
 */
function effectfulGetter(property, argsCount, effectRunnerWrapper) {
  function consume(arg, args, counter) {
    const argsNew = [...args, arg];

    if (counter === 0) {
      const [object, ...rest] = argsNew;

      return effectRunnerWrapper(() => object[property].apply(object, rest));
    } else {
      return (a) => consume(a, argsNew, counter - 1);
    }
  }

  return (object) => consume(object, [], argsCount);
}

function identity(x) {
  return x;
}

export function unsafeEffCall(method) {
  return (argsCount) => effectfulGetter(method, argsCount, identity);
}

export function unsafeAffCall(toAffE) {
  return (method) => (argsCount) => effectfulGetter(method, argsCount, toAffE);
}

export function effProp(prop) {
  return (object) => () => object[prop];
}
