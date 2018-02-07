riot.tag2('app-tab-item', '<li class="{this.isActive()}"> <a href="#{this.opts.code}"> <span>{this.opts.name}</span> </a> </li>', 'app-tab-item li { margin-left: 22px; }', '', function(opts) {
     this.isActive = function () {
         return this.opts.active==this.opts.code ? 'is-active' : '';
     };
});

riot.tag2('app-tabs', '<section class="section" style="padding-top: 8px;padding-bottom: 8px;"> <div class="container"> <div class="tabs is-boxed"> <ul> <app-tab-item each="{STORE.state().tabs}" code="{code}" name="{name}" active="{STORE.state().contents}"></app-tab-item> </ul> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('app', '<link-git-repository></link-git-repository> <app-header title="HATENA BLOG WRITER" subtitle="はてなブログを書くための emacs lisp です。"></app-header> <app-tabs click="{this.clickTab}" active="{STORE.get(\'contents\')}"></app-tabs> <tab-readme class="{this.display(\'readme\')}"></tab-readme> <tab-usage class="{this.display(\'usage\')}"></tab-usage> <tab-major-mode class="{this.display(\'major-mode\')}"></tab-major-mode> <tab-minor-mode class="{this.display(\'minor-mode\')}"></tab-minor-mode> <tab-data-structures class="{this.display(\'data-structures\')}" variables="{STORE.get(\'variables\')}"></tab-data-structures> <tab-directory-structure class="{this.display(\'directory-structure\')}" operators="{STORE.get(\'operators\')}"></tab-directory-structure> <tab-symbols class="{this.display(\'symbols\')}" operators="{STORE.get(\'operators\')}" variables="{STORE.get(\'variables\')}"></tab-symbols> <app-footer></app-footer>', 'app .hide,[data-is="app"] .hide{ display: none; }', '', function(opts) {
     this.display = function (name) {
         return STORE.get('contents')==name ? 'show' : 'hide';
     };

     STORE.subscribe(function (action) {
         this.update();
     }.bind(this));
});

riot.tag2('app-footer', '<footer class="footer"> <div class="container"> <div class="content has-text-centered"> <p> <strong>hatena-blog-writer</strong> by <a href="https://github.com/yanqirenshi">yanqirenshi</a>. </p> <p> The source code is licensed <a href="https://opensource.org/licenses/GPL-3.0">GNU General Public License v3.0 </p> </div> </div> </footer>', '', '', function(opts) {
});

riot.tag2('app-header', '<section class="hero"> <div class="hero-body" style="padding: 22px 11px;"> <div class="container"> <h1 class="title is-1" style="color: #6550EC;"> {this.opts.title} </h1> <h2 class="subtitle"> {this.opts.subtitle} </h2> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('app-section', '<section class="section"> <div class="container"> <h1 class="title {this.level()}">{this.opts.title}</h1> <p class="subtitle"></p> <yield></yield> </div> </section>', '', '', function(opts) {
     this.level = function () {
         var l = this.opts.level;
         if (l) return 'is-' + l;
         return 'is-3'
     }
});

riot.tag2('command-list', '<table class="table is-bordered is-striped is-narrow is-hoverable"> <thead> <tr> <th>Command</th> <th>Description</th> </tr> </thead> <tbody> <tr each="{this.opts.commands}"> <td>{command}</td> <td>{description}</td> </tr> </tbody> </table>', '', '', function(opts) {
});

riot.tag2('description', '<app-section title="Description" level="2"> <div class="content"> <p> はてなブログとローカルのディレクトリの同期を取ります。 </p> <p> 基本的にユーザーはローカルでブログを編集します。 そこで編集した情報をはてなブログへ push します。 </p> </div> </app-section>', '', '', function(opts) {
});

riot.tag2('link-git-repository', '<div style="position: fixed; top: 0; right: 0;"> <a href="https://github.com/yanqirenshi/hatena-blog-writer"> <svg width="80" height="80" viewbox="0 0 250 250" style="fill: #6550EC; color: #fff;"> <path d="M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z"></path> <path d="M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2" fill="currentColor" style="transform-origin: 130px 106px;" class="octo-arm"> </path> <path d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z" fill="currentColor" class="octo-body"> </path> </svg> </a> </div>', '', '', function(opts) {
});

riot.tag2('operators-list', '<table class="table is-bordered is-striped is-narrow is-hoverable"> <thead> <th>type</th> <th>symbol</th> <th>description</th> <th>file</th> </thead> <tbody> <tr each="{this.filter(this.opts)}"> <td>{type}</td> <td style="white-space: nowrap;"><b>{symbol}</b></td> <td>{description}</td> <td style="white-space: nowrap;">{file}</td> </tr> </tbody> </table>', '', '', function(opts) {
     this.query = function (data, files) {
         if (files)
             return L.find(data.file, files, function (a,b) {
                 return a == b;
             })

         return true;
     }.bind(this);

     this.filter = function (opts) {
         var out = [];

         var data = opts.data;
         var files = opts.files;

         for (var i in data)
             if (this.query(data[i], files))
                 out.push(data[i]);

         return out;
     }.bind(this);
});

riot.tag2('operators', '<section class="section"> <div class="container"> <h1 class="title">Operators</h1> <h2 class="subtitle"></h2> <section class="section"> <div class="container"> <operators-list data="{this.opts.operators}" files="{this.opts.files}"></operators-list> </div> </section> </div> </section>', '', '', function(opts) {
});

riot.tag2('screen-image', '<pre>\noperators  | HATENA BLOG WRITE\n--------   | User: yanqirenshi\nLoad       | Blog: ほんとのこと知りたいだけなのに。\n - l       |\nRefresh    | Entries:\n - r       | state   id                   date       title\n - R (all) | ------ -------------------- ---------- -------------------------------------\nDiff       | public 10328749687211177806 yyyy-mm-dd Windows10 でインストールするもの 2017\n - d       | draft  10328749687213322003 yyyy-mm-dd Windows で出来ること。\nRemove     | public 8599973812294243134  yyyy-mm-dd Windows で trival-ssh が出来ない件\n - k       | public 8599973812306181606  yyyy-mm-dd 業務系システムの保守/運用 で仙人が誕生する理由\n           | public 8599973812306194999  yyyy-mm-dd 続:Windows で trival-ssh が出来ない件\n           | public 8599973812314613904  yyyy-mm-dd Niginx の config の場所(openSUSE Tumbleweed)\n           | public 8599973812331070463  yyyy-mm-dd Emacs Lisp のリスト操作オペレータの一覧\n           | public 8599973812331392703  yyyy-mm-dd Emacs Lisp 制御構造のオペレータ一覧\n           | public 8599973812331486790  yyyy-mm-dd Emacs Lisp のバッファ関連のオペレータ\n           | draft  8599973812332698050  yyyy-mm-dd Emacs Lisp の非ASCII文字関連のオペレータ\n           | [more...]\n    </pre>', '', '', function(opts) {
});

riot.tag2('variables', '<section class="section"> <div class="container"> <h1 class="title">Variables</h1> <h2 class="subtitle"></h2> <section class="section"> <div class="container"> <operators-list data="{this.opts.variables}" files="{this.opts.files}"></operators-list> </div> </section> </div> </section>', '', '', function(opts) {
});

riot.tag2('tab-data-structures', '<app-section title="Description" level="2"> <p> 三つのデータがあります。 </p> <table class="table is-bordered is-striped is-narrow is-hoverable"> <thead> <tr> <th>class</th> <th>description</th> </tr> </thead> <tbody> <tr> <td>user</td> <td>はてなユーザー</td> </tr> <tr> <td>blog</td> <td>ブログ</td> </tr> <tr> <td>entry</td> <td>ブログ・エントリー</td> </tr> </tbody> </table> </app-section> <app-section title="Lisp" level="2"> <app-section title="はてなユーザー"> <pre>(:id "..." :name "..." :class "user")</pre> </app-section> <app-section title="ブログ"> <pre>(:id "..." :name "..." :class "blog" :api-key)</pre> </app-section> <app-section title="ブログ・エントリー"> <pre>(:id "..." :title "..." :contents "..." :class "entry")</pre> </app-section> </app-section> <app-section title="Symbols" level="2" variables="{this.opts.variables}"> <variables variables="{this.opts.variables}" files="{[⁗hatena-blog-writer.el⁗]}"></variables> </app-section>', '', '', function(opts) {
});

riot.tag2('tab-directory-structure', '<app-section title="Description" level="2"> <div class="content"> <p> HATENA-BLOG-WRITE は Web 上のエントリーをローカルにダウンロードして管理します。 </p> <p> ここではローカルのダウンロード先のディレクトリ構成について説明します。 </p> </div> </app-section> <app-section title="Directory" level="2"> <div class="content"> 以下の構成でフォルダを構成します。 <pre>\n~/.hatena\n　　├ blog/\n　　│　　├ config/\n　　│　　│　├ users.lisp\n　　│　　│　└ blogs.lisp\n　　│　　│\n　　│　　└ \\{hatena-id\\}\n　　│　　　　├ \\{blog-id\\}\n　　│　　　　│　　├ published\n　　│　　　　│　　│　　├ \\{entry-id\\}\n　　│　　　　│　　│　　│　　├ master.lisp\n　　│　　　　│　　│　　│　　└ contents.md\n　　│　　　　│　　│\n　　│　　　　│　　├ draft\n　　│　　　　│　　│　　├ \\{entry-id\\}\n　　│　　　　│　　│　　│　　├ master.lisp\n　　│　　　　│　　│　　│　　└ contents.md\n            </pre> </div> <app-section title="users.lisp" level="3"> <div class="content"> </div> </app-section> <app-section title="blogs.lisp" level="3"> <div class="content"> </div> </app-section> <app-section title="master.lisp" level="3"> <div class="content"> <p> Web 上のエントリの情報。 </p> <p> 最後にダウンロードした情報が含まれる。</br> 「refresh (仮名)」すると最新の情報になる。 </p> </div> </app-section> <app-section title="contents.md" level="3"> <div class="content"> <p> ブログの本文。 </p> <p> 基本ブログを書く場合はこのファイルを更新します。</br> 「push (仮名)」ではこのファイルをWEB上にアップロードします。</br> アップロードは上書きです。 </p> <p> このファイルの一行目はブログのタイトルになります。 二行目以降をブログのコンテンツとして扱います。 </p> <p> master.lisp と差分を取ることが可能です。</br> Web へのアップロードは上書きしかないのでこの差分確認機能で事前に確認する必要があります。 </p> </div> </app-section> </app-section> <app-section title="Symbols" level="2" operators="{this.opts.operators}"> <operators operators="{this.opts.operators}" files="{[⁗filer.el⁗]}"></operators> </app-section>', '', '', function(opts) {
});

riot.tag2('tab-major-mode', '<app-section title="Description" level="2"> <div class="contents"> <p> magit が便利すぎて、あんな感じの画面を作りたい。<bt></bt> Emacs Lisp で画面(メニュー?)を作ったことがないが。。。 </p> </div> </app-section> <app-section title="Image" level="2"> <div class="contents"> <p> <screen-image></screen-image> </p> </div> </app-section> <app-section title="Commands" level="2"> <div class="contents"> <command-list commands="{STORE.state().commands}"></command-list> </div> </app-section>', '', '', function(opts) {
});

riot.tag2('tab-minor-mode', '<app-section title="Description" level="2"> <div class="contents"> <p> <code>*.hblog</code> のファイルの時に発動します。 </p> <p> markdown-mode が元になっています。 </p> <p> 新規作成の場合はどこで作成しても構いません。 現在のユーザー/ブログに対してアップロード(POST)されます。 </p> <p> 更新の場合はhateba-blog-writer でダウンロードされたディレクトリ構成上のファイルを想定しています。 </p> </div> </app-section> <app-section title="Commands" level="2"> <div class="contents"> </div> </app-section>', '', '', function(opts) {
});

riot.tag2('tab-readme', '<description></description> <app-section title="Major mode" level="2"> <div class="content"> <p> <screen-image></screen-image> </p> </div> </app-section> <app-section title="Instration" level="2"> <div class="content"> <p> <pre>\n(add-to-list \'load-path "~/.emacs.d/dist/hatena-blog-writer/")\n(require \'hatena-blog-writer)\n                </pre> </p> </div> </app-section> <app-section title="Usage" level="2"> <div class="content"> <p>こんな感じにしたい。</p> <p> <pre>\n(hatena-blog-writer-add-user (hatena-blog-writer-add-user hatena-id user-name))\n(hatena-blog-writer-add-blog (hatena-blog-writer-add-blog blog-id blog-name api-token))\n(hatena-blog-writer-change-user hatena-id)\n(hatena-blog-writer-change-blog blog-id)\n                </pre> </p> </div> </app-section>', '', '', function(opts) {
});

riot.tag2('tab-symbols', '<app-section title="Description" level="2"> <div class="content"> <p> HATENA-BLOG-WRITE のシンボルの一覧です。 </p> <p> シンボルの一覧は以下の二つに分類しています。 <ul> <li>Variables</li> <li>Operators</li> </ul> </p> </div> </app-section> <variables variables="{this.opts.variables}"></variables> <operators operators="{this.opts.operators}"></operators>', '', '', function(opts) {
});

riot.tag2('tab-usage', '<app-section title="Initial setting" level="2"> <app-section level="3"> <div class="content"> <p>ユーザーを追加する。</p> <pre>\n(hatena-blog-writer-add-user (hatena-blog-writer-make-user "yanqirenshi" "岩崎仁是"))\n                </pre> </div> </app-section> <app-section level="3"> <div class="content"> <p>ブログをを追加する。</p> <p>まだ手作業での追加になります。<br>そのうちそのうち。</p> <pre>\n(hatena-blog-writer-add-blog (hatena-blog-writer-make-blog "yanqirenshi.hatenablog.com"\n                                                           "ほんとのこと知りたいだけなのに。"\n                                                           "your-hatena-blog-api-key")\n                </pre> </div> </app-section> <app-section level="3"> <div class="content"> <p>カレントユーザーを指定する</p> <pre>\n(hatena-blog-writer-change-user "yanqirenshi")\n(hatena-blog-writer-change-blog "yanqirenshi.hatenablog.com")\n                </pre> </div> </app-section> </app-section> <app-section title="初期設定が出来たら。" level="2"> <app-section title="とりあえずエントリの一括取得" level="3"> <p> 以下のコマンドで直近20件ほど取得できます。 </p> <div class="content"> <pre>\n(hatena-blog-writer-api-entry-find *hatena-blog-writer-current-user*\n                                   *hatena-blog-writer-current-blog*)\n                </pre> </div> </app-section> </app-section> <app-section title="Lisp operators" level="2"> <app-section title="エントリの取得" level="3"> <div class="content"> <p> <b><a>hatena-blog-writer-api-entry-get</a></b> で取得します。 </p> <p> 取得したエントリの情報はローカルに保管されます。<br> master.el と contents.md の二つのファイルです。 </p> <p> ブログの執筆は contents.md に対して行います。<br> </p> <p> masgter.el に関してはユーザーが直接利用することはありません。<br> 差分を取得したりするのに利用しようかと考えています。 </p> <pre>\nEx)\n(hatena-blog-writer-api-entry-get *hatena-blog-writer-current-user*\n                                  *hatena-blog-writer-current-blog*\n                                  "8599973812337687510")\n                </pre> </div> </app-section> <app-section title="エントリの検索" level="3"> <div class="content"> <div class="content"> <div class="content"> <p> <b><a>hatena-blog-writer-api-entry-find</a></b> で検索します。 </p> <p> この関数では検索条件が指定できるようにしようと思いますが、現時点(2018-01-17 Wed)では未実装です。 </p> <pre>\nEx)\n(hatena-blog-writer-api-entry-find *hatena-blog-writer-current-user*\n                                   *hatena-blog-writer-current-blog*)\n                        </pre> </div> </div> </div> </app-section> <app-section title="エントリの追加" level="3"> <div class="content"> <div class="content"> <p> <b><a>hatena-blog-writer-api-entry-post</a></b> で追加します。 </p> <p> カレントバッファから直接 PUSH しても良さそうなもんですが、そのオペレータは設けていません。<br> エントリの追加は基本メジャーモードからの操作にするので。<br> 特定のディレクトリに配置する必要があるので、少々面倒くさいということもあります。 </p> <pre>\nEx)\n(hatena-blog-writer-api-entry-post *hatena-blog-writer-current-user*\n                                   *hatena-blog-writer-current-blog*\n                                   (hatena-blog-writer-build-post-xml *hatena-blog-writer-current-user*\n                                                                      "title" "contents" \'("ca" "te" "go" "ries") "yes"))\n\n                    </pre> </div> </div> </app-section> <app-section title="エントリの更新" level="3"> <div class="content"> <p> <b><a>hatena-blog-writer-api-entry-put</a></b> で更新します。 </p> <p> 更新方法は、更新前に最新の状態として WEB からエントリの情報を取得します。<br> そして取得したエントリの内容のタイトルとコンテンツをローカルの内容に置き換えて WEB にアップロードしています。 </p> <pre>\nEx)\n(hatena-blog-writer-api-entry-put *hatena-blog-writer-current-user*\n                                  *hatena-blog-writer-current-blog*\n                                  "8599973812337687510")\n                </pre> </div> </app-section> <app-section title="エントリの削除" level="3"> <div class="content"> <p>未実装</P> </div> </app-section> <app-section title="エントリの公開/非公開の切り替え" level="3"> <div class="content"> <p>未実装</P> </div> </app-section> <app-section title="エントリのタグ管理" level="3"> <div class="content"> <p>未実装</P> </div> </app-section> </app-section>', '', '', function(opts) {
});
