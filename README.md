# hatena-blog-mode

[Hatena Blog API](http://developer.hatena.ne.jp/ja/documents/blog/apis/atom) Library for Emacs

## インストール
Put this package in your load-path-dir.

## 使い方

### 設定
以下の内容を `~/.emacs.d/init.el` とかに追加してください。

```lisp
(require 'hatena-blog-mode)
(hatena-blog-add-blog "{your hatena blog id}"
                      "{your hatena blog name}"
                      "{your hatena id}"
                      "[your hatena blog pai key}")
(hatena-blog-change-blog "{your hatena blog id}")
```

### ブログの変更
`M-x hatena-blog-change-blog {your hatena blog id}`

### ブログ記事の書き方

0. `M-x hatena-blog-write`
0. write your entry
0. `M-x hatena-blog-post`

### Hatena API と オペレータ

base path: /{はてなID}/{ブログID}/atom

| command                  | action                   | API                      |
|--------------------------|--------------------------|--------------------------|
| ???                      | サービス文書の取得       | GET /                    |
| hatena-blog-gets         | ブログエントリの一覧取得 | GET /entry               |
| hatena-blog-get          | ブログエントリの取得     | GET /entry/{entry_id}    |
| hatena-blog-post         | ブログエントリの投稿     | POST /entry              |
| hatena-blog-put          | ブログエントリの編集     | PUT /entry/{entry_id}    |
| hatena-blog-delete       | ブログエントリの削除     | DELETE /entry/{entry_id} |
| hatena-blog-category-get | カテゴリ文書の取得       | GET /category            |

## インスパイヤ

- http://ichiroc.hatenablog.com/entry/2013/12/16/235806
- https://github.com/takaishi/ya-hatena-mode
- https://gist.github.com/tarao/4465244

## ライセンス
MIT License
