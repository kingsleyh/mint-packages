component PackagesFound {
  property repos : Maybe(SearchResponse) = Maybe.nothing()

  style top {
    margin-top: -60px;
  }

  get totalNumberPackages : String {
    try {
      all =
        repos
        |> Maybe.toResult("No packages found")

      Number.toString(all.totalCount) + " packages found"
    } catch String => error {
      error
    }
  }

  fun render : Html {
    <section::top
      class="section"
      id="card">

      <p class="subtitle is-6">
        <{ totalNumberPackages }>
      </p>

    </section>
  }
}