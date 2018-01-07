<app-tabs>
    <section class="section" style="padding-top: 8px;padding-bottom: 8px;">
        <div class="container">
            <div class="tabs is-boxed">
                <ul>
                    <app-tab-item each={STORE.state().tabs}
                                  code={code}
                                  name={name}
                                  active={STORE.state().contents}></app-tab-item>
                </ul>
            </div>
        </div>
    </section>
</app-tabs>
