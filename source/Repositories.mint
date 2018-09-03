component Repositories {
  property repos : Maybe(SearchResponse) = Maybe.nothing()

  get renderRepos : Array(Html) {
    try {
      all =
        repos
        |> Maybe.toResult(<span/>)

      all.items
      |> Array.Extra.groupsOf(2)
      |> Array.map(renderSubGroup)
    } catch Html => html {
      [html]
    }
  }

  fun renderSubGroup (group : Array(Item)) : Html {
    <div class="columns">
      <{
        group
        |> Array.map(renderRepo)
      }>
    </div>
  }

  fun renderRepo (item : Item) : Html {
    <Repository item={Maybe.just(item)}/>
  }

  fun render : Array(Html) {
    renderRepos
  }
}
