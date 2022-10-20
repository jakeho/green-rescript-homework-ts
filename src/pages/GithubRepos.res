@react.component
let make = () => {
  let (queryRef, loadQuery, _disposeQuery) = RepoList.Query.useLoader()
  let (keyword, setKeyword) = React.useState(_ => "")

  let onSearch = _ => {
    loadQuery(~variables={query: keyword}, ())
  }

  let onChange = e => {
    (e->ReactEvent.Synthetic.target)["value"]->setKeyword
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
      {switch queryRef {
      | Some(queryRef) =>
        <>
          <RepoPagination queryRef />
          <RepoList queryRef />
        </>

      | None => React.null
      }}
    </React.Suspense>
  </>
}
