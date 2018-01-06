<app-section>
    <section class="section">
        <div class="container">
            <h1 class="title {this.level()}">{this.opts.title}</h1>
            <p class="subtitle"></p>
            <yield/>
        </div>
    </section>

    <script>
     this.level = function () {
         var l = this.opts.level;
         if (l) return 'is-' + l;
         return 'is-3'
     }
    </script>
</app-section>
