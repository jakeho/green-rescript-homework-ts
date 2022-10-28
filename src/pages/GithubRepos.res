module Query = %relay(`
  query GithubReposQuery(
    $query: String!
    $after: String
    $before: String
    $last: Int
    $first: Int
  ) {
    ...RepoList_frag_search
      @arguments(
        query: $query
        after: $after
        before: $before
        last: $last
        first: $first
      )
  }
`)

let parseParam = (search: string, param: string) => {
  let res = Js.Re.fromString(param ++ "=([\\w\\d]+)[&|$]?")->Js.Re.exec_(search)
  switch res {
  | Some(r) => Js.Nullable.toOption(Js.Re.captures(r)[1])
  | None => None
  }
}

type freeText = string
type action = Set(freeText) | Unset

@react.component
let make = (~after: option<'a>, ~before: option<'a>, ~last: option<int>, ~first: option<int>) => {
  let (keyword, dispatch) = React.useReducer((_state: freeText, action) => {
    switch action {
    | Set(val) => val
    | Unset => ""
    }
  }, "")
  let (inputText, setInputText) = React.useState(_ => "")
  let res = Query.use(~variables={query: keyword, after, before, last, first}, ())

  let onSearch = _ => {
    inputText->Set->dispatch
  }

  let onChange = e => {
    (e->ReactEvent.Synthetic.target)["value"]->setInputText
  }

  let onSubmit = e => {
    e->ReactEvent.Form.preventDefault
    onSearch()
  }

  <>
    <div> {React.string("Hey~ I ❤️ ReScript.")} </div>
    <form onSubmit>
      <input type_="text" className="border-solid border rounded w-1/2 p-1" onChange />
      <button
        type_="submit"
        className="button border rounded p-1 px-4 bg-amber-100 ml-1"
        onClick={onSearch}>
        {React.string("Search")}
      </button>
    </form>
    <React.Suspense fallback={<Loading />}>
      <RepoList queryRef=res.fragmentRefs />
    </React.Suspense>
  </>
}
