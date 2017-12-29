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
];
/*
    , {
        symbol: '',
        type: '',
        description: '',
        file: ''
    }
*/
