# CLASSES

hatena-blog-writer で定義されている EIEIO クラスの一覧です。

定義ファイル: `src/classes.el`

## クラス一覧

| クラス名 | 説明 |
|----------|------|
| `hbw-user` | はてなブログのユーザー |
| `hbw-blog` | はてなブログ |
| `hbw-entry` | はてなブログのエントリー（記事） |

---

## hbw-user

はてなブログのユーザーを表すクラス。

### スロット

| スロット | initarg | 型 | 初期値 | アクセサ | 説明 |
|----------|---------|------|--------|----------|------|
| `id` | `:id` | `string` | ― | `hbw-user-id` | はてなID |
| `name` | `:name` | `string` | ― | `hbw-user-name` | ユーザー表示名 |

### コンストラクタ

```elisp
(hbw-user :id "yanqirenshi" :name "やんきれんし")
```

### メソッド

#### hbw-user-display

```
hbw-user-display (user hbw-user) => string
```

ユーザーの表示文字列を返す。

```elisp
(hbw-user-display user)
;; => "やんきれんし (yanqirenshi)"
```

### 型述語

```elisp
(hbw-user-p obj) ;; => t or nil
```

### 永続化

- 保存先: `~/.hatena/blog/config/users.lisp`
- 形式: `format "%S"` による S式
- 読み込み時に旧 plist 形式 (`(:id ... :name ... :class "user")`) は自動変換される

---

## hbw-blog

はてなブログを表すクラス。

### スロット

| スロット | initarg | 型 | 初期値 | アクセサ | 説明 |
|----------|---------|------|--------|----------|------|
| `id` | `:id` | `string` | ― | `hbw-blog-id` | ブログID (例: `example.hatenablog.com`) |
| `name` | `:name` | `string` | ― | `hbw-blog-name` | ブログ表示名 |
| `api-key` | `:api-key` | `string` | ― | `hbw-blog-api-key` | はてなブログ AtomPub APIキー |

### コンストラクタ

```elisp
(hbw-blog :id "example.hatenablog.com"
          :name "ほんとのこと知りたいだけなのに。"
          :api-key "your-api-key")
```

### メソッド

#### hbw-blog-display

```
hbw-blog-display (blog hbw-blog) => string
```

ブログの表示文字列を返す。

```elisp
(hbw-blog-display blog)
;; => "ほんとのこと知りたいだけなのに。 (example.hatenablog.com)"
```

### 型述語

```elisp
(hbw-blog-p obj) ;; => t or nil
```

### 永続化

- 保存先: `~/.hatena/blog/config/blogs.lisp`
- 形式: `format "%S"` による S式
- 読み込み時に旧 plist 形式 (`(:id ... :name ... :api-key ... :class "blog")`) は自動変換される

---

## hbw-entry

はてなブログのエントリー（記事）を表すクラス。

はてなブログ AtomPub API のレスポンス XML から `hbw-entry-from-xml` で生成される。

### スロット

| スロット | initarg | 型 | 初期値 | アクセサ | 説明 |
|----------|---------|------|--------|----------|------|
| `entry-id` | `:entry-id` | `string` | ― | `hbw-entry-id` | エントリーの一意識別子 |
| `uri` | `:uri` | `string` | ― | `hbw-entry-uri` | 編集用URI (`link rel='edit'` の href) |
| `alternate-uri` | `:alternate-uri` | `string` or `nil` | `nil` | `hbw-entry-alternate-uri` | 公開URL (`link rel='alternate'` の href) |
| `author-name` | `:author-name` | `string` or `nil` | `nil` | `hbw-entry-author-name` | 著者名 |
| `title` | `:title` | `string` | ― | `hbw-entry-title` | エントリーのタイトル |
| `updated` | `:updated` | `string` or `nil` | `nil` | `hbw-entry-updated` | 更新日時 (ISO 8601) |
| `published` | `:published` | `string` or `nil` | `nil` | `hbw-entry-published` | 公開日時 (ISO 8601) |
| `edited` | `:edited` | `string` or `nil` | `nil` | `hbw-entry-edited` | 編集日時 (`app:edited`, ISO 8601) |
| `summary` | `:summary` | `string` or `nil` | `nil` | `hbw-entry-summary` | 要約 (最大140文字) |
| `content` | `:content` | `string` | `""` | `hbw-entry-content` | 本文テキスト |
| `content-type` | `:content-type` | `string` | `"text/plain"` | `hbw-entry-content-type` | 本文の記法 (content 要素の type 属性) |
| `categories` | `:categories` | `list` | `nil` | `hbw-entry-categories` | カテゴリのリスト (文字列のリスト) |
| `draft-p` | `:draft-p` | `boolean` | `nil` | `hbw-entry-draft-p` | 下書き状態 (`t`=下書き, `nil`=公開済み) |
| `hatena-id` | `:hatena-id` | `string` or `nil` | `nil` | `hbw-entry-hatena-id` | はてなID (URIから抽出) |
| `blog-id` | `:blog-id` | `string` or `nil` | `nil` | `hbw-entry-blog-id` | ブログID (URIから抽出) |

### コンストラクタ

通常は `hbw-entry-from-xml` で API レスポンスから生成する。

```elisp
;; API レスポンスの XML から生成
(hbw-entry-from-xml xml-entry)

;; 直接生成
(hbw-entry :entry-id "10328749687211177806"
           :uri "https://blog.hatena.ne.jp/user/blog.hatenablog.com/atom/entry/10328749687211177806"
           :title "記事のタイトル"
           :content "記事の本文"
           :draft-p nil
           :hatena-id "user"
           :blog-id "blog.hatenablog.com")
```

### メソッド

#### hbw-entry-status-string

```
hbw-entry-status-string (entry hbw-entry) => string
```

エントリーの状態を文字列で返す。

```elisp
(hbw-entry-status-string entry)
;; => "published" or "draft"
```

#### hbw-entry-published-date

```
hbw-entry-published-date (entry hbw-entry) => string or nil
```

公開日時から日付部分 (`yyyy-mm-dd`) を返す。

```elisp
(hbw-entry-published-date entry)
;; => "2024-01-15" or nil
```

### 型述語

```elisp
(hbw-entry-p obj) ;; => t or nil
```

### 永続化

- 保存先: `~/.hatena/blog/{user-id}/{blog-id}/{entry-id}/master.el`
- 形式: `format "%S"` による S式
- 読み込み時に旧 XML ノード形式 (`(entry ATTRS CHILDREN...)`) は自動変換される
- `contents.md` は別途保存 (1行目: タイトル、2行目以降: 本文)

### API レスポンスとの対応

| スロット | AtomPub XML 要素 |
|----------|-----------------|
| `entry-id` | `link[rel='edit']` の href からパースした ID 部分 |
| `uri` | `link[rel='edit']` の href |
| `alternate-uri` | `link[rel='alternate']` の href |
| `author-name` | `author` > `name` |
| `title` | `title` |
| `updated` | `updated` |
| `published` | `published` |
| `edited` | `app:edited` |
| `summary` | `summary` |
| `content` | `content` のテキスト |
| `content-type` | `content` の `type` 属性 |
| `categories` | `category` の `term` 属性 (複数) |
| `draft-p` | `app:control` > `app:draft` (`"yes"` → `t`, `"no"` → `nil`) |
