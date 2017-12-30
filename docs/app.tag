<app>
    <app-header title="HATENA BLOG WRITER"
                subtitle="はてなブログを書くための emacs lisp です。"></app-header>

    <app-tabs click={this.clickTab}
              active={STORE.get('contents')}></app-tabs>

    <!-- tab contents  -->
    <tab-readme class="{this.display('readme')}"></tab-readme>

    <tab-usage class="{this.display('usage')}"></tab-usage>

    <tab-data-structures class="{this.display('data-structures')}"
                         variables={STORE.get('variables')}></tab-data-structures>

    <tab-directory-structure class="{this.display('directory-structure')}"
                             operators={STORE.get('operators')}></tab-directory-structure>

    <tab-symbols class="{this.display('symbols')}"
                 operators={STORE.get('operators')}
                 variables={STORE.get('variables')}></tab-symbols>
    <!-- tab contents  -->

    <app-footer></app-footer>

    <style>
     .hide {
         display: none;
     }
    </style>

    <script>
     this.display = function (name) {
         return STORE.get('contents')==name ? 'show' : 'hide';
     };

     STORE.subscribe(function (action) {
         this.update();
     }.bind(this));
    </script>
</app>
