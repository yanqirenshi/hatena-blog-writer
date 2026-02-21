---
name: update-variables-md
description: defvar / defconst の追加・変更・削除があった場合に VARIABLES.md を更新する。変数定義を変更した後に自動的に呼び出される。
allowed-tools: Read, Grep, Glob, Edit, Write
---

# VARIABLES.md 更新スキル

## 目的

全ソースファイルの `defvar` / `defconst` 定義と `VARIABLES.md` の内容を同期させる。

## 手順

1. 全ソースファイルから `defvar` / `defconst` 定義を検索して把握する
2. 現在の `VARIABLES.md` を読み込む
3. 差分を特定し、`VARIABLES.md` を更新する

## VARIABLES.md の記述フォーマット

以下のフォーマットに厳密に従うこと。

### ファイル全体の構造

```markdown
# VARIABLES

hatena-blog-writer で定義されているグローバル変数の一覧です。

## 変数一覧

| 変数 | 定義ファイル | 説明 |
|------|-------------|------|
| `変数名` | `ファイルパス` | 説明 |

---

## セクション名

定義ファイル: `ファイルパス`

### 変数名

\```elisp
(defvar 変数名 初期値)
\```

- **型**: 型の説明
- **初期値**: 初期値
- **説明**: 変数の説明
- **更新元**: この変数を更新する関数
- **参照元**: この変数を参照する関数
```

### 各変数に含める項目

1. **定義コード** — `defvar` / `defconst` のコード
2. **型** — 変数の型
3. **初期値** — 初期値（`defconst` の場合は定数値）
4. **説明** — 変数の用途
5. **更新元** — この変数を `setq` / `setf` で更新する関数（該当する場合）
6. **参照元** — この変数を参照する関数

### セクション分類

- **アプリケーション状態変数** — `src/variables.el` の変数
- **API デフォルトコールバック変数** — `src/api/request.el` の変数
- **XML テンプレート定数** — `src/api/xml.el` の定数

## 注意事項

- 日本語で記述する
- `defvar` の docstring に書かれた説明をベースにする
- 変数の順序は定義ファイル内での定義順に従う
- `defconst` は定数として明示する
- 更新元・参照元は `Grep` で確認して正確に記載する
