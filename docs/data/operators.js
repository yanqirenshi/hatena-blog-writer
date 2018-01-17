var _OPERATORS = [
    {
        symbol: 'hatena-blog-writer-make-user',
        type: 'function',
        description: 'ユーザーを作成します。',
        file: 'user.el'
    }
    , {
        symbol: 'hatena-blog-writer-user-p',
        type: 'function',
        description: 'データがユーザーかどうかを返します。',
        file: 'user.el'
    }
    , {
        symbol: 'hatena-blog-writer-set-user',
        type: 'function',
        description: 'ユーザーを *hatena-blog-writer-user* にセットします。',
        file: 'user.el'
    }
    /* ****************************************************************
       blog.el
       **************************************************************** */
    , {
        symbol: 'hatena-blog-writer-make-blog',
        type: 'function',
        description: '',
        file: 'blog.el'
    }
    , {
        symbol: 'hatena-blog-writer-blog-p',
        type: 'function',
        description: '',
        file: 'blog.el'
    }
    , {
        symbol: 'hatena-blog-writer-get-blog',
        type: 'function',
        description: '',
        file: 'blog.el'
    }
    , {
        symbol: 'hatena-blog-writer-add-blog',
        type: 'function',
        description: 'ブログを *hatena-blog-writer-blogs* に追加する。既に存在する場合はエラーとなる。',
        file: 'blog.el'
    }
    /* ****************************************************************
       entry.el
       **************************************************************** */
    , {
        symbol: 'hatena-blog-writer-make-entry',
        type: 'function',
        description: '',
        file: 'entry.el'
    }
    , {
        symbol: 'hatena-blog-writer-entry-p',
        type: 'function',
        description: '',
        file: 'entry.el'
    }
    , {
        symbol: 'hatena-blog-writer-api-entry-get',
        type: 'function',
        description: '',
        file: 'entry.el'
    }
    /* ****************************************************************
       api.el
       **************************************************************** */
    , {
        symbol: 'hatena-blog-writer-api-root-uri',
        type: 'function',
        description: 'はてなブログ AtomPub のルートの URI を返す',
        file: 'api.el'
    }
    , {
        symbol: 'hatena-blog-writer-api-entry-uri',
        type: 'function',
        description: 'はてなブログ AtomPub の Entry の URI を返す',
        file: 'api.el'
    }
    , {
        symbol: 'hatena-blog-writer-api-category-uri',
        type: 'function',
        description: 'はてなブログ AtomPub の カテゴリ の URI を返す',
        file: 'api.el'
    }
    , {
        symbol: 'hatena-blog-writer-request-header-auth',
        type: 'function',
        description: 'はてなブログ AtomPub の Basic認証 のためのヘッダ: Authorization の値を返す',
        file: 'api.el'
    }
    , {
        symbol: 'hatena-blog-writer-request-headers',
        type: 'function',
        description: 'はてなブログ AtomPub にリクエストを投げるためのヘッダを返す',
        file: 'api.el'
    }
    , {
        symbol: 'hatena-blog-writer-request-method2type',
        type: 'function',
        description: 'method (keyword) を request.el の type (string) に変換する',
        file: 'api.el'
    }
    , {
        symbol: 'hatena-blog-writer-request-get-func',
        type: 'function',
        description: 'request のコールバック関数を返す',
        file: 'api.el'
    }
    , {
        symbol: 'hatena-blog-writer-request',
        type: 'function',
        description: 'hatena-blog-writer の request ユーティリティ関数',
        file: 'api.el'
    }
    /* ****************************************************************
       filer.el
       **************************************************************** */
    , {
        symbol: 'hatena-blog-writer-ensure-dir-hatena',
        type: 'function',
        description: '',
        file: 'filer.el'
    }
    , {
        symbol: 'hatena-blog-writer-ensure-dir-hatena-blog',
        type: 'function',
        description: '',
        file: 'filer.el'
    }
    , {
        symbol: 'hatena-blog-writer-ensure-dir-hatena-blog-user',
        type: 'function',
        description: '',
        file: 'filer.el'
    }
    , {
        symbol: 'hatena-blog-writer-ensure-dir-hatena-blog-blog',
        type: 'function',
        description: '',
        file: 'filer.el'
    }
    , {
        symbol: 'hatena-blog-writer-ensure-dir-state-keyword2str',
        type: 'function',
        description: '',
        file: 'filer.el'
    }
    , {
        symbol: 'hatena-blog-writer-ensure-dir-hatena-blog-entry',
        type: 'function',
        description: '',
        file: 'filer.el'
    }
    /* ****************************************************************
       entry/api-entry-find.el
       **************************************************************** */
    , {
        symbol: '%hatena-blog-writer-api-entry-find',
        type: 'function',
        description: 'hatena-blog-writer-api-entry-find からコールされる関数です。',
        file: 'entry/api-entry-find.el'
    }
    , {
        symbol: 'hatena-blog-writer-api-entry-find-success',
        type: 'function',
        description: 'hatena-blog-writer-api-entry-find の success 関数',
        file: 'entry/api-entry-find.el'
    }
    , {
        symbol: 'hatena-blog-writer-api-entry-find',
        type: 'function',
        description: '複数の entry を取得します。get との違いは検索条件を指定できるところです。\n(今はできないけど)',
        file: 'entry/api-entry-find.el'
    }
    /* ****************************************************************
       entry/api-entry-get.el
       **************************************************************** */
    , {
        symbol: '%hatena-blog-writer-api-entry-get',
        type: 'function',
        description: 'hatena-blog-writer-api-entry-get からコールされる関数です。',
        file: 'entry/api-entry-get.el'
    }
    , {
        symbol: 'hatena-blog-writer-api-entry-get-success',
        type: 'function',
        description: 'hatena-blog-writer-api-entry-get のコールバック(success) 関数',
        file: 'entry/api-entry-get.el'
    }
    , {
        symbol: 'hatena-blog-writer-api-entry-get',
        type: 'entry-id のエントリを取得します。',
        description: '',
        file: 'entry/api-entry-get.el'
    }
    /* ****************************************************************
       entry/api-entry-post.el
       **************************************************************** */
    , {
        symbol: 'hatena-blog-writer-build-post-xml',
        type: 'function',
        description: '',
        file: 'entry/api-entry-post.el'
    }
    , {
        symbol: 'hatena-blog-writer-api-entry-post-success',
        type: 'function',
        description: '',
        file: 'entry/api-entry-post.el'
    }
    , {
        symbol: 'hatena-blog-writer-api-entry-post-error',
        type: 'function',
        description: '',
        file: 'entry/api-entry-post.el'
    }
    , {
        symbol: 'hatena-blog-writer-api-entry-post',
        type: 'function',
        description: '',
        file: 'entry/api-entry-post.el'
    }
    /* ****************************************************************
       entry/api-entry-put.el
       **************************************************************** */
    , {
        symbol: 'hatena-blog-writer-build-master-find-tags',
        type: 'function',
        description: '',
        file: 'entry/api-entry-put.el'
    }
    , {
        symbol: 'hatena-blog-writer-build-master-get-draft',
        type: 'function',
        description: '',
        file: 'entry/api-entry-put.el'
    }
    , {
        symbol: 'hatena-blog-writer-build-put-build-tags-xml',
        type: 'function',
        description: '',
        file: 'entry/api-entry-put.el'
    }
    , {
        symbol: 'hatena-blog-writer-build-put-xml',
        type: 'function',
        description: '',
        file: 'entry/api-entry-put.el'
    }
    , {
        symbol: 'hatena-blog-writer-api-entry-put-success',
        type: 'function',
        description: '',
        file: 'entry/api-entry-put.el'
    }
    , {
        symbol: '%hatena-blog-writer-api-entry-put',
        type: 'function',
        description: '',
        file: 'entry/api-entry-put.el'
    }
    , {
        symbol: 'hatena-blog-writer-api-entry-put',
        type: 'function',
        description: '',
        file: 'entry/api-entry-put.el'
    }
    /* ****************************************************************
       entry/util.el
       **************************************************************** */
    , {
        symbol: 'hatena-blog-writer-make-entry',
        type: 'function',
        description: '',
        file: 'entry/util.el'
    }
    , {
        symbol: 'hatena-blog-writer-entry-p',
        type: 'function',
        description: '',
        file: 'entry/util.el'
    }
    , {
        symbol: 'hatena-blog-writer-entry-get-val',
        type: 'function',
        description: 'entry の uri を返します。',
        file: 'entry/util.el'
    }
    , {
        symbol: 'hatena-blog-writer-entry-get-uri',
        type: 'function',
        description: 'entry の uri を返します。',
        file: 'entry/util.el'
    }
    , {
        symbol: 'hatena-blog-writer-entry-get-id',
        type: 'function',
        description: 'entry の id を返します。',
        file: 'entry/util.el'
    }
    , {
        symbol: 'hatena-blog-writer-entry-get-title',
        type: 'function',
        description: 'entry の title を返します。',
        file: 'entry/util.el'
    }
    , {
        symbol: 'hatena-blog-writer-entry-get-status',
        type: 'function',
        description: '',
        file: 'entry/util.el'
    }
    , {
        symbol: 'hatena-blog-writer-api-entry-get-parse-uri',
        type: 'function',
        description: '',
        file: 'entry/util.el'
    }
    , {
        symbol: 'hatena-blog-writer-api-entry-get-parse-uri2',
        type: 'function',
        description: '',
        file: 'entry/util.el'
    }
];
/*
    , {
        symbol: '',
        type: '',
        description: '',
        file: ''
    }
*/
