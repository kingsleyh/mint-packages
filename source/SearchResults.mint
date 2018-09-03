record SearchResponse {
  totalCount : Number using "total_count",
  incompleteResults : Bool using "incomplete_results",
  items : Array(Item)
}

record Owner {
  login : String,
  avatarUrl : String using "avatar_url",
  htmlUrl : String using "html_url"
}

record Item {
  name : String,
  fullName : String using "full_name",
  owner : Owner,
  htmlUrl : String using "html_url",
  description : String,
  url : String,
  stars : Number using "stargazers_count",
  updatedAt : String using "updated_at",
  tagsUrl : String using "tags_url"
}

record Tag {
  name : String,
  nodeId : String using "node_id"
}

store SearchResults {
  state repos : Maybe(SearchResponse) = Maybe.nothing()
  state searchError : String = ""

  get searchForRepos : Void {
    do {
      response =
        Http.get(
          "https://api.github.com/search/repositories?q=topic:mint-" \
          "lang")
        |> Http.send()

      json =
        Json.parse(response.body)
        |> Maybe.toResult("Json paring error")

      all =
        decode json as SearchResponse

      next { repos = Maybe.just(all) }
    } catch Http.ErrorResponse => error {
      next { searchError = "Could not retrieve packages from github" }
    } catch String => error {
      next { searchError = "Could not parse json response" }
    } catch Object.Error => error {
      do {
        next { searchError = "could not decode json" }
      }
    }
  }
}
