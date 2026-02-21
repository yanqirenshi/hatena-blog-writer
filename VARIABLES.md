# VARIABLES

hatena-blog-writer で定義されているグローバル変数の一覧です。

## 変数一覧

| 変数 | 定義ファイル | 説明 |
|------|-------------|------|
| `*hatena-blog-writer-users*` | `src/variables.el` | はてなユーザーのリスト |
| `*hatena-blog-writer-blogs*` | `src/variables.el` | はてなユーザーのブログリスト |
| `*hatena-blog-writer-current-user*` | `src/variables.el` | 選択中のはてなユーザー |
| `*hatena-blog-writer-current-blog*` | `src/variables.el` | 選択中のはてなユーザーのブログ |
| `*hatena-blog-writer-request-default-callback-parser*` | `src/api/request.el` | request.el 用デフォルト XML パーサ |
| `*hatena-blog-writer-request-default-callback-success*` | `src/api/request.el` | request.el 用デフォルト成功コールバック |
| `*hatena-blog-writer-request-default-callback-error*` | `src/api/request.el` | request.el 用デフォルトエラーコールバック |
| `*hatena-blog-writer-request-default-callback-complete*` | `src/api/request.el` | request.el 用デフォルト完了コールバック |
| `*hatena-blog-writer-request-xml-template*` | `src/api/xml.el` | POST/PUT 用 XML テンプレート |
| `hbw--header-line-count` | `src/mode/major-buffer-fields.el` | ヘッダ部分の行数（定数） |

---

## アプリケーション状態変数

定義ファイル: `src/variables.el`

### *hatena-blog-writer-users*

```elisp
(defvar *hatena-blog-writer-users* nil)
```

- **型**: `list` of `hbw-user` or `nil`
- **初期値**: `nil`
- **説明**: 登録されたはてなユーザーのリスト。`hatena-blog-writer-load-users` で `~/.hatena/blog/config/users.lisp` から読み込まれる。
- **更新元**: `hatena-blog-writer-load-users`, `hatena-blog-writer-add-user`
- **参照元**: `hatena-blog-writer-get-user`, `hatena-blog-writer-save-users`

### *hatena-blog-writer-blogs*

```elisp
(defvar *hatena-blog-writer-blogs* nil)
```

- **型**: `list` of `hbw-blog` or `nil`
- **初期値**: `nil`
- **説明**: はてなユーザーのブログリスト。`hatena-blog-writer-load-blogs` で `~/.hatena/blog/config/blogs.lisp` から読み込まれる。
- **更新元**: `hatena-blog-writer-load-blogs`, `hatena-blog-writer-add-blog`
- **参照元**: `hatena-blog-writer-get-blog`, `hatena-blog-writer-save-blogs`

### *hatena-blog-writer-current-user*

```elisp
(defvar *hatena-blog-writer-current-user* nil)
```

- **型**: `hbw-user` or `nil`
- **初期値**: `nil`
- **説明**: 現在選択されているはてなユーザー。`hatena-blog-writer-change-user` で切り替える。
- **更新元**: `hatena-blog-writer-change-user`
- **参照元**: `hatena-blog-writer.entry.fetch.all`, `hatena-blog-writer-ensure-major-mode-buffer-name`, メジャーモードバッファ描画関数群

### *hatena-blog-writer-current-blog*

```elisp
(defvar *hatena-blog-writer-current-blog* nil)
```

- **型**: `hbw-blog` or `nil`
- **初期値**: `nil`
- **説明**: 現在選択されているはてなユーザーのブログ。`hatena-blog-writer-change-blog` で切り替える。
- **更新元**: `hatena-blog-writer-change-blog`
- **参照元**: `hatena-blog-writer.entry.fetch.all`, メジャーモードバッファ描画関数群

---

## API デフォルトコールバック変数

定義ファイル: `src/api/request.el`

### *hatena-blog-writer-request-default-callback-parser*

```elisp
(defvar *hatena-blog-writer-request-default-callback-parser*
  (lambda ()
    (hatena-blog-writer-cleanup-xml
     (xml-parse-region (point) (point-max)))))
```

- **型**: `function`
- **説明**: request.el の `:parser` パラメータに渡されるデフォルトのパーサ関数。レスポンスボディを `xml-parse-region` でパースし、`hatena-blog-writer-cleanup-xml` で空白テキストノードを除去する。
- **参照元**: `hatena-blog-writer-request-get-func`, `hatena-blog-writer-api-entry-post`, `%hatena-blog-writer-api-entry-put`

### *hatena-blog-writer-request-default-callback-success*

```elisp
(defvar *hatena-blog-writer-request-default-callback-success*
  (cl-function
   (lambda (&key data &allow-other-keys)
     (message "Succsess!"))))
```

- **型**: `function`
- **説明**: request.el の `:success` パラメータに渡されるデフォルトの成功コールバック。`"Succsess!"` をメッセージ表示する。
- **参照元**: `hatena-blog-writer-request-get-func`

### *hatena-blog-writer-request-default-callback-error*

```elisp
(defvar *hatena-blog-writer-request-default-callback-error*
  (cl-function
   (lambda (&rest args &key error-thrown &allow-other-keys)
     (message "Got error: %S" error-thrown))))
```

- **型**: `function`
- **説明**: request.el の `:error` パラメータに渡されるデフォルトのエラーコールバック。エラー内容をメッセージ表示する。
- **参照元**: `hatena-blog-writer-request-get-func`

### *hatena-blog-writer-request-default-callback-complete*

```elisp
(defvar *hatena-blog-writer-request-default-callback-complete*
  (lambda (&rest _)
    (message "Finished!")))
```

- **型**: `function`
- **説明**: request.el の `:complete` パラメータに渡されるデフォルトの完了コールバック。`"Finished!"` をメッセージ表示する。
- **参照元**: `hatena-blog-writer-request-get-func`

---

## XML テンプレート定数

定義ファイル: `src/api/xml.el`

### *hatena-blog-writer-request-xml-template*

```elisp
(defconst *hatena-blog-writer-request-xml-template*
  "<?xml version='1.0' encoding='utf-8'?>
<entry xmlns='http://www.w3.org/2005/Atom'
       xmlns:app='http://www.w3.org/2007/app'>
  <title>%s</title>
  <author><name>%s</name></author>
  <content type='text/plain'>%s</content>
  <updated>%s</updated>
  %s
  <app:control>
    <app:draft>%s</app:draft>
  </app:control>
</entry>")
```

- **型**: `string`（定数）
- **説明**: POST/PUT リクエスト用の Atom XML テンプレート。`format` の書式文字列として使用する。

プレースホルダ（`%s`）の順序:

| 順序 | 内容 | 例 |
|------|------|-----|
| 1 | タイトル | `"記事のタイトル"` |
| 2 | 著者名（はてなID） | `"yanqirenshi"` |
| 3 | 本文 | `"記事の本文"` |
| 4 | 更新日時（ISO 8601） | `"2024-01-15T12:00:00"` |
| 5 | カテゴリタグ（XML 文字列） | `"<category term=\"Emacs\" />"` |
| 6 | 下書き状態 | `"yes"` or `"no"` |

- **参照元**: `hatena-blog-writer-build-post-xml`, `hatena-blog-writer-build-put-xml`

---

## メジャーモード描画定数

定義ファイル: `src/mode/major-buffer-fields.el`

### hbw--header-line-count

```elisp
(defconst hbw--header-line-count 7)
```

- **型**: `integer`（定数）
- **値**: `7`
- **説明**: ヘッダ部分の行数。エントリー一覧はこの行の次から始まる。`hbw--goto-first-entry` でカーソルを最初のエントリー行に移動する際に使用する。
- **参照元**: `hbw--goto-first-entry`
