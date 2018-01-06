<tab-readme>
    <description></description>

    <app-section title="Major mode" level="2">
        <div class="content">
            <p>
                <screen-image></screen-image>
            </p>
        </div>
    </app-section>

    <app-section title="Instration" level="2">
        <div class="content">
            <p>
                <pre>
(add-to-list 'load-path "~/.emacs.d/dist/hatena-blog-writer/")
(require 'hatena-blog-writer)
                </pre>
            </p>
        </div>
    </app-section>

    <app-section title="Usage" level="2">
        <div class="content">
            <p>こんな感じにしたい。</p>
            <p>
                <pre>
(hatena-blog-writer-add-user (hatena-blog-writer-add-user hatena-id user-name))
(hatena-blog-writer-add-blog (hatena-blog-writer-add-blog blog-id blog-name api-token))
(hatena-blog-writer-change-user hatena-id)
(hatena-blog-writer-change-blog blog-id)
                </pre>
            </p>
        </div>
    </app-section>
</tab-readme>
