@react.component
let make = (~queryRef) => {
  let data = RepoList.Query.usePreloaded(~queryRef, ())
  let {hasNext, loadNext} = data.fragmentRefs->RepoList.Fragment.usePagination

  <div className="flex mx-auto p-2 w-4/5 sticky top-0 bg-white">
    // <button
    //   className="button p-1 px-4 rounded border"
    //   disabled={!hasPrevious}
    //   onClick={_ => loadPrevious(~count=20, ())->ignore}>
    //   {"Prev"->React.string}
    // </button>
    <button
      className="button p-1 px-4 rounded border ml-1"
      disabled={!hasNext}
      onClick={_ => loadNext(~count=20, ())->ignore}>
      {"More"->React.string}
    </button>
  </div>
}
