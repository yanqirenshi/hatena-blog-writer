<tab-data-structures>
    <app-section title="Description">

        <p>
            三つのデータがあります。
        </p>

        <table class="table is-bordered is-striped is-narrow is-hoverable">
            <thead>
                <tr>
                    <th>class</th> <th>description</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>user</td> <td>はてなユーザー</td>
                </tr>
                <tr>
                    <td>blog</td> <td>ブログ</td>
                </tr>
                <tr>
                    <td>entry</td> <td>ブログ・エントリー</td>
                </tr>
            </tbody>
        </table>

    </app-section>

    <app-section title="Lisp">
        <app-section title="はてなユーザー">
            <pre>(:id "..." :name "..." :class "user")</pre>
        </app-section>

        <app-section title="ブログ">
            <pre>(:id "..." :name "..." :class "blog" :api-key)</pre>
        </app-section>

        <app-section title="ブログ・エントリー">
            <pre>(:id "..." :title "..." :contents "..." :class "entry")</pre>
        </app-section>
    </app-section>

    <app-section title="Symbols" level="2" variables={this.opts.variables}>
        <variables variables={this.opts.variables}
                   files={["hatena-blog-writer.el"]}></variables>
    </app-section>
    <script>
     console.log(this.opts);
    </script>
</tab-data-structures>
