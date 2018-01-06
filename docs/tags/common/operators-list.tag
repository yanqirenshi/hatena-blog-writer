<operators-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable">
        <thead>
            <th>type</th>
            <th>symbol</th>
            <th>description</th>
            <th>file</th>
        </thead>
        <tbody>
            <tr each={this.filter(this.opts)}>
                <td>{type}</td>
                <td style="white-space: nowrap;"><b>{symbol}</b></td>
                <td>{description}</td>
                <td style="white-space: nowrap;">{file}</td>
            </tr>
        </tbody>
    </table>

    <script>
     this.query = function (data, files) {
         if (files)
             return L.find(data.file, files, function (a,b) {
                 return a == b;
             })

         return true;
     }.bind(this);

     this.filter = function (opts) {
         var out = [];

         var data = opts.data;
         var files = opts.files;

         for (var i in data)
             if (this.query(data[i], files))
                 out.push(data[i]);

         return out;
     }.bind(this);
    </script>
</operators-list>
