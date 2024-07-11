/* global exports */

export const createReadStream_ = (Nothing) => (Just) => (Download) => () =>
  Download.createReadStream().then((result) => {
    if (result === null) {
      return Nothing;
    } else {
      return Just(result);
    }
  });
