# hatena-blog-writer

はてなブログを書くための emacs lisp です。

[Hatena Blog API](http://developer.hatena.ne.jp/ja/documents/blog/apis/atom) をコールします。

`M-x hatena-blog-writer` でメジャーモードを起動します。

```
HATENA BLOG WRITER
User: やんきれんし (yanqirenshi)
Blog: ほんとのこと知りたいだけなのに。 (example.hatenablog.com)

Entries:
  status    date       title
  --------- ---------- ----------------------------------------
  published 2024-01-15 Windows10 でインストールするもの 2017
  draft     2024-01-10 Windows で出来ること。
  published 2024-01-08 Windows で trival-ssh が出来ない件
  published 2024-01-05 業務系システムの保守/運用 で仙人が誕生する理由
  ...
```

### キーバインド

| キー | コマンド | 説明 |
|------|---------|------|
| `l` | Load | API から全エントリーを取得 |
| `r` | Refresh | ローカルデータでバッファを再描画 |
| `R` | Refresh all | API から再取得して再描画 |
| `d` | Diff | ローカルとサーバーの差分を表示 |
| `k` | Remove | ローカルファイルを削除 |
| `RET` | Open | contents.md を開く |
| `q` | Quit | バッファを閉じる |
| `?` | Help | キーバインド一覧を表示 |

# Usage

使いかたは、以下二つの流れがあります。

1. Server 上でエントリーを作成し、それを `get (download)` してローカルに保存し、それを編集する。
2. Local でエントリーを `create` し、それを Server に push する。

以下がおおまかな構成/流れになります。

``` text
Server                      : Local
                            :
+-------------+             :                 +--------file-+
| Hatena Blog |----First get (download)------>| master.lisp |
|             |----Refresh ------------------>|             |
|             |             :                 +-------------+
|             |             :                        |
|             |             :                       copy (たぶん)
|             |             :                        |
|             |             :                        V
|             |             :                 +--------file-+            +--------------+
|             |<---Push----------------------o| contents.md |<---Edit---o| User (emacs) |
+-------------+             :                 +-------------+            +--------------+
                            :
```

## Dependencies

| package | Description |
|---------|-------------|
| xml     |             |
| url     |             |
| request |             |
| s       |             |
| f       |             |

## Documents

| ドキュメント | 説明 |
|-------------|------|
| [API.md](./API.md) | API 関連の関数・変数・データフロー |
| [CLASSES.md](./CLASSES.md) | EIEIO クラス定義（hbw-user, hbw-blog, hbw-entry） |
| [OPERATORS.md](./OPERATORS.md) | 全関数の詳細リファレンス（HyperSpec スタイル） |
| [VARIABLES.md](./VARIABLES.md) | グローバル変数・定数の一覧 |
