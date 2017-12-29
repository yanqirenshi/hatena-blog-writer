<app-tabs>
    <section class="section" style="padding-top: 8px;padding-bottom: 8px;">
        <div class="container">
            <div class="tabs is-boxed">
                <ul>
                    <li class={this.isActive('readme')}
                        style="margin-left: 22px;">
                        <a href="#readme">
                            <span>概要</span>
                        </a>
                    </li>
                    <li class={this.isActive('usage')}>
                        <a href="#usage">
                            <span>使い方</span>
                        </a>
                    </li>
                    <li class={this.isActive('data-structures')}>
                        <a href="#data-structures">
                            <span>データ構成</span>
                        </a>
                    </li>
                    <li class={this.isActive('symbols')}>
                        <a href="#symbols">
                            <span>シンボル</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </section>

    <script>
     this.isActive = function (name) {
         return this.opts.active==name ? 'is-active' : '';
     };

    </script>
</app-tabs>
