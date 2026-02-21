# OPERATORS

hatena-blog-writer で定義されている関数の一覧です。

## 関数一覧

### ユーザー管理

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hatena-blog-writer-make-user` | `src/user.el` | hbw-user オブジェクトを生成 |
| `hatena-blog-writer-user-p` | `src/user.el` | hbw-user オブジェクトか判定 |
| `hatena-blog-writer-get-user` | `src/user.el` | ID でユーザーを検索 |
| `hatena-blog-writer-add-user` | `src/user.el` | ユーザーを追加 |
| `hatena-blog-writer-change-user` | `src/user.el` | 選択中のユーザーを切り替え |

### ブログ管理

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hatena-blog-writer-make-blog` | `src/blog.el` | hbw-blog オブジェクトを生成 |
| `hatena-blog-writer-blog-p` | `src/blog.el` | hbw-blog オブジェクトか判定 |
| `hatena-blog-writer-get-blog` | `src/blog.el` | ID でブログを検索 |
| `hatena-blog-writer-add-blog` | `src/blog.el` | ブログを追加 |
| `hatena-blog-writer-change-blog` | `src/blog.el` | 選択中のブログを切り替え |

### ユーティリティ

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hatena-blog-writer-get-data-at-id` | `src/utility.el` | ID でリスト内のオブジェクトを検索 |

### ファイル操作 (共通)

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hatena-blog-writer.dir.ensure` | `src/filer/common.el` | ディレクトリを確保 |
| `hatena-blog-writer.hatena.dir.ensure` | `src/filer/common.el` | `~/.hatena/` を確保 |
| `hatena-blog-writer.hatena-blog.dir.ensure` | `src/filer/common.el` | `~/.hatena/blog/` を確保 |
| `hbw--extract-id` | `src/filer/common.el` | オブジェクトから ID を抽出 |
| `hatena-blog-writer.user.dir.ensure` | `src/filer/common.el` | ユーザーディレクトリを確保 |
| `hatena-blog-writer.blog.dir.ensure` | `src/filer/common.el` | ブログディレクトリを確保 |
| `hatena-blog-writer.entry.dir.ensure` | `src/filer/common.el` | エントリーディレクトリを確保 |
| `hatena-blog-writer-find-entry-dirs` | `src/filer/common.el` | エントリーディレクトリ一覧を取得 |

### ファイル操作 (ユーザー永続化)

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hbw--ensure-user-object` | `src/filer/users.el` | plist → hbw-user 自動変換 |
| `hatena-blog-writer-save-users` | `src/filer/users.el` | ユーザーリストを保存 |
| `hatena-blog-writer-load-users` | `src/filer/users.el` | ユーザーリストを読み込み |

### ファイル操作 (ブログ永続化)

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hbw--ensure-blog-object` | `src/filer/blogs.el` | plist → hbw-blog 自動変換 |
| `hatena-blog-writer-save-blogs` | `src/filer/blogs.el` | ブログリストを保存 |
| `hatena-blog-writer-load-blogs` | `src/filer/blogs.el` | ブログリストを読み込み |

### ファイル操作 (エントリー永続化)

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hbw--ensure-entry-object` | `src/filer/entry-master.el` | 旧形式 → hbw-entry 自動変換 |
| `hatena-blog-writer-load-entry-master` | `src/filer/entry-master.el` | master.el を読み込み |
| `hatena-blog-writer-load-all-entry-master` | `src/filer/entry-master.el` | 全エントリーの master を読み込み |
| `hatena-blog-writer-load-entry-contents` | `src/filer/entry-contents.el` | contents.md を読み込み |

### エントリーファイル

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hatena-blog-writer.entry.dir-name` | `src/entry/entry.file.el` | エントリーディレクトリパスを返す |
| `hatena-blog-writer.entry.file-name.at-id` | `src/entry/entry.file.el` | ファイルパスを返す |
| `hbw-entry-file-path` | `src/entry/entry.file.el` | hbw-entry からファイルパスを返す |
| `hatena-blog-writer.entry.save.master` | `src/entry/entry.file.el` | master.el を保存 |
| `hatena-blog-writer.entry.save.contents` | `src/entry/entry.file.el` | contents.md を保存 |

### エントリーユーティリティ

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hatena-blog-writer.entry.uri.params` | `src/entry/entry.el` | URI からパラメータを抽出 |

### API — URI

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hatena-blog-writer-api-root-uri` | `src/api/uri.el` | ルート URI を返す |
| `hatena-blog-writer-api-entry-uri` | `src/api/uri.el` | Entry URI を返す |
| `hatena-blog-writer-api-category-uri` | `src/api/uri.el` | カテゴリ URI を返す |

### API — 認証ヘッダ

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hatena-blog-writer-request-header-auth` | `src/api/header.el` | Basic 認証ヘッダ値を生成 |
| `hatena-blog-writer-request-headers` | `src/api/header.el` | リクエストヘッダを生成 |

### API — リクエスト

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hatena-blog-writer-request-get-func` | `src/api/request.el` | コールバック関数を返す |
| `hatena-blog-writer-request-method2type` | `src/api/request.el` | メソッド → 文字列変換 |
| `hatena-blog-writer-request` | `src/api/request.el` | 汎用リクエスト関数 |

### API — レスポンス

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hatena-blog-writer.api.result.response` | `src/api/result.el` | result から data を取得 |
| `hatena-blog-writer.api.response.feeds` | `src/api/response.el` | feed 要素のリストを返す |
| `hatena-blog-writer.api.response.feed.entries` | `src/api/response.el` | feed 内の entry 要素を返す |
| `hatena-blog-writer.api.response.feeds.entries` | `src/api/response.el` | 全 feed の entry 要素を返す |
| `hatena-blog-writer.api.response.entries` | `src/api/response.el` | 全 entry 要素を返す |

### API — XML

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hatena-blog-writer-cleanup-xml-del-p` | `src/api/xml.el` | 削除対象の要素か判定 |
| `hatena-blog-writer-cleanup-xml-element` | `src/api/xml.el` | XML 要素をクリーンアップ |
| `hatena-blog-writer-cleanup-xml` | `src/api/xml.el` | XML 全体をクリーンアップ |
| `hatena-blog-writer-request-xml-build-tags` | `src/api/xml.el` | カテゴリタグを構築 |

### API — XML → hbw-entry 変換

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hbw--xml-child-text` | `src/entry/entry-xml.el` | 子要素のテキストを返す |
| `hbw--xml-find-link` | `src/entry/entry-xml.el` | link 要素の href を返す |
| `hbw--xml-author-name` | `src/entry/entry-xml.el` | author > name を返す |
| `hbw--xml-categories` | `src/entry/entry-xml.el` | category の term リストを返す |
| `hbw--xml-draft-p` | `src/entry/entry-xml.el` | 下書き状態を判定 |
| `hbw--xml-parse-uri-params` | `src/entry/entry-xml.el` | URI からパラメータを抽出 |
| `hbw-entry-from-xml` | `src/entry/entry-xml.el` | XML → hbw-entry 変換 |

### API — エントリー操作

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hatena-blog-writer-api-entry-get` | `src/entry/api-entry-get.el` | 単一エントリーを取得 (GET) |
| `hatena-blog-writer-api-entry-get-success` | `src/entry/api-entry-get.el` | GET 成功時コールバック |
| `hatena-blog-writer.api.entry.find` | `src/entry/api-entry-find.el` | 複数エントリーを取得 (GET) |
| `hatena-blog-writer.api.entry.find.success` | `src/entry/api-entry-find.el` | find 成功時コールバック |
| `hatena-blog-writer.find-next-page-no` | `src/entry/api-entry-find.el` | 次ページ番号を取得 |
| `hatena-blog-writer.entry.fetch.all` | `src/entry/api-entry-find.el` | 全エントリーを取得 [interactive] |
| `hatena-blog-writer-build-post-xml` | `src/entry/api-entry-post.el` | POST 用 XML を構築 |
| `hatena-blog-writer-api-entry-post` | `src/entry/api-entry-post.el` | エントリーを新規投稿 (POST) |
| `hatena-blog-writer-api-entry-post-success` | `src/entry/api-entry-post.el` | POST 成功時コールバック |
| `hatena-blog-writer-api-entry-post-error` | `src/entry/api-entry-post.el` | POST エラー時コールバック |
| `hatena-blog-writer-build-put-xml` | `src/entry/api-entry-put.el` | PUT 用 XML を構築 |
| `hatena-blog-writer-api-entry-put` | `src/entry/api-entry-put.el` | エントリーを更新 (PUT) |
| `hatena-blog-writer-api-entry-put-success` | `src/entry/api-entry-put.el` | PUT 成功時コールバック |

### メジャーモード

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `hatena-blog-writer` | `src/mode/major.el` | メジャーモードを起動 [interactive] |
| `hatena-blog-writer-mode-hook` | `src/mode/major.el` | モードフック |
| `hatena-blog-writer-ensure-major-mode-buffer-name` | `src/mode/major-buffer.el` | バッファ名を返す |
| `hatena-blog-writer-ensure-major-mode-buffer` | `src/mode/major-buffer.el` | バッファを確保 |
| `hatena-blog-writer-open-major-mode-buffer-set-mejor-mode` | `src/mode/major-buffer.el` | メジャーモードを設定 |
| `hatena-blog-writer-open-major-mode-buffer` | `src/mode/major-buffer.el` | バッファを開いて描画 |
| `hatena-blog-writer-open-major-mode-print-title` | `src/mode/major-buffer-fields.el` | タイトルを描画 |
| `hatena-blog-writer-open-major-mode-print-user` | `src/mode/major-buffer-fields.el` | ユーザー情報を描画 |
| `hatena-blog-writer-open-major-mode-print-blog` | `src/mode/major-buffer-fields.el` | ブログ情報を描画 |
| `hatena-blog-writer-open-major-mode-print-entries-title` | `src/mode/major-buffer-fields.el` | エントリー一覧のヘッダを描画 |
| `hatena-blog-writer-open-major-mode-print-entry-contents` | `src/mode/major-buffer-fields.el` | 1件のエントリーを描画 |
| `hatena-blog-writer-open-major-mode-print-entries-contents` | `src/mode/major-buffer-fields.el` | エントリー一覧を描画 |

---

## ユーザー管理

定義ファイル: `src/user.el`

### hatena-blog-writer-make-user

**Syntax:**

```
hatena-blog-writer-make-user (id name) => hbw-user
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `id` | string | はてなID |
| `name` | string | ユーザー表示名 |
| 戻り値 | hbw-user | ユーザーオブジェクト |

**Description:**

hbw-user オブジェクトを生成する。

**Examples:**

```elisp
(hatena-blog-writer-make-user "yanqirenshi" "やんきれんし")
;; => #s(hbw-user "yanqirenshi" "やんきれんし")
```

**See Also:**

`hbw-user`, `hatena-blog-writer-add-user`

---

### hatena-blog-writer-user-p

**Syntax:**

```
hatena-blog-writer-user-p (d) => boolean
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `d` | any | 判定対象 |
| 戻り値 | boolean | hbw-user なら `t` |

**Description:**

D が hbw-user オブジェクトなら `t` を返す。内部で `hbw-user-p` を呼ぶ。

**Examples:**

```elisp
(hatena-blog-writer-user-p (hbw-user :id "test" :name "Test"))
;; => t
(hatena-blog-writer-user-p "not a user")
;; => nil
```

---

### hatena-blog-writer-get-user

**Syntax:**

```
hatena-blog-writer-get-user (user-id) => hbw-user or nil
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user-id` | string | はてなID |
| 戻り値 | hbw-user or nil | 見つかったユーザー、見つからなければ nil |

**Description:**

`*hatena-blog-writer-users*` から `user-id` に一致するユーザーを返す。

**Examples:**

```elisp
(hatena-blog-writer-get-user "yanqirenshi")
;; => #s(hbw-user "yanqirenshi" "やんきれんし")
```

**See Also:**

`hatena-blog-writer-get-data-at-id`

---

### hatena-blog-writer-add-user

**Syntax:**

```
hatena-blog-writer-add-user (user) => list
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user | 追加するユーザー |
| 戻り値 | list | 更新後のユーザーリスト |

**Description:**

ユーザーを `*hatena-blog-writer-users*` に追加する。hbw-user でない場合、または同一 ID のユーザーが既に存在する場合はエラーを発生させる。

**Exceptional Situations:**

- `user` が `hbw-user-p` でない場合: `"Error: data type is not user."` エラー
- 同一 ID のユーザーが既に存在する場合: `"Error: already exist this user."` エラー

**Examples:**

```elisp
(hatena-blog-writer-add-user (hbw-user :id "new-user" :name "New"))
```

**See Also:**

`hatena-blog-writer-save-users`

---

### hatena-blog-writer-change-user

**Syntax:**

```
hatena-blog-writer-change-user (user-id) => hbw-user
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user-id` | string | はてなID |
| 戻り値 | hbw-user | 選択されたユーザー |

**Description:**

`*hatena-blog-writer-current-user*` を `user-id` に一致するユーザーに切り替える。

**Exceptional Situations:**

- ユーザーが見つからない場合: `"Not exist user."` エラー

**Affected By:**

`*hatena-blog-writer-users*`, `*hatena-blog-writer-current-user*`

---

## ブログ管理

定義ファイル: `src/blog.el`

### hatena-blog-writer-make-blog

**Syntax:**

```
hatena-blog-writer-make-blog (id name api-key) => hbw-blog
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `id` | string | ブログID |
| `name` | string | ブログ表示名 |
| `api-key` | string | AtomPub API キー |
| 戻り値 | hbw-blog | ブログオブジェクト |

**Description:**

hbw-blog オブジェクトを生成する。

**Examples:**

```elisp
(hatena-blog-writer-make-blog "example.hatenablog.com"
                               "ほんとのこと知りたいだけなのに。"
                               "your-api-key")
```

**See Also:**

`hbw-blog`, `hatena-blog-writer-add-blog`

---

### hatena-blog-writer-blog-p

**Syntax:**

```
hatena-blog-writer-blog-p (d) => boolean
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `d` | any | 判定対象 |
| 戻り値 | boolean | hbw-blog なら `t` |

**Description:**

D が hbw-blog オブジェクトなら `t` を返す。

---

### hatena-blog-writer-get-blog

**Syntax:**

```
hatena-blog-writer-get-blog (blog-id) => hbw-blog or nil
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `blog-id` | string | ブログID |
| 戻り値 | hbw-blog or nil | 見つかったブログ |

**Description:**

`*hatena-blog-writer-blogs*` から `blog-id` に一致するブログを返す。

**See Also:**

`hatena-blog-writer-get-data-at-id`

---

### hatena-blog-writer-add-blog

**Syntax:**

```
hatena-blog-writer-add-blog (blog) => list
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `blog` | hbw-blog | 追加するブログ |
| 戻り値 | list | 更新後のブログリスト |

**Description:**

ブログを `*hatena-blog-writer-blogs*` に追加する。

**Exceptional Situations:**

- `blog` が `hbw-blog-p` でない場合: `"Error: data type is not blog."` エラー
- 同一 ID のブログが既に存在する場合: `"Error: already exist this blog."` エラー

---

### hatena-blog-writer-change-blog

**Syntax:**

```
hatena-blog-writer-change-blog (blog-id) => hbw-blog
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `blog-id` | string | ブログID |
| 戻り値 | hbw-blog | 選択されたブログ |

**Description:**

`*hatena-blog-writer-current-blog*` を `blog-id` に一致するブログに切り替える。

**Exceptional Situations:**

- ブログが見つからない場合: `"Not exist blog."` エラー

**Affected By:**

`*hatena-blog-writer-blogs*`, `*hatena-blog-writer-current-blog*`

---

## ユーティリティ

定義ファイル: `src/utility.el`

### hatena-blog-writer-get-data-at-id

**Syntax:**

```
hatena-blog-writer-get-data-at-id (id data-list) => object or nil
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `id` | string | 検索する ID |
| `data-list` | list | EIEIO オブジェクトのリスト |
| 戻り値 | object or nil | ID が一致したオブジェクト |

**Description:**

`data-list` から `id` スロットが一致するオブジェクトを `cl-find` で検索して返す。各要素は `id` スロットを持つ EIEIO オブジェクトであること。

**Examples:**

```elisp
(hatena-blog-writer-get-data-at-id "yanqirenshi" *hatena-blog-writer-users*)
;; => #s(hbw-user "yanqirenshi" "やんきれんし")
```

---

## ファイル操作 (共通)

定義ファイル: `src/filer/common.el`

### hatena-blog-writer.dir.ensure

**Syntax:**

```
hatena-blog-writer.dir.ensure (dir-name) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `dir-name` | string | ディレクトリパス |
| 戻り値 | string | 確保されたディレクトリパス |

**Description:**

ディレクトリが存在しなければ作成し、パスを返す。

---

### hatena-blog-writer.hatena.dir.ensure

**Syntax:**

```
hatena-blog-writer.hatena.dir.ensure () => string
```

**Description:**

`~/.hatena/` ディレクトリを確保する。

---

### hatena-blog-writer.hatena-blog.dir.ensure

**Syntax:**

```
hatena-blog-writer.hatena-blog.dir.ensure () => string
```

**Description:**

`~/.hatena/blog/` ディレクトリを確保する。`~/.hatena/` も確保される。

---

### hbw--extract-id

**Syntax:**

```
hbw--extract-id (obj) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `obj` | string or eieio-object | 文字列または EIEIO オブジェクト |
| 戻り値 | string | ID 文字列 |

**Description:**

文字列ならそのまま、EIEIO オブジェクトなら `id` スロットの値を返す。

**Exceptional Situations:**

- 文字列でも EIEIO オブジェクトでもない場合: `"Invalid object"` エラー

---

### hatena-blog-writer.user.dir.ensure

**Syntax:**

```
hatena-blog-writer.user.dir.ensure (user) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user or string | ユーザーオブジェクトまたはユーザーID |
| 戻り値 | string | `~/.hatena/blog/{user-id}/` |

**Description:**

ユーザーディレクトリを確保する。親ディレクトリも確保される。

---

### hatena-blog-writer.blog.dir.ensure

**Syntax:**

```
hatena-blog-writer.blog.dir.ensure (user blog) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user or string | ユーザー |
| `blog` | hbw-blog or string | ブログ |
| 戻り値 | string | `~/.hatena/blog/{user-id}/{blog-id}/` |

**Description:**

ブログディレクトリを確保する。

---

### hatena-blog-writer.entry.dir.ensure

**Syntax:**

```
hatena-blog-writer.entry.dir.ensure (user blog entry) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user or string | ユーザー |
| `blog` | hbw-blog or string | ブログ |
| `entry` | hbw-entry or string | エントリーまたはエントリーID |
| 戻り値 | string | `~/.hatena/blog/{user-id}/{blog-id}/{entry-id}/` |

**Description:**

エントリーディレクトリを確保する。

---

### hatena-blog-writer-find-entry-dirs

**Syntax:**

```
hatena-blog-writer-find-entry-dirs (user blog) => list
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user or string | ユーザー |
| `blog` | hbw-blog or string | ブログ |
| 戻り値 | list | エントリーディレクトリ名のリスト（`.` と `..` は除外） |

**Description:**

ブログディレクトリ内のエントリーディレクトリ一覧を返す。

---

## ファイル操作 (ユーザー永続化)

定義ファイル: `src/filer/users.el`

### hbw--ensure-user-object

**Syntax:**

```
hbw--ensure-user-object (data) => hbw-user
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `data` | hbw-user or plist | ユーザーデータ |
| 戻り値 | hbw-user | ユーザーオブジェクト |

**Description:**

DATA が plist（旧形式）なら hbw-user に変換、既に hbw-user ならそのまま返す。

**Exceptional Situations:**

- 不明な形式の場合: `"不明なユーザーデータ形式"` エラー

---

### hatena-blog-writer-save-users

**Syntax:**

```
hatena-blog-writer-save-users () => void
```

**Description:**

`*hatena-blog-writer-users*` を `~/.hatena/blog/config/users.lisp` に `format "%S"` で保存する。

**Affected By:**

`*hatena-blog-writer-users*`

---

### hatena-blog-writer-load-users

**Syntax:**

```
hatena-blog-writer-load-users () => void
```

**Description:**

`~/.hatena/blog/config/users.lisp` からユーザーリストを読み込み、`*hatena-blog-writer-users*` にセットする。旧 plist 形式は `hbw--ensure-user-object` で自動変換される。

**Affected By:**

`*hatena-blog-writer-users*`

---

## ファイル操作 (ブログ永続化)

定義ファイル: `src/filer/blogs.el`

### hbw--ensure-blog-object

**Syntax:**

```
hbw--ensure-blog-object (data) => hbw-blog
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `data` | hbw-blog or plist | ブログデータ |
| 戻り値 | hbw-blog | ブログオブジェクト |

**Description:**

DATA が plist（旧形式）なら hbw-blog に変換、既に hbw-blog ならそのまま返す。

**Exceptional Situations:**

- 不明な形式の場合: `"不明なブログデータ形式"` エラー

---

### hatena-blog-writer-save-blogs

**Syntax:**

```
hatena-blog-writer-save-blogs () => void
```

**Description:**

`*hatena-blog-writer-blogs*` を `~/.hatena/blog/config/blogs.lisp` に保存する。

**Affected By:**

`*hatena-blog-writer-blogs*`

---

### hatena-blog-writer-load-blogs

**Syntax:**

```
hatena-blog-writer-load-blogs () => void
```

**Description:**

`~/.hatena/blog/config/blogs.lisp` からブログリストを読み込み、`*hatena-blog-writer-blogs*` にセットする。旧 plist 形式は自動変換される。

**Affected By:**

`*hatena-blog-writer-blogs*`

---

## ファイル操作 (エントリー永続化)

定義ファイル: `src/filer/entry-master.el`, `src/filer/entry-contents.el`

### hbw--ensure-entry-object

**Syntax:**

```
hbw--ensure-entry-object (data) => hbw-entry
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `data` | hbw-entry or list | エントリーデータ |
| 戻り値 | hbw-entry | エントリーオブジェクト |

**Description:**

DATA が旧 XML ノード形式 `(entry ATTRS CHILDREN...)` なら `hbw-entry-from-xml` で変換、既に hbw-entry ならそのまま返す。

**Exceptional Situations:**

- 不明な形式の場合: `"不明なエントリーデータ形式"` エラー

---

### hatena-blog-writer-load-entry-master

**Syntax:**

```
hatena-blog-writer-load-entry-master (user blog entry-id) => hbw-entry or nil
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user or string | ユーザー |
| `blog` | hbw-blog or string | ブログ |
| `entry-id` | string | エントリーID |
| 戻り値 | hbw-entry or nil | エントリーオブジェクト（ファイルが無ければ nil） |

**Description:**

`master.el` から hbw-entry オブジェクトを読み込む。旧 XML 形式は自動変換される。

---

### hatena-blog-writer-load-all-entry-master

**Syntax:**

```
hatena-blog-writer-load-all-entry-master (user blog) => list
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user or string | ユーザー |
| `blog` | hbw-blog or string | ブログ |
| 戻り値 | list | hbw-entry のリスト |

**Description:**

全エントリーの `master.el` を読み込んで hbw-entry のリストを返す。

---

### hatena-blog-writer-load-entry-contents

**Syntax:**

```
hatena-blog-writer-load-entry-contents (user blog entry-id) => plist
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user or string | ユーザー |
| `blog` | hbw-blog or string | ブログ |
| `entry-id` | string | エントリーID |
| 戻り値 | plist | `(:title "..." :contents "...")` |

**Description:**

`contents.md` を読み込み、1行目をタイトル、2行目以降を本文として plist で返す。

---

## エントリーファイル

定義ファイル: `src/entry/entry.file.el`

### hatena-blog-writer.entry.dir-name

**Syntax:**

```
hatena-blog-writer.entry.dir-name (user-id blog-id entry-id) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user-id` | string | はてなID |
| `blog-id` | string | ブログID |
| `entry-id` | string | エントリーID |
| 戻り値 | string | ディレクトリパス |

**Description:**

エントリーのディレクトリパスを返す。存在しなければ作成する。

---

### hatena-blog-writer.entry.file-name.at-id

**Syntax:**

```
hatena-blog-writer.entry.file-name.at-id (type user-id blog-id entry-id) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `type` | string | `"master"` or `"contents"` |
| `user-id` | string | はてなID |
| `blog-id` | string | ブログID |
| `entry-id` | string | エントリーID |
| 戻り値 | string | ファイルパス |

**Description:**

type に応じたファイルパスを返す。`"master"` → `master.el`、`"contents"` → `contents.md`。

**Exceptional Situations:**

- type が `"master"` でも `"contents"` でもない場合: `"Bad type"` エラー

---

### hbw-entry-file-path

**Syntax:**

```
hbw-entry-file-path (type entry) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `type` | string | `"master"` or `"contents"` |
| `entry` | hbw-entry | エントリーオブジェクト |
| 戻り値 | string | ファイルパス |

**Description:**

hbw-entry オブジェクトから hatena-id, blog-id, entry-id を取得してファイルパスを返す。

---

### hatena-blog-writer.entry.save.master

**Syntax:**

```
hatena-blog-writer.entry.save.master (entry) => hbw-entry
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `entry` | hbw-entry or xml-node | エントリー（XML の場合は自動変換） |
| 戻り値 | hbw-entry | 保存した hbw-entry オブジェクト |

**Description:**

hbw-entry オブジェクトを `master.el` として `format "%S"` で保存する。引数が XML entry ノードの場合は `hbw-entry-from-xml` で変換してから保存する。

---

### hatena-blog-writer.entry.save.contents

**Syntax:**

```
hatena-blog-writer.entry.save.contents (entry) => hbw-entry
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `entry` | hbw-entry or xml-node | エントリー（XML の場合は自動変換） |
| 戻り値 | hbw-entry | 保存した hbw-entry オブジェクト |

**Description:**

hbw-entry の title と content を `contents.md` として保存する。1行目にタイトル、2行目以降に本文を書き込む。

---

## エントリーユーティリティ

定義ファイル: `src/entry/entry.el`

### hatena-blog-writer.entry.uri.params

**Syntax:**

```
hatena-blog-writer.entry.uri.params (uri) => plist or nil
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `uri` | string | はてなブログ AtomPub の URI |
| 戻り値 | plist or nil | `(:hatena-id "..." :hatena-blog-id "..." :hatena-blog-entry-id "...")` |

**Description:**

はてなブログ AtomPub の URI からパラメータを抽出する。

**Examples:**

```elisp
(hatena-blog-writer.entry.uri.params
 "https://blog.hatena.ne.jp/yanqirenshi/example.hatenablog.com/atom/entry/123")
;; => (:hatena-id "yanqirenshi" :hatena-blog-id "example.hatenablog.com" :hatena-blog-entry-id "123")
```

---

## API — URI

定義ファイル: `src/api/uri.el`

### hatena-blog-writer-api-root-uri

**Syntax:**

```
hatena-blog-writer-api-root-uri (hatena-id hatena-blog-id) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `hatena-id` | string | はてなID |
| `hatena-blog-id` | string | ブログID |
| 戻り値 | string | ルート URI |

**Description:**

はてなブログ AtomPub のルート URI を返す。

**Examples:**

```elisp
(hatena-blog-writer-api-root-uri "yanqirenshi" "example.hatenablog.com")
;; => "https://blog.hatena.ne.jp/yanqirenshi/example.hatenablog.com/atom"
```

---

### hatena-blog-writer-api-entry-uri

**Syntax:**

```
hatena-blog-writer-api-entry-uri (id-or-user id-or-blog &optional entry_id) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `id-or-user` | string or hbw-user | はてなID または ユーザーオブジェクト |
| `id-or-blog` | string or hbw-blog | ブログID または ブログオブジェクト |
| `entry_id` | string or nil | エントリーID（省略可） |
| 戻り値 | string | Entry URI |

**Description:**

はてなブログ AtomPub の Entry URI を返す。引数は文字列でも EIEIO オブジェクトでも受け付ける。`entry_id` を省略するとエントリー一覧の URI を返す。

**Examples:**

```elisp
(hatena-blog-writer-api-entry-uri user blog)
;; => "https://blog.hatena.ne.jp/yanqirenshi/example.hatenablog.com/atom/entry"

(hatena-blog-writer-api-entry-uri user blog "10328749687211177806")
;; => "https://blog.hatena.ne.jp/yanqirenshi/example.hatenablog.com/atom/entry/10328749687211177806"
```

**Exceptional Situations:**

- `id-or-user` が文字列でも hbw-user でもない場合: `"Invalid id-or-user"` エラー
- `id-or-blog` が文字列でも hbw-blog でもない場合: `"Invalid id-or-blog"` エラー

---

### hatena-blog-writer-api-category-uri

**Syntax:**

```
hatena-blog-writer-api-category-uri (hatena-id hatena-blog-id) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `hatena-id` | string | はてなID |
| `hatena-blog-id` | string | ブログID |
| 戻り値 | string | カテゴリ URI |

**Description:**

はてなブログ AtomPub のカテゴリ URI を返す。

---

## API — 認証ヘッダ

定義ファイル: `src/api/header.el`

### hatena-blog-writer-request-header-auth

**Syntax:**

```
hatena-blog-writer-request-header-auth (hatena-id hatena-blog-api-key) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `hatena-id` | string | はてなID |
| `hatena-blog-api-key` | string | API キー |
| 戻り値 | string | `"Basic ..."` 形式の認証ヘッダ値 |

**Description:**

Basic 認証の Authorization ヘッダ値を返す。`hatena-id:api-key` を Base64 エンコードする。

---

### hatena-blog-writer-request-headers

**Syntax:**

```
hatena-blog-writer-request-headers (id-or-user api-key-or-blog) => alist
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `id-or-user` | string or hbw-user | はてなID またはユーザーオブジェクト |
| `api-key-or-blog` | string or hbw-blog | API キーまたはブログオブジェクト |
| 戻り値 | alist | リクエストヘッダの alist |

**Description:**

リクエストヘッダの alist を返す。`Content-Type` と `Authorization` を含む。

**Exceptional Situations:**

- 引数が不正な型の場合: `"Invalid id-or-user"` / `"Invalid api-key-or-blog"` エラー

---

## API — リクエスト

定義ファイル: `src/api/request.el`

### hatena-blog-writer-request-get-func

**Syntax:**

```
hatena-blog-writer-request-get-func (funcs type) => function
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `funcs` | plist or nil | コールバック関数の plist |
| `type` | keyword | `:parser`, `:success`, `:error`, `:complete` |
| 戻り値 | function | コールバック関数 |

**Description:**

`funcs` plist に指定されたコールバックがあればそれを返し、なければデフォルトコールバックを返す。

---

### hatena-blog-writer-request-method2type

**Syntax:**

```
hatena-blog-writer-request-method2type (method) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `method` | keyword | `:get`, `:post`, `:put` |
| 戻り値 | string | `"GET"`, `"POST"`, `"PUT"` |

**Description:**

メソッドキーワードを request.el の type 文字列に変換する。

**Exceptional Situations:**

- 未知のメソッドの場合: `"bad method"` エラー

---

### hatena-blog-writer-request

**Syntax:**

```
hatena-blog-writer-request (method uri hatena-id hatena-blog-id hatena-blog-api-key funcs &optional entry-id next-page) => request-response
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `method` | keyword | `:get`, `:post`, `:put` |
| `uri` | string | リクエスト先 URI |
| `hatena-id` | string | はてなID |
| `hatena-blog-id` | string | ブログID |
| `hatena-blog-api-key` | string | API キー |
| `funcs` | plist | コールバック関数の plist |
| `entry-id` | string or nil | エントリーID（未使用） |
| `next-page` | string or nil | 次ページ番号（未使用） |

**Description:**

hatena-blog-writer の汎用リクエスト関数。request.el のラッパー。

---

## API — レスポンス

定義ファイル: `src/api/result.el`, `src/api/response.el`

### hatena-blog-writer.api.result.response

**Syntax:**

```
hatena-blog-writer.api.result.response (result) => list
```

**Description:**

API の success コールバックが受け取る result plist から `:data` を取り出す。

---

### hatena-blog-writer.api.response.feeds

**Syntax:**

```
hatena-blog-writer.api.response.feeds (response) => list
```

**Description:**

レスポンスから `feed` 要素のリストを返す。

---

### hatena-blog-writer.api.response.feed.entries

**Syntax:**

```
hatena-blog-writer.api.response.feed.entries (feed) => list
```

**Description:**

1つの `feed` 要素からその中の `entry` 要素のリストを返す。

---

### hatena-blog-writer.api.response.feeds.entries

**Syntax:**

```
hatena-blog-writer.api.response.feeds.entries (feeds) => list
```

**Description:**

複数の `feed` 要素から全 `entry` 要素をフラットなリストで返す。

---

### hatena-blog-writer.api.response.entries

**Syntax:**

```
hatena-blog-writer.api.response.entries (response) => list
```

**Description:**

レスポンスから全 `entry` 要素をフラットなリストで返す。

---

## API — XML

定義ファイル: `src/api/xml.el`

### hatena-blog-writer-cleanup-xml-del-p

**Syntax:**

```
hatena-blog-writer-cleanup-xml-del-p (d) => boolean
```

**Description:**

削除対象の要素かどうかを判定する。文字列かつ `s-trim` 後に空文字列ならば `t`。

---

### hatena-blog-writer-cleanup-xml-element

**Syntax:**

```
hatena-blog-writer-cleanup-xml-element (element) => list
```

**Description:**

1つの XML 要素を再帰的にクリーンアップする。空白のみのテキストノードを除去する。

---

### hatena-blog-writer-cleanup-xml

**Syntax:**

```
hatena-blog-writer-cleanup-xml (xml) => list
```

**Description:**

`xml-parse-region` の出力から空白のみのテキストノードを除去する。

---

### hatena-blog-writer-request-xml-build-tags

**Syntax:**

```
hatena-blog-writer-request-xml-build-tags (tags) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `tags` | list | カテゴリ文字列のリスト |
| 戻り値 | string | `<category term="..." />` タグの連結文字列 |

**Description:**

カテゴリ文字列のリストから XML カテゴリタグを構築する。

**Examples:**

```elisp
(hatena-blog-writer-request-xml-build-tags '("Emacs" "Lisp"))
;; => "<category term=\"Emacs\" /><category term=\"Lisp\" />"
```

---

## API — XML → hbw-entry 変換

定義ファイル: `src/entry/entry-xml.el`

### hbw--xml-child-text

**Syntax:**

```
hbw--xml-child-text (children key) => string or nil
```

**Description:**

CHILDREN 内の KEY 要素のテキストを返す。

---

### hbw--xml-find-link

**Syntax:**

```
hbw--xml-find-link (children rel) => string or nil
```

**Description:**

CHILDREN 内の `link` 要素から `rel` 属性が REL のものの `href` を返す。

---

### hbw--xml-author-name

**Syntax:**

```
hbw--xml-author-name (children) => string or nil
```

**Description:**

CHILDREN 内の `author > name` のテキストを返す。

---

### hbw--xml-categories

**Syntax:**

```
hbw--xml-categories (children) => list
```

**Description:**

CHILDREN 内の全 `category` 要素の `term` 属性をリストで返す。

---

### hbw--xml-draft-p

**Syntax:**

```
hbw--xml-draft-p (children) => boolean
```

**Description:**

CHILDREN 内の `app:control > app:draft` が `"yes"` なら `t` を返す。

---

### hbw--xml-parse-uri-params

**Syntax:**

```
hbw--xml-parse-uri-params (uri) => plist or nil
```

**Description:**

はてなブログ AtomPub の URI からパラメータを抽出する。

**Examples:**

```elisp
(hbw--xml-parse-uri-params
 "https://blog.hatena.ne.jp/user/blog.hatenablog.com/atom/entry/123")
;; => (:hatena-id "user" :hatena-blog-id "blog.hatenablog.com" :hatena-blog-entry-id "123")
```

---

### hbw-entry-from-xml

**Syntax:**

```
hbw-entry-from-xml (xml-entry) => hbw-entry
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `xml-entry` | list | `(entry ATTRS CHILDREN...)` 形式の XML ノード |
| 戻り値 | hbw-entry | エントリーオブジェクト |

**Description:**

XML entry ノードから hbw-entry オブジェクトを生成する。edit link の URI から hatena-id, blog-id, entry-id を自動抽出する。

**See Also:**

`hbw--xml-child-text`, `hbw--xml-find-link`, `hbw--xml-author-name`, `hbw--xml-categories`, `hbw--xml-draft-p`, `hbw--xml-parse-uri-params`

---

## API — エントリー操作 (GET)

定義ファイル: `src/entry/api-entry-get.el`

### hatena-blog-writer-api-entry-get

**Syntax:**

```
hatena-blog-writer-api-entry-get (user blog entry-id &rest key-params) => request-response
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user | ユーザーオブジェクト |
| `blog` | hbw-blog | ブログオブジェクト |
| `entry-id` | string | エントリーID |

key-params:

| キー | 型 | 説明 |
|------|------|------|
| `:update` | symbol | `:all`, `:master`, `:contents` — 保存対象 |
| `:callback` | function or nil | 完了後コールバック |

**Description:**

単一エントリーを GET で取得する。`:update` に応じて master / contents を保存する。`:callback` が指定されていれば取得完了後に呼ばれる。

**Examples:**

```elisp
(hatena-blog-writer-api-entry-get user blog "10328749687211177806"
                                   :update :master
                                   :callback (lambda () (message "Done!")))
```

---

### hatena-blog-writer-api-entry-get-success

**Syntax:**

```
hatena-blog-writer-api-entry-get-success (response update) => void
```

**Description:**

GET 成功時の内部コールバック。XML レスポンスを `hbw-entry-from-xml` で変換し、`update` に応じて保存する。

---

## API — エントリー操作 (FIND)

定義ファイル: `src/entry/api-entry-find.el`

### hatena-blog-writer.find-next-page-no

**Syntax:**

```
hatena-blog-writer.find-next-page-no (xml-lists) => string or nil
```

**Description:**

フィード内の `link[rel="next"]` から次ページ番号を取り出す。

---

### hatena-blog-writer.api.entry.find.success

**Syntax:**

```
hatena-blog-writer.api.entry.find.success (&rest result) => void
```

**Description:**

find の成功コールバック。フィード内の全エントリーを `hbw-entry-from-xml` で変換し、master と contents を保存する。

---

### hatena-blog-writer.api.entry.find

**Syntax:**

```
hatena-blog-writer.api.entry.find (user blog &optional next-page) => request-response
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user | ユーザーオブジェクト |
| `blog` | hbw-blog | ブログオブジェクト |
| `next-page` | string or nil | 次ページ番号 |

**Description:**

エントリーを複数取得する。全エントリーの master と contents を保存する。

---

### hatena-blog-writer.entry.fetch.all

**Syntax:**

```
hatena-blog-writer.entry.fetch.all () => void  [interactive]
```

**Description:**

現在選択中のユーザー・ブログの全エントリーを取得する。

**Affected By:**

`*hatena-blog-writer-current-user*`, `*hatena-blog-writer-current-blog*`

---

## API — エントリー操作 (POST)

定義ファイル: `src/entry/api-entry-post.el`

### hatena-blog-writer-build-post-xml

**Syntax:**

```
hatena-blog-writer-build-post-xml (user title contents categories draft) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user | ユーザーオブジェクト |
| `title` | string | タイトル |
| `contents` | string | 本文 |
| `categories` | list | カテゴリ文字列のリスト |
| `draft` | string | `"yes"` or `"no"` |
| 戻り値 | string | XML 文字列 |

**Description:**

POST 用の Atom XML を構築する。

---

### hatena-blog-writer-api-entry-post

**Syntax:**

```
hatena-blog-writer-api-entry-post (user blog xml) => request-response
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user | ユーザーオブジェクト |
| `blog` | hbw-blog | ブログオブジェクト |
| `xml` | string | POST する XML 文字列 |

**Description:**

エントリーを新規投稿する。成功時は master と contents を保存する。

---

### hatena-blog-writer-api-entry-post-success

**Syntax:**

```
hatena-blog-writer-api-entry-post-success (&rest response) => void
```

**Description:**

POST 成功時のコールバック。`hbw-entry-from-xml` で変換して保存する。

---

### hatena-blog-writer-api-entry-post-error

**Syntax:**

```
hatena-blog-writer-api-entry-post-error (&rest response) => void
```

**Description:**

POST エラー時のコールバック。レスポンスを `*tmp-post-error*` に格納する。

---

## API — エントリー操作 (PUT)

定義ファイル: `src/entry/api-entry-put.el`

### hatena-blog-writer-build-put-xml

**Syntax:**

```
hatena-blog-writer-build-put-xml (user blog entry-id) => string
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user | ユーザーオブジェクト |
| `blog` | hbw-blog | ブログオブジェクト |
| `entry-id` | string | エントリーID |
| 戻り値 | string | XML 文字列 |

**Description:**

PUT 用の XML を構築する。`contents.md` からタイトルと本文を読み込み、master から既存メタデータ（カテゴリ、下書き状態）を取得してマージする。

---

### hatena-blog-writer-api-entry-put-success

**Syntax:**

```
hatena-blog-writer-api-entry-put-success (&rest response) => void
```

**Description:**

PUT 成功時のコールバック。`hbw-entry-from-xml` で変換し、master と contents を保存する。

---

### hatena-blog-writer-api-entry-put

**Syntax:**

```
hatena-blog-writer-api-entry-put (user blog entry-id) => void
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `user` | hbw-user | ユーザーオブジェクト |
| `blog` | hbw-blog | ブログオブジェクト |
| `entry-id` | string | エントリーID |

**Description:**

`contents.md` の内容をサーバーに PUT する。最新の master を GET で取得した後、title と content のみを変更して PUT する。

**Notes:**

処理フロー: GET で最新 master 取得 → XML 構築 → PUT 送信 → 成功時に master/contents 保存。

---

## メジャーモード

定義ファイル: `src/mode/major.el`, `src/mode/major-buffer.el`, `src/mode/major-buffer-fields.el`

### hatena-blog-writer

**Syntax:**

```
hatena-blog-writer () => void  [interactive]
```

**Description:**

hatena-blog-writer メジャーモードを起動する。バッファを作成してエントリー一覧を表示する。

**Affected By:**

`*hatena-blog-writer-current-user*`, `*hatena-blog-writer-current-blog*`

---

### hatena-blog-writer-mode-hook

**Syntax:**

```
hatena-blog-writer-mode-hook () => void
```

**Description:**

メジャーモードのフック関数。`"Enjoy write blog!"` をメッセージ表示する。

---

### hatena-blog-writer-ensure-major-mode-buffer-name

**Syntax:**

```
hatena-blog-writer-ensure-major-mode-buffer-name () => string or nil
```

**Description:**

メジャーモードのバッファ名を返す。形式: `*hatena-blog: {user-id}*`。

**Affected By:**

`*hatena-blog-writer-current-user*`

---

### hatena-blog-writer-ensure-major-mode-buffer

**Syntax:**

```
hatena-blog-writer-ensure-major-mode-buffer () => buffer
```

**Description:**

メジャーモードのバッファを確保して返す。ユーザーが選択されていない場合はエラー。

**Exceptional Situations:**

- `*hatena-blog-writer-current-user*` が nil の場合: `"Not choiced user"` エラー

---

### hatena-blog-writer-open-major-mode-buffer-set-mejor-mode

**Syntax:**

```
hatena-blog-writer-open-major-mode-buffer-set-mejor-mode (buffer) => void
```

**Description:**

バッファに `hatena-blog-writer-mode` メジャーモードを設定する。

---

### hatena-blog-writer-open-major-mode-buffer

**Syntax:**

```
hatena-blog-writer-open-major-mode-buffer (buffer) => void
```

**Description:**

バッファをクリアし、タイトル・ユーザー・ブログ・エントリー一覧を描画してメジャーモードを設定する。

---

### hatena-blog-writer-open-major-mode-print-title

**Syntax:**

```
hatena-blog-writer-open-major-mode-print-title () => void
```

**Description:**

バッファの1行目に `"HATENA BLOG WRITER"` を描画する。

---

### hatena-blog-writer-open-major-mode-print-user

**Syntax:**

```
hatena-blog-writer-open-major-mode-print-user () => void
```

**Description:**

バッファの2行目にユーザー情報（表示名とID）を描画する。

**Affected By:**

`*hatena-blog-writer-current-user*`

---

### hatena-blog-writer-open-major-mode-print-blog

**Syntax:**

```
hatena-blog-writer-open-major-mode-print-blog () => void
```

**Description:**

バッファの3行目にブログ情報（表示名とID）を描画する。

**Affected By:**

`*hatena-blog-writer-current-blog*`

---

### hatena-blog-writer-open-major-mode-print-entries-title

**Syntax:**

```
hatena-blog-writer-open-major-mode-print-entries-title () => void
```

**Description:**

エントリー一覧のヘッダ（`"Entries:"` と列見出し）を描画する。

---

### hatena-blog-writer-open-major-mode-print-entry-contents

**Syntax:**

```
hatena-blog-writer-open-major-mode-print-entry-contents (entry) => void
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `entry` | hbw-entry | エントリーオブジェクト |

**Description:**

1件のエントリーのステータスとタイトルを1行で描画する。

---

### hatena-blog-writer-open-major-mode-print-entries-contents

**Syntax:**

```
hatena-blog-writer-open-major-mode-print-entries-contents (entries) => void
```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `entries` | list | hbw-entry のリスト |

**Description:**

エントリー一覧の全エントリーを描画する。
