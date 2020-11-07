/* global exports */

exports.finished_ = function (Nothing) {
    return function (Just) {
        return function (Response) {
            return function () {
                return Response.finished().then(function (result) {
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
