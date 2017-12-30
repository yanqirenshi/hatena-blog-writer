<tab-readme>
    <description></description>

    <app-section title="Instration" level="2">
        <div class="content">
            <p>melpa に入れるまでは以下でインストール。</p>
            <p>
                <pre>(load "~/.emacs.d/dist/prj/hatena-blog-writer/hatena-blog-writer.el")</pre>
            </p>
        </div>
    </app-section>

    <app-section title="Usage" level="2">
        <div class="content">
            <p>こんな感じにしたい。</p>
            <p>
                <pre>
;; ユーザーを追加する。
M-x add-user
;; ブログを追加するする。
M-x add-blog

;; 作業ユーザーを決める。
M-x change-user
;; 作業ブログを決める。
M-x change-user

;; ブログ・エントリーをサーバーからダウンロードする。
M-x refresh
;; ブログ・エントリーの一覧を表示する。
M-x hatena-blog-status
;; ブログ・エントリーを編集する
M-x open-entry-contents
;; ブログ・エントリーの差分を確認する。
M-x diff
;; ブログ・エントリーをアップロードする。
M-x upload
                </pre>
            </p>
        </div>
    </app-section>
</tab-readme>
