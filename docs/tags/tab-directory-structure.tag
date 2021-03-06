<tab-directory-structure>
    <app-section title="Description" level="2">
        <div class="content">
            <p>
                HATENA-BLOG-WRITE は Web 上のエントリーをローカルにダウンロードして管理します。
            </p>
            <p>
                ここではローカルのダウンロード先のディレクトリ構成について説明します。
            </p>
        </div>
    </app-section>

    <app-section title="Directory" level="2">
        <div class="content">
            以下の構成でフォルダを構成します。
            <pre>
~/.hatena
　　├ blog/
　　│　　├ config/
　　│　　│　├ users.lisp
　　│　　│　└ blogs.lisp
　　│　　│
　　│　　└ \{hatena-id\}
　　│　　　　├ \{blog-id\}
　　│　　　　│　　├ published
　　│　　　　│　　│　　├ \{entry-id\}
　　│　　　　│　　│　　│　　├ master.lisp
　　│　　　　│　　│　　│　　└ contents.md
　　│　　　　│　　│
　　│　　　　│　　├ draft
　　│　　　　│　　│　　├ \{entry-id\}
　　│　　　　│　　│　　│　　├ master.lisp
　　│　　　　│　　│　　│　　└ contents.md
            </pre>
        </div>

        <app-section title="users.lisp" level="3">
            <div class="content">
            </div>
        </app-section>

        <app-section title="blogs.lisp" level="3">
            <div class="content">
            </div>
        </app-section>

        <app-section title="master.lisp" level="3">
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

        <app-section title="contents.md" level="3">
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
                    このファイルの一行目はブログのタイトルになります。
                    二行目以降をブログのコンテンツとして扱います。
                </p>
                <p>
                    master.lisp と差分を取ることが可能です。</br>
                    Web へのアップロードは上書きしかないのでこの差分確認機能で事前に確認する必要があります。
                </p>
            </div>
        </app-section>
    </app-section>

    <app-section title="Symbols" level="2" operators={this.opts.operators}>
        <operators operators={this.opts.operators}
                   files={["filer.el"]}></operators>
    </app-section>
</tab-directory-structure>
