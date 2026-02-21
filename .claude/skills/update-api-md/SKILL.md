---
name: update-api-md
description: API 関連の関数・変数の追加・変更・削除があった場合に API.md を更新する。API 関連のコードを変更した後に自動的に呼び出される。
allowed-tools: Read, Grep, Glob, Edit, Write
---

# API.md 更新スキル

## 目的

API 関連のソースファイルと `API.md` の内容を同期させる。

## 対象ファイル

- `src/api/uri.el` — URI 生成関数
- `src/api/header.el` — 認証ヘッダ生成関数
- `src/api/request.el` — リクエストラッパーとデフォルトコールバック変数
- `src/api/result.el` — レスポンス結果取得関数
- `src/api/response.el` — XML レスポンス抽出関数
- `src/api/xml.el` — XML クリーンアップ、テンプレート、タグビルド関数
- `src/entry/entry-xml.el` — XML → hbw-entry 変換関数
- `src/entry/api-entry-get.el` — 単一エントリー取得 (GET)
- `src/entry/api-entry-find.el` — 複数エントリー取得 (GET)
- `src/entry/api-entry-post.el` — 新規投稿 (POST)
- `src/entry/api-entry-put.el` — 更新 (PUT)
- `src/variables.el` — グローバル変数

## 手順

1. 対象ファイルを読み込み、全ての `defun`, `defvar`, `defconst` 定義を把握する
2. 現在の `API.md` を読み込む
3. 差分を特定し、`API.md` を更新する

## API.md の記述フォーマット

以下のフォーマットに厳密に従うこと。

### ファイル全体の構造

```markdown
# API

hatena-blog-writer で定義されている API 関連の関数・変数の一覧です。

## ファイル構成

| ファイル | 役割 |
|----------|------|
| `ファイルパス` | 役割の説明 |

---

## セクション名

定義ファイル: `ファイルパス`

### 関数名

\```
関数名 (引数リスト) => 戻り値の型
\```

関数の説明。

\```elisp
使用例
\```
```

### 各セクションに含める項目

1. **エンドポイントと URI** — URI 生成関数群
2. **認証ヘッダ** — Basic 認証ヘッダ生成関数群
3. **リクエスト** — デフォルトコールバック変数、リクエストラッパー
4. **レスポンス処理** — result と response の抽出関数群
5. **XML 処理** — XML クリーンアップ、テンプレート、タグビルド
6. **XML → hbw-entry 変換** — `hbw-entry-from-xml` とヘルパー関数
7. **エントリー操作 API** — GET/POST/PUT の各操作
8. **グローバル変数** — `src/variables.el` の変数
9. **データフロー** — 取得/投稿/認証のデータフロー図

### 関数ドキュメントの記述規則

- シグネチャはコードブロックで記述: `関数名 (引数) => 戻り値の型`
- 引数が多い場合はテーブルで列挙: `| 引数 | 型 | 説明 |`
- key-params がある場合は別テーブルで列挙
- 使用例は `elisp` コードブロックで記述

## 注意事項

- 日本語で記述する
- コード例は実際に動作するものにする
- `defun` の docstring に書かれた説明をベースにする
- 関数の順序はセクション内で定義順に従う
- 内部関数（`%` プレフィクス付き）は原則として記載しないが、重要なものは記載する
- データフロー図は ASCII アートで記述する
