<command-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable">
        <thead>
            <tr>
                <th>Command</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr each={this.opts.commands}>
                <td>{command}</td>
                <td>{description}</td>
            </tr>
        </tbody>
    </table>
</command-list>
