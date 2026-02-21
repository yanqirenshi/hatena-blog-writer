## Conversation Guidelines

- 常に日本語で会話する
- 技術的な説明も日本語で行う
- コード内のコメントは日本語で記述
- エラーメッセージの解説は日本語で
- README.mdなどのドキュメントも日本語で作成

## OPERATORS.md の維持

- `defun` を追加・変更・削除した場合は、必ず `/update-operators-md` スキルを実行して OPERATORS.md を更新すること
- OPERATORS.md は Common Lisp HyperSpec スタイルで記述する (Syntax / Arguments and Values / Description / Examples / Affected By / Exceptional Situations / See Also / Notes)
- 内部関数（`%` プレフィクス付き）は原則として記載しない
- ソースコードと OPERATORS.md の内容は常に一致していなければならない

## VARIABLES.md の維持

- `defvar`, `defconst` を追加・変更・削除した場合は、必ず `/update-variables-md` スキルを実行して VARIABLES.md を更新すること
- 変数の型変更、初期値変更、新規変数の追加、変数の削除が対象
- 更新元・参照元の関数も正確に記載すること
- ソースコードと VARIABLES.md の内容は常に一致していなければならない

## CLASSES.md の維持

- `defclass` や `cl-defmethod` を追加・変更・削除した場合は、必ず `/update-classes-md` スキルを実行して CLASSES.md を更新すること
- スロットの追加・削除・型変更、メソッドの追加・削除・シグネチャ変更が対象
- ソースコード (`src/classes.el`) と CLASSES.md の内容は常に一致していなければならない

## API.md の維持

- `src/api/` 配下、`src/entry/api-entry-*.el`、`src/entry/entry-xml.el`、`src/variables.el` の `defun`, `defvar`, `defconst` を追加・変更・削除した場合は、必ず `/update-api-md` スキルを実行して API.md を更新すること
- 関数のシグネチャ変更、引数の追加・削除、新規関数の追加、変数の追加・削除が対象
- ソースコードと API.md の内容は常に一致していなければならない

## README.md の維持

- `API.md`, `CLASSES.md`, `OPERATORS.md`, `VARIABLES.md` のいずれかが変更された場合は、必ず `/update-readme-md` スキルを実行して README.md を更新すること
- Documents セクションの各ドキュメントの説明を最新に保つこと
- 詳細は各ドキュメントに委譲し、README.md は概要レベルに留めること

