---
name: update-readme-md
description: API.md, CLASSES.md, OPERATORS.md, VARIABLES.md が変更された場合に README.md を更新する。各ドキュメントの更新後に自動的に呼び出される。
allowed-tools: Read, Grep, Glob, Edit, Write
---

# README.md 更新スキル

## 目的

`API.md`, `CLASSES.md`, `OPERATORS.md`, `VARIABLES.md` の内容変更を `README.md` に反映させる。

## 手順

1. `API.md`, `CLASSES.md`, `OPERATORS.md`, `VARIABLES.md` を読み込み、変更内容を把握する
2. 現在の `README.md` を読み込む
3. README.md の該当セクションを更新する

## README.md で更新対象となるセクション

### Documents セクション

各ドキュメントへのリンクと概要を最新の状態に保つ。

### Dependencies セクション

依存パッケージに変更があれば更新する。

### Usage セクション

API やクラスの使い方に大きな変更があれば反映する。

## README.md の記述ルール

- 日本語で記述する
- プロジェクトの概要、使い方、依存パッケージ、ドキュメントリンクを含める
- Documents セクションには `API.md`, `CLASSES.md`, `OPERATORS.md`, `VARIABLES.md` の一覧と各ドキュメントの簡潔な説明を記載する
- コード例は実際に動作するものにする
- 過度に詳細な情報は各ドキュメント（API.md, CLASSES.md 等）に委譲し、README.md は概要レベルに留める

## 注意事項

- README.md の既存の構造（セクション順序、フォーマット）を尊重する
- 大幅な構造変更は行わず、内容の同期に徹する
- 各ドキュメントの詳細な内容を README.md に複製しない（リンクで参照させる）
