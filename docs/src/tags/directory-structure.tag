<directory-structure>
    <app-section title="Description">
        <div class="content">
            <p>
                HATENA-BLOG-WRITE は Web 上のエントリーをローカルにダウンロードして管理します。
            </p>
            <p>
                ここではローカルのダウンロード先のディレクトリ構成について説明します。
            </p>
        </div>
    </app-section>
    <app-section title="Directory">
        <div class="content">
            以下の構成でフォルダを構成します。
            <pre>
~/.hatena
　　└ blog/
　　　　└ \{hatena-id\}
　　　　　　├ \{blog-id\}
　　　　　　│　　├ published
　　　　　　│　　│　　├ \{entry-id\}
　　　　　　│　　│　　│　　├ master.lisp
　　　　　　│　　│　　│　　├ contents.md
　　　　　　│　　│　　│　　└ title.txt
　　　　　　│　　│
　　　　　　│　　├ draft
　　　　　　│　　│　　├ \{entry-id\}
　　　　　　│　　│　　│　　├ master.lisp
　　　　　　│　　│　　│　　├ contents.md
　　　　　　│　　│　　│　　└ title.txt
            </pre>
        </div>

        <app-section title="master.lisp">
            <div class="content">
                <p>
                    Web 上のエントリの情報。
                </p>
                <p>
                    最後にダウンロードした情報が含まれる。</br>
                    「refresh (仮名)」すると最新の情報になる。
                </p>
            </div>
        </app-section>

        <app-section title="contents.md">
            <div class="content">
                <p>
                    ブログの本文。
                </p>
                <p>
                    基本ブログを書く場合はこのファイルを更新します。</br>
                    「push (仮名)」ではこのファイルをWEB上にアップロードします。</br>
                    アップロードは上書きです。
                </p>
                <p>
                    master.lisp と差分を取ることが可能です。</br>
                    Web へのアップロードは上書きしかないのでこの差分確認機能で事前に確認する必要があります。
                </p>
            </div>
        </app-section>

        <app-section title="title.txt">
            <div class="content">
                <p>
                    ブログのタイトル。
                </p>
                <p>
                    ブログのタイトルを変更する場合はこのファイルを更新します。
                </p>
                <p>
                    「push (仮名)」ではこのファイルをWEB上にアップロードします。</br>
                    複数行ある場合は全行を一行にしてアップロードします。
                </p>
                <p>
                    master.lisp と差分を取ることが可能です。</br>
                    Web へのアップロードは上書きしかないのでこの差分確認機能で事前に確認する必要があります。
                </p>
            </div>
        </app-section>
    </app-section>
</directory-structure>
