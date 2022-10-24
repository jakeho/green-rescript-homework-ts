module Query = %relay(`
  query GithubReposQuery($query: String!) {
    ...RepoList_frag_search @arguments(query: $query)
  }
`)

@react.component
let make = () => {
  let (inputText, setInputText) = React.useState(_ => "")
  let (keyword, setKeyword) = React.useState(_ => "")
  let res = Query.use(~variables={query: keyword}, ())

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
