<symbols>
    <app-section title="Description">
        <div class="content">
            <p>
                HATENA-BLOG-WRITE のシンボルの一覧です。
            </p>
            <p>
                シンボルの一覧は以下の二つに分類しています。
                <ul>
                    <li>Variables</li>
                    <li>Operators</li>
                </ul>
            </p>
        </div>
    </app-section>

    <variables variables={this.opts.variables}></variables>
    <operators operators={STORE.get('operators')}></operators>
</symbols>
