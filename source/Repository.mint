component Repository {
  property item : Maybe(Item) = Maybe.nothing()

  state tags : Array(Tag) = []
  state error : String = ""

  fun findTags (url : String) : Void {
      do {
        response =
          Http.get(url)
          |> Http.send()

        json =
          Json.parse(response.body)
          |> Maybe.toResult("Json paring error")

        all =
          decode json as Array(Tag)

        next { tags = all }
      } catch Http.ErrorResponse => error {
        next { error = "Could not retrieve tags from github" }
      } catch String => error {
        next { error = "Could not parse json response" }
      } catch Object.Error => error {
        do {
          next { error = "could not decode json" }
        }
      }
    }

  fun componentDidMount : Void {
    do {
      item
      |> Maybe.map((i : Item) : String => { i.tagsUrl })
      |> Maybe.map(findTags)
    }
  }

  style leftPad {
    padding-left: 8px;
  }

  get tagName : String {
   tags
   |> Array.map((t : Tag) : String => { t.name })
   |> Array.firstWithDefault("")
  }

  fun render : Html {
    try {
      i =
        item
        |> Maybe.toResult(<span/>)

      <div class="column">
        <div class="card">
          <header class="card-header">
            <p class="card-header-title">
              <a
                class="subtitle has-text-link"
                href={i.htmlUrl}>

                <{ i.name }>
                <span::leftPad class="subtitle is-6 has-text-success"><{ tagName }></span>

              </a>
            </p>
          </header>

          <div class="card-content">
            <div class="content">
              <{ i.description }>
            </div>
          </div>

          <footer class="card-footer">
            <a
              class="card-footer-item"
              href={i.owner.htmlUrl}>

              <img
                height="25"
                width="25"
                src={i.owner.avatarUrl}/>

              <span::leftPad>
                <{ i.owner.login }>
              </span>

            </a>

            <p class="card-footer-item">
              <i class="fas fa-star"/>

              <span::leftPad>
                <{ Number.toString(i.stars) }>
              </span>
            </p>

            <p class="card-footer-item">
              <{ updatedAt(i.updatedAt) }>
            </p>
          </footer>
        </div>
      </div>
    } catch Html => html {
      html
    }
  }

  fun updatedAt (datetime : String) : String {
    `timeago().format(datetime)`
  }
}
