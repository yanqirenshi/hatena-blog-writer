# API

hatena-blog-writer で定義されている API 関連の関数・変数の一覧です。

## ファイル構成

| ファイル | 役割 |
|----------|------|
| `src/api/uri.el` | API エンドポイント URI の生成 |
| `src/api/header.el` | Basic 認証ヘッダの生成 |
| `src/api/request.el` | request.el ラッパーとデフォルトコールバック |
| `src/api/result.el` | API レスポンス結果の取得 |
| `src/api/response.el` | XML レスポンスからフィード・エントリーの抽出 |
| `src/api/xml.el` | XML クリーンアップ、リクエスト XML テンプレート |
| `src/entry/entry-xml.el` | XML → `hbw-entry` オブジェクト変換 |
| `src/entry/api-entry-get.el` | 単一エントリー取得 (GET) |
| `src/entry/api-entry-find.el` | 複数エントリー取得 (GET、ページネーション) |
| `src/entry/api-entry-post.el` | エントリー新規投稿 (POST) |
| `src/entry/api-entry-put.el` | エントリー更新 (PUT) |

---

## エンドポイントと URI

定義ファイル: `src/api/uri.el`

### hatena-blog-writer-api-root-uri

```
hatena-blog-writer-api-root-uri (hatena-id hatena-blog-id) => string
```

はてなブログ AtomPub のルート URI を返す。

```elisp
(hatena-blog-writer-api-root-uri "yanqirenshi" "example.hatenablog.com")
;; => "https://blog.hatena.ne.jp/yanqirenshi/example.hatenablog.com/atom"
```

### hatena-blog-writer-api-entry-uri

```
hatena-blog-writer-api-entry-uri (id-or-user id-or-blog &optional entry_id) => string
```

はてなブログ AtomPub の Entry URI を返す。引数は文字列または EIEIO オブジェクト（`hbw-user` / `hbw-blog`）を受け付ける。

```elisp
;; 文字列で指定
(hatena-blog-writer-api-entry-uri "yanqirenshi" "example.hatenablog.com")
;; => "https://blog.hatena.ne.jp/yanqirenshi/example.hatenablog.com/atom/entry"

;; EIEIO オブジェクトで指定
(hatena-blog-writer-api-entry-uri user blog "10328749687211177806")
;; => "https://blog.hatena.ne.jp/yanqirenshi/example.hatenablog.com/atom/entry/10328749687211177806"
```

### hatena-blog-writer-api-category-uri

```
hatena-blog-writer-api-category-uri (hatena-id hatena-blog-id) => string
```

はてなブログ AtomPub のカテゴリ URI を返す。

```elisp
(hatena-blog-writer-api-category-uri "yanqirenshi" "example.hatenablog.com")
;; => "https://blog.hatena.ne.jp/yanqirenshi/example.hatenablog.com/atom/category"
```

---

## 認証ヘッダ

定義ファイル: `src/api/header.el`

### hatena-blog-writer-request-header-auth

```
hatena-blog-writer-request-header-auth (hatena-id hatena-blog-api-key) => string
```

Basic 認証の `Authorization` ヘッダ値を返す。`hatena-id:api-key` を Base64 エンコードする。

```elisp
(hatena-blog-writer-request-header-auth "yanqirenshi" "your-api-key")
;; => "Basic eWFucWlyZW5zaGk6eW91ci1hcGkta2V5"
```

### hatena-blog-writer-request-headers

```
hatena-blog-writer-request-headers (id-or-user api-key-or-blog) => alist
```

リクエストヘッダの alist を返す。引数は文字列または EIEIO オブジェクト（`hbw-user` / `hbw-blog`）を受け付ける。

```elisp
(hatena-blog-writer-request-headers user blog)
;; => (("Content-Type" . "application/x-www-form-urlencoded")
;;     ("Authorization" . "Basic ..."))
```

---

## リクエスト

定義ファイル: `src/api/request.el`

### デフォルトコールバック変数

| 変数 | 型 | 説明 |
|------|------|------|
| `*hatena-blog-writer-request-default-callback-parser*` | `function` | XML パース関数。`xml-parse-region` + `hatena-blog-writer-cleanup-xml` |
| `*hatena-blog-writer-request-default-callback-success*` | `function` | 成功時コールバック。`"Succsess!"` をメッセージ表示 |
| `*hatena-blog-writer-request-default-callback-error*` | `function` | エラー時コールバック。エラー内容をメッセージ表示 |
| `*hatena-blog-writer-request-default-callback-complete*` | `function` | 完了時コールバック。`"Finished!"` をメッセージ表示 |

### hatena-blog-writer-request-get-func

```
hatena-blog-writer-request-get-func (funcs type) => function
```

コールバック関数を返す。`funcs` plist に指定されたコールバックがあればそれを返し、なければデフォルトコールバックを返す。

`type` は以下のいずれか:
- `:parser` — XML パーサ
- `:success` — 成功時コールバック
- `:error` — エラー時コールバック
- `:complete` — 完了時コールバック

```elisp
(hatena-blog-writer-request-get-func '(:success my-callback) :success)
;; => my-callback

(hatena-blog-writer-request-get-func nil :success)
;; => *hatena-blog-writer-request-default-callback-success*
```

### hatena-blog-writer-request-method2type

```
hatena-blog-writer-request-method2type (method) => string
```

メソッドキーワードを request.el の type 文字列に変換する。

| method | 戻り値 |
|--------|--------|
| `:get` | `"GET"` |
| `:post` | `"POST"` |
| `:put` | `"PUT"` |

### hatena-blog-writer-request

```
hatena-blog-writer-request (method uri hatena-id hatena-blog-id hatena-blog-api-key funcs &optional entry-id next-page) => request-response
```

hatena-blog-writer の汎用リクエスト関数。request.el のラッパー。

| 引数 | 型 | 説明 |
|------|------|------|
| `method` | keyword | `:get`, `:post`, `:put` |
| `uri` | string | リクエスト先 URI |
| `hatena-id` | string | はてなID |
| `hatena-blog-id` | string | ブログID |
| `hatena-blog-api-key` | string | API キー |
| `funcs` | plist | コールバック関数の plist (`:parser`, `:success`, `:error`, `:complete`) |
| `entry-id` | string or nil | エントリーID（未使用） |
| `next-page` | string or nil | 次ページ番号（未使用） |

---

## レスポンス処理

### result

定義ファイル: `src/api/result.el`

#### hatena-blog-writer.api.result.response

```
hatena-blog-writer.api.result.response (result) => list
```

API の success コールバックが受け取る result plist から `:data`（XML パース済みデータ）を取り出す。

```elisp
(hatena-blog-writer.api.result.response result)
;; => ((feed ATTRS CHILDREN...) ...)
```

### response

定義ファイル: `src/api/response.el`

#### hatena-blog-writer.api.response.feeds

```
hatena-blog-writer.api.response.feeds (response) => list
```

レスポンスから `feed` 要素のリストを返す。

#### hatena-blog-writer.api.response.feed.entries

```
hatena-blog-writer.api.response.feed.entries (feed) => list
```

1つの `feed` 要素からその中の `entry` 要素のリストを返す。

#### hatena-blog-writer.api.response.feeds.entries

```
hatena-blog-writer.api.response.feeds.entries (feeds) => list
```

複数の `feed` 要素から全 `entry` 要素をフラットなリストで返す。

#### hatena-blog-writer.api.response.entries

```
hatena-blog-writer.api.response.entries (response) => list
```

レスポンスから全 `entry` 要素をフラットなリストで返す。`feeds` → `feeds.entries` の組み合わせ。

```elisp
(hatena-blog-writer.api.response.entries response)
;; => ((entry ATTRS CHILDREN...) (entry ATTRS CHILDREN...) ...)
```

---

## XML 処理

定義ファイル: `src/api/xml.el`

### hatena-blog-writer-cleanup-xml

```
hatena-blog-writer-cleanup-xml (xml) => list
```

`xml-parse-region` の出力から空白のみのテキストノードを除去する。API レスポンスの XML パース時に自動的に呼ばれる。

### hatena-blog-writer-cleanup-xml-element

```
hatena-blog-writer-cleanup-xml-element (element) => list
```

1つの XML 要素を再帰的にクリーンアップする。

### hatena-blog-writer-cleanup-xml-del-p

```
hatena-blog-writer-cleanup-xml-del-p (d) => boolean
```

削除対象の要素かどうかを判定する。文字列かつ `s-trim` 後に空文字列ならば `t`。

### *hatena-blog-writer-request-xml-template*

```elisp
(defconst *hatena-blog-writer-request-xml-template* ...)
```

POST/PUT リクエスト用の XML テンプレート（`format` の書式文字列）。

プレースホルダ（`%s`）の順序:

| 順序 | 内容 |
|------|------|
| 1 | タイトル |
| 2 | 著者名（はてなID） |
| 3 | 本文 |
| 4 | 更新日時（ISO 8601） |
| 5 | カテゴリタグ（XML 文字列） |
| 6 | 下書き状態（`"yes"` or `"no"`） |

### hatena-blog-writer-request-xml-build-tags

```
hatena-blog-writer-request-xml-build-tags (tags) => string
```

カテゴリ文字列のリストから `<category term="..." />` タグの連結文字列を返す。

```elisp
(hatena-blog-writer-request-xml-build-tags '("Emacs" "Lisp"))
;; => "<category term=\"Emacs\" /><category term=\"Lisp\" />"
```

---

## XML → hbw-entry 変換

定義ファイル: `src/entry/entry-xml.el`

### hbw-entry-from-xml

```
hbw-entry-from-xml (xml-entry) => hbw-entry
```

XML entry ノード `(entry ATTRS CHILDREN...)` から `hbw-entry` オブジェクトを生成する。

内部で以下のヘルパー関数を使用:

| 関数 | シグネチャ | 説明 |
|------|-----------|------|
| `hbw--xml-child-text` | `(children key) => string or nil` | 子要素のテキストを返す |
| `hbw--xml-find-link` | `(children rel) => string or nil` | `link` 要素から `rel` 属性一致の `href` を返す |
| `hbw--xml-author-name` | `(children) => string or nil` | `author > name` のテキストを返す |
| `hbw--xml-categories` | `(children) => list` | 全 `category` 要素の `term` をリストで返す |
| `hbw--xml-draft-p` | `(children) => boolean` | `app:control > app:draft` が `"yes"` なら `t` |
| `hbw--xml-parse-uri-params` | `(uri) => plist` | URI から `:hatena-id`, `:hatena-blog-id`, `:hatena-blog-entry-id` を抽出 |

```elisp
(hbw-entry-from-xml xml-entry)
;; => #s(hbw-entry "10328749687211177806" "https://..." ...)
```

---

## エントリー操作 API

### GET — 単一エントリー取得

定義ファイル: `src/entry/api-entry-get.el`

#### hatena-blog-writer-api-entry-get

```
hatena-blog-writer-api-entry-get (user blog entry-id &rest key-params) => request-response
```

単一エントリーを取得する。key-params:

| キー | 型 | 説明 |
|------|------|------|
| `:update` | symbol | `:all`, `:master`, `:contents` のいずれか。保存対象を指定 |
| `:callback` | function or nil | 取得完了後に呼ばれるコールバック |

```elisp
;; master のみ更新
(hatena-blog-writer-api-entry-get user blog "10328749687211177806"
                                   :update :master)

;; 完了後にコールバック実行
(hatena-blog-writer-api-entry-get user blog entry-id
                                   :update :master
                                   :callback (lambda () (message "Done!")))
```

#### hatena-blog-writer-api-entry-get-success

```
hatena-blog-writer-api-entry-get-success (response update) => void
```

GET 成功時の内部コールバック。XML レスポンスを `hbw-entry-from-xml` で変換し、`update` パラメータに応じて master / contents を保存する。

### GET — 複数エントリー取得

定義ファイル: `src/entry/api-entry-find.el`

#### hatena-blog-writer.api.entry.find

```
hatena-blog-writer.api.entry.find (user blog &optional next-page) => request-response
```

エントリーを複数取得する。フィードの全エントリーに対して `hbw-entry-from-xml` で変換し、master と contents の両方を保存する。

```elisp
(hatena-blog-writer.api.entry.find user blog)
```

#### hatena-blog-writer.entry.fetch.all

```
hatena-blog-writer.entry.fetch.all () => void  [interactive]
```

現在選択中のユーザー・ブログの全エントリーを取得する。`*hatena-blog-writer-current-user*` と `*hatena-blog-writer-current-blog*` を使用する。

#### hatena-blog-writer.find-next-page-no

```
hatena-blog-writer.find-next-page-no (xml-lists) => string or nil
```

フィード内の `link[rel="next"]` から次ページ番号を取り出す。

```elisp
(hatena-blog-writer.find-next-page-no xml-lists)
;; => "1704024489" or nil
```

### POST — 新規投稿

定義ファイル: `src/entry/api-entry-post.el`

#### hatena-blog-writer-api-entry-post

```
hatena-blog-writer-api-entry-post (user blog xml) => request-response
```

エントリーを新規投稿する。成功時は `hbw-entry-from-xml` で変換し、master と contents を保存する。

```elisp
(let ((xml (hatena-blog-writer-build-post-xml user "タイトル" "本文" '("Emacs") "no")))
  (hatena-blog-writer-api-entry-post user blog xml))
```

#### hatena-blog-writer-build-post-xml

```
hatena-blog-writer-build-post-xml (user title contents categories draft) => string
```

POST 用の XML を構築する。

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user | ユーザーオブジェクト |
| `title` | string | タイトル |
| `contents` | string | 本文 |
| `categories` | list | カテゴリ文字列のリスト |
| `draft` | string | `"yes"` or `"no"` |

### PUT — エントリー更新

定義ファイル: `src/entry/api-entry-put.el`

#### hatena-blog-writer-api-entry-put

```
hatena-blog-writer-api-entry-put (user blog entry-id) => void
```

`contents.md` の内容をサーバーに PUT する。最新の master を GET で取得した後、title と content のみを変更して PUT する。

処理フロー:
1. `hatena-blog-writer-api-entry-get` で最新 master を取得
2. `hatena-blog-writer-build-put-xml` で XML を構築
3. PUT リクエストを送信
4. 成功時に master と contents を保存

```elisp
(hatena-blog-writer-api-entry-put user blog "10328749687211177806")
```

#### hatena-blog-writer-build-put-xml

```
hatena-blog-writer-build-put-xml (user blog entry-id) => string
```

PUT 用の XML を構築する。`contents.md` からタイトルと本文を読み込み、master から既存メタデータ（カテゴリ、下書き状態）を取得してマージする。

---

## グローバル変数

定義ファイル: `src/variables.el`

| 変数 | 型 | 説明 |
|------|------|------|
| `*hatena-blog-writer-users*` | list or nil | 登録されたはてなユーザーのリスト |
| `*hatena-blog-writer-blogs*` | list or nil | はてなユーザーのブログリスト |
| `*hatena-blog-writer-current-user*` | hbw-user or nil | 現在選択中のユーザー |
| `*hatena-blog-writer-current-blog*` | hbw-blog or nil | 現在選択中のブログ |

---

## データフロー

### 取得 (GET) フロー

```
API Request
    ↓
XML Response (Atom XML)
    ↓
xml-parse-region + hatena-blog-writer-cleanup-xml
    ↓
パース済み XML ノード (Emacs Lisp のリスト構造)
    ↓
hatena-blog-writer.api.response.entries (フィードからエントリー抽出)
    ↓
hbw-entry-from-xml (XML → hbw-entry 変換)
    ↓
hatena-blog-writer.entry.save.master / .save.contents (永続化)
```

### 投稿 (POST) / 更新 (PUT) フロー

```
hatena-blog-writer-build-post-xml / hatena-blog-writer-build-put-xml
    ↓
*hatena-blog-writer-request-xml-template* に format で埋め込み
    ↓
encode-coding-string で UTF-8 エンコード
    ↓
request.el で POST/PUT 送信
    ↓
成功時: hbw-entry-from-xml で hbw-entry に変換
    ↓
hatena-blog-writer.entry.save.master / .save.contents (永続化)
```

### 認証フロー

```
hbw-user (はてなID) + hbw-blog (API キー)
    ↓
hatena-blog-writer-request-header-auth (Base64 エンコード)
    ↓
hatena-blog-writer-request-headers (alist 生成)
    ↓
request.el の :headers パラメータ
```
