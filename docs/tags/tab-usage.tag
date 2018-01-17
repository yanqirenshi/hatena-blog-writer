<tab-usage>
    <app-section title="Initial setting" level="2">
        <app-section title="Initial setting" level="3">
            <div class="content">
                <p>ユーザーを追加する。</p>
                <pre>
(hatena-blog-writer-add-user (hatena-blog-writer-make-user "yanqirenshi" "岩崎仁是"))
                </pre>
            </div>
        </app-section>

        <app-section title="Initial setting" level="3">
            <div class="content">
                <p>ブログをを追加する。</p>
                <p>まだ手作業での追加になります。<br/>そのうちそのうち。</p>
                <pre>
(hatena-blog-writer-add-blog (hatena-blog-writer-make-blog "yanqirenshi.hatenablog.com"
                                                           "ほんとのこと知りたいだけなのに。"
                                                           "your-hatena-blog-api-key")
                </pre>
            </div>
        </app-section>

        <app-section title="Initial setting" level="3">
            <div class="content">
                <p>カレントユーザーを指定する</p>
                <pre>
(hatena-blog-writer-change-user "yanqirenshi")
(hatena-blog-writer-change-blog "yanqirenshi.hatenablog.com")
                </pre>
            </div>
        </app-section>
    </app-section>

    <app-section title="Lisp operators" level="2">
        <app-section title="エントリの取得" level="3">
            <div class="content">
                <p>
                    <b><a>hatena-blog-writer-api-entry-get</a></b> で取得します。
                </p>
                <p>
                    取得したエントリの情報はローカルに保管されます。<br/>
                    master.el と contents.md の二つのファイルです。
                </p>
                <p>
                    ブログの執筆は contents.md に対して行います。<br/>
                </p>
                <p>
                    masgter.el に関してはユーザーが直接利用することはありません。<br/>
                    差分を取得したりするのに利用しようかと考えています。
                </p>
                <pre>
Ex)
(hatena-blog-writer-api-entry-get *hatena-blog-writer-current-user*
                                  *hatena-blog-writer-current-blog*
                                  "8599973812337687510")
                </pre>
            </div>
        </app-section>

        <app-section title="エントリの検索" level="3">
            <div class="content">
                <div class="content">
                    <div class="content">
                        <p>
                            <b><a>hatena-blog-writer-api-entry-find</a></b> で検索します。
                        </p>
                        <p>
                            この関数では検索条件が指定できるようにしようと思いますが、現時点(2018-01-17 Wed)では未実装です。
                        </p>
                        <pre>
Ex)
(hatena-blog-writer-api-entry-find *hatena-blog-writer-current-user*
                                   *hatena-blog-writer-current-blog*)
                        </pre>
                    </div>
                </div>
            </div>
        </app-section>

        <app-section title="エントリの追加" level="3">
            <div class="content">
                <div class="content">
                    <p>
                        <b><a>hatena-blog-writer-api-entry-post</a></b> で追加します。
                    </p>
                    <p>
                        カレントバッファから直接 PUSH しても良さそうなもんですが、そのオペレータは設けていません。<br/>
                        エントリの追加は基本メジャーモードからの操作にするので。<br/>
                        特定のディレクトリに配置する必要があるので、少々面倒くさいということもあります。
                    </p>
                    <pre>
Ex)
(hatena-blog-writer-api-entry-post *hatena-blog-writer-current-user*
                                   *hatena-blog-writer-current-blog*
                                   (hatena-blog-writer-build-post-xml *hatena-blog-writer-current-user*
                                                                      "title" "contents" '("ca" "te" "go" "ries") "yes"))

                    </pre>
                </div>
            </div>
        </app-section>

        <app-section title="エントリの更新" level="3">
            <div class="content">
                <p>
                    <b><a>hatena-blog-writer-api-entry-put</a></b> で更新します。
                </p>
                <p>
                    更新方法は、更新前に最新の状態として WEB からエントリの情報を取得します。<br/>
                    そして取得したエントリの内容のタイトルとコンテンツをローカルの内容に置き換えて WEB にアップロードしています。
                </p>
                <pre>
Ex)
(hatena-blog-writer-api-entry-put *hatena-blog-writer-current-user*
                                  *hatena-blog-writer-current-blog*
                                  "8599973812337687510")
                </pre>
            </div>
        </app-section>

        <app-section title="エントリの削除" level="3">
            <div class="content">
                <P>未実装</P>
            </div>
        </app-section>

        <app-section title="エントリの公開/非公開の切り替え" level="3">
            <div class="content">
                <P>未実装</P>
            </div>
        </app-section>

        <app-section title="エントリのタグ管理" level="3">
            <div class="content">
                <P>未実装</P>
            </div>
        </app-section>
    </app-section>
</tab-usage>
