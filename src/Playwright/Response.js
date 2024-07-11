/* global exports */

export const finished_ = (Nothing) => (Just) => (Response) => () =>
  Response.finished().then((result) => {
    if (result === null) {
      return Nothing;
    } else {
      return Just(result);
    }
  });
