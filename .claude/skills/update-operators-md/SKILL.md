---
name: update-operators-md
description: defun の追加・変更・削除があった場合に OPERATORS.md を更新する。関数定義を変更した後に自動的に呼び出される。
allowed-tools: Read, Grep, Glob, Edit, Write
---

# OPERATORS.md 更新スキル

## 目的

全ソースファイルの `defun` 定義と `OPERATORS.md` の内容を同期させる。

## 手順

1. 全ソースファイルから `defun` 定義を検索して把握する
2. 各関数のシグネチャ、docstring、引数の型を把握する
3. 現在の `OPERATORS.md` を読み込む
4. 差分を特定し、`OPERATORS.md` を更新する

## OPERATORS.md の記述フォーマット

Common Lisp HyperSpec スタイルで記述する。

### ファイル全体の構造

```markdown
# OPERATORS

hatena-blog-writer で定義されている関数の一覧です。

## 関数一覧

### カテゴリ名

| 関数 | 定義ファイル | 説明 |
|------|-------------|------|
| `関数名` | `ファイルパス` | 説明 |

---

## カテゴリ名

定義ファイル: `ファイルパス`

### 関数名

**Syntax:**

\```
関数名 (引数リスト) => 戻り値の型
\```

**Arguments and Values:**

| 引数 | 型 | 説明 |
|------|------|------|
| `引数名` | 型 | 説明 |
| 戻り値 | 型 | 説明 |

**Description:**

関数の説明。

**Examples:**

\```elisp
使用例
\```

**Affected By:**

影響を受ける変数。

**Exceptional Situations:**

エラーが発生する条件。

**See Also:**

関連する関数。

**Notes:**

補足事項。
```

### 各関数ドキュメントに含めるセクション（該当する場合のみ）

1. **Syntax** — 必須。シグネチャをコードブロックで記述
2. **Arguments and Values** — 引数がある場合。テーブル形式
3. **Description** — 必須。関数の説明
4. **Examples** — 重要な関数に対して。elisp コードブロック
5. **Affected By** — グローバル変数に影響される場合
6. **Exceptional Situations** — エラーを発生させる場合
7. **See Also** — 関連する関数がある場合
8. **Notes** — 補足事項がある場合

### カテゴリ分類

- **ユーザー管理** — `src/user.el`
- **ブログ管理** — `src/blog.el`
- **ユーティリティ** — `src/utility.el`
- **ファイル操作 (共通)** — `src/filer/common.el`
- **ファイル操作 (ユーザー永続化)** — `src/filer/users.el`
- **ファイル操作 (ブログ永続化)** — `src/filer/blogs.el`
- **ファイル操作 (エントリー永続化)** — `src/filer/entry-master.el`, `src/filer/entry-contents.el`
- **エントリーファイル** — `src/entry/entry.file.el`
- **エントリーユーティリティ** — `src/entry/entry.el`
- **API — URI** — `src/api/uri.el`
- **API — 認証ヘッダ** — `src/api/header.el`
- **API — リクエスト** — `src/api/request.el`
- **API — レスポンス** — `src/api/result.el`, `src/api/response.el`
- **API — XML** — `src/api/xml.el`
- **API — XML → hbw-entry 変換** — `src/entry/entry-xml.el`
- **API — エントリー操作 (GET/FIND/POST/PUT)** — `src/entry/api-entry-*.el`
- **メジャーモード** — `src/mode/major.el`, `src/mode/major-buffer.el`, `src/mode/major-buffer-fields.el`

## 注意事項

- 日本語で記述する
- コード例は実際に動作するものにする
- `defun` の docstring に書かれた説明をベースにする
- 内部関数（`%` プレフィクス付き）は原則として記載しない
- 関数の順序はカテゴリ内で定義ファイルの定義順に従う
- `interactive` 関数は `[interactive]` を Syntax に付記する
