# hatena-blog-writer

はてなブログを書くための emacs lisp です。

[Hatena Blog API](http://developer.hatena.ne.jp/ja/documents/blog/apis/atom) をコールします。

こんな感じのメジャーモードを作成します。

```
operators  | HATENA BLOG WRITE
--------   | User: yanqirenshi
Load       | Blog: ほんとのこと知りたいだけなのに。
 - l       |
Refresh    | Entries:
 - r       | state   id                   date       title
 - R (all) | ------ -------------------- ---------- -------------------------------------
Diff       | public 10328749687211177806 yyyy-mm-dd Windows10 でインストールするもの 2017
 - d       | draft  10328749687213322003 yyyy-mm-dd Windows で出来ること。
Remove     | public 8599973812294243134  yyyy-mm-dd Windows で trival-ssh が出来ない件
 - k       | public 8599973812306181606  yyyy-mm-dd 業務系システムの保守/運用 で仙人が誕生する理由
           | public 8599973812306194999  yyyy-mm-dd 続:Windows で trival-ssh が出来ない件
           | public 8599973812314613904  yyyy-mm-dd Niginx の config の場所(openSUSE Tumbleweed)
           | public 8599973812331070463  yyyy-mm-dd Emacs Lisp のリスト操作オペレータの一覧
           | public 8599973812331392703  yyyy-mm-dd Emacs Lisp 制御構造のオペレータ一覧
           | public 8599973812331486790  yyyy-mm-dd Emacs Lisp のバッファ関連のオペレータ
           | draft  8599973812332698050  yyyy-mm-dd Emacs Lisp の非ASCII文字関連のオペレータ
           | [more...]
```

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

[ドキュメント](https://yanqirenshi.github.io/hatena-blog-writer/) 参照
