@react.component
let make = (~queryRef) => {
  let res = RepoList.Query.usePreloaded(~queryRef, ())
  let {data, hasNext, loadNext} = res.fragmentRefs->RepoList.Fragment.usePagination
  data.search.pageInfo.endCursor->Js.log

  let move = _ => {
    loadNext(~count=20, ())->ignore
    // refetch(
    //   ~variables={
    //     after: Some(data.search.pageInfo.endCursor),
    //     first: Some(Some(20)),
    //     query: Some(keyword),
    //   },
    //   (),
    // )->ignore
  }

  <div className="flex mx-auto p-2 w-4/5 sticky top-0 bg-white">
    // <button
    //   className="button p-1 px-4 rounded border"
    //   disabled={!hasPrevious}
    //   onClick={_ => loadPrevious(~count=20, ())->ignore}>
    //   {"Prev"->React.string}
    // </button>
    <button className="button p-1 px-4 rounded border ml-1" disabled={!hasNext} onClick={move}>
      {"More"->React.string}
    </button>
  </div>
}
