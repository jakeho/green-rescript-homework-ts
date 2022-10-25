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

@react.component
let make = () => {
  let (inputText, setInputText) = React.useState(_ => "")
  let (keyword, setKeyword) = React.useState(_ => "")
  let url = RescriptReactRouter.useUrl()
  let after = url.search->parseParam("after")
  let before = url.search->parseParam("before")
  let res = switch before {
  | Some(before) =>
    Query.use(
      ~variables={query: keyword, after: None, before: Some(before), last: Some(20), first: None},
      (),
    )
  | None =>
    Query.use(~variables={query: keyword, after, before: None, last: None, first: Some(20)}, ())
  }

  let onSearch = _ => {
    setKeyword(_ => inputText)
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
