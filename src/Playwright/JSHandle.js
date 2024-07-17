/* global exports */

export function getProperties_(insert) {
  return (emptyMap) => (jsHandle) => () =>
    jsHandle.getProperties().then((props) => {
      let acc = emptyMap;
      props.entries().forEach((pair) => {
        acc = insert(pair[0])(pair[1])(acc);
      });
      return acc;
    });
}
