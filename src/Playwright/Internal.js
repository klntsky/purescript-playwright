/* global exports */

/**
 * @param {string} property - method to call on object
 * @param {number} n - number of (curried) arguments
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
 function effectfulGetter (property, argsCount, effectRunnerWrapper) {
  const args = [];
  return object => {
      function effectRunner () {
          return object[property].apply(object, args);
      }

      const affectRunner = effectRunnerWrapper(effectRunner);

      function chooseNext () {
          return argsCount > 0 ? argsConsumer : affectRunner;
      }

      function argsConsumer (arg) {
          if (argsCount == 0) {
              return affectRunner;
          } else {
              args.push(arg);
              argsCount--;
              return chooseNext();
          }
      }

      return chooseNext();
  };
}

function identity (x) {
  return x;
}

export function unsafeEffCall(method) {
  return argsCount => effectfulGetter(method, argsCount, identity);
}

export function unsafeAffCall(toAffE) {
  return method => argsCount => effectfulGetter(method, argsCount, toAffE);
}

export function effProp(prop) {
  return object => () => object[prop];
}