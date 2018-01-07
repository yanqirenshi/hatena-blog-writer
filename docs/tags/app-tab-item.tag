<app-tab-item>
    <li class={this.isActive()}>
        <a href="#{this.opts.code}">
            <span>{this.opts.name}</span>
        </a>
    </li>

    <style>
     app-tab-item li {
         margin-left: 22px;
     }
    </style>

    <script>
     this.isActive = function () {
         return this.opts.active==this.opts.code ? 'is-active' : '';
     };
    </script>
</app-tab-item>
