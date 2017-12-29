<operators-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable">
        <thead>
            <th>type</th>
            <th>symbol</th>
            <th>description</th>
            <th>file</th>
        </thead>
        <tbody>
            <tr each={this.opts.data}>
                <td>{type}</td>
                <td><b>{symbol}</b></td>
                <td>{description}</td>
                <td>{file}</td>
            </tr>
        </tbody>
    </table>
</operators-list>
