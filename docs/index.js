/// router
route(function(collection, id, action) {
    STORE.dispatch(ACTIONS.movePage({
        contents: collection
    }));
});
route.start();

/// redux
var ACTIONS = new Actions();
var REDUCER = new Reducer();
var STORE = new Simple_Redux_Store (REDUCER, {
    contents: (function () {
        if (location.hash=='')
            return 'readme';
        var len = location.hash.length;
        return location.hash.substring(1,len);
    }())
    , operators: _OPERATORS
});

/// riot
riot.mount('*');
