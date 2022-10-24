@react.component
let make = (~hasNextPage, ~onMoveNext) => {
  <div className="flex sticky top-0 py-2 bg-white">
    // <button
    //   className="button p-1 px-4 rounded border"
    //   disabled={!hasPrevious}
    //   onClick={_ => loadPrevious(~count=20, ())->ignore}>
    //   {"Prev"->React.string}
    // </button>
    <button
      className="button p-1 px-4 rounded border ml-1 disabled:text-slate-300"
      disabled={!hasNextPage}
      onClick={onMoveNext}>
      {"More"->React.string}
    </button>
  </div>
}
