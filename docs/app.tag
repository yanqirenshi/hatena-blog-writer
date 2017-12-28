<app>
    <app-header title="HATENA BLOG WRITER"
                subtitle="はてなブログを書くための emacs lisp です。"></app-header>

    <app-tabs click={this.clickTab}></app-tabs>

    <readme class="{this.display('readme')}"></readme>
    <usage class="{this.display('usage')}"></usage>
    <data-structures class="{this.display('data-structures')}"></data-structures>
    <operators class="{this.display('operators')}"></operators>

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
    </script>
</app>
