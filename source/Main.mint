component Main {
  connect SearchResults exposing { searchForRepos, repos, searchError }

  style top {
    margin-top: -70px;
  }

  fun componentDidMount : Void {
    do {
      searchForRepos
    }
  }

  fun render : Html {
    <div>
      <Header/>

      <div>
        <{ searchError }>
      </div>

      <section class="section">
        <div class="field">
          <p class="control has-icons-left has-icons-right">
            <input
              class="input is-medium"
              type="email"
              placeholder="Package search"/>

            <span class="icon is-small is-left">
              <i class="fas fa-search"/>
            </span>
          </p>
        </div>
      </section>

      <PackagesFound repos={repos}/>

      <section::top
        class="section"
        id="card">

        <Repositories repos={repos}/>

      </section>
    </div>
  }
}
