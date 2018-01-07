var L = new LISP ();

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
    , variables: _VARIABLES
    , commands: _COMMANDS
    , tabs: [
        {code:'readme', name: '概要'},
        {code:'usage', name: '使い方'},
        {code:'major-mode', name: 'メジャーモード'},
        {code:'minor-mode', name: 'マイナーモード'},
        {code:'data-structures', name: 'データ構成'},
        {code:'directory-structure', name: 'ディレクトリ構成'},
        {code:'symbols', name: 'シンボル一覧'}
    ]
});

/// riot
riot.mount('*');
