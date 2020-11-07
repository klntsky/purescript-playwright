/* global exports */

exports.createReadStream_ = function (Nothing) {
    return function (Just) {
        return function (Download) {
            return function () {
                return Download.createReadStream().then(function (result) {
                    if (result === null) {
                        return Nothing;
                    } else {
                        return Just(result);
                    }
                });
            };
        };
    };
};
