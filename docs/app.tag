<app>
    <app-header title="HATENA BLOG WRITER"
                subtitle="はてなブログを書くための emacs lisp です。"></app-header>

    <app-tabs click={this.clickTab}
              active={STORE.get('contents')}></app-tabs>

    <!-- tab contents  -->
    <readme class="{this.display('readme')}"></readme>

    <usage class="{this.display('usage')}"></usage>

    <data-structures class="{this.display('data-structures')}"></data-structures>

    <directory-structure  class="{this.display('directory-structure')}"></directory-structure>

    <symbols class="{this.display('symbols')}"
             operators={STORE.get('operators')}
             variables={STORE.get('variables')}></symbols>
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
