@react.component
let make = (~queryRef) => {
  let data = RepoList.Query.usePreloaded(~queryRef, ())
  let {hasNext, hasPrevious, loadNext, loadPrevious} = RepoList.Fragment.usePagination(
    data.fragmentRefs,
  )

  <div className="flex mx-auto p-2 w-4/5">
    <button
      className="button p-1 px-4 rounded border"
      disabled={!hasPrevious}
      onClick={_ => loadPrevious(~count=20, ()) |> ignore}>
      {"Prev"->React.string}
    </button>
    <button
      className="button p-1 px-4 rounded border ml-1"
      disabled={!hasNext}
      onClick={_ => loadNext(~count=20, ()) |> ignore}>
      {"Next"->React.string}
    </button>
  </div>
}
