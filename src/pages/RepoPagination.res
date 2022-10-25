@react.component
let make = (~hasNextPage, ~hasPreviousPage, ~onMoveNext, ~onMovePrev) => {
  <div className="flex sticky top-0 py-2 bg-white">
    <button
      className="button p-1 px-4 rounded border disabled:text-slate-300"
      disabled={!hasPreviousPage}
      onClick={onMovePrev}>
      {"Prev"->React.string}
    </button>
    <button
      className="button p-1 px-4 rounded border ml-1 disabled:text-slate-300"
      disabled={!hasNextPage}
      onClick={onMoveNext}>
      {"Next"->React.string}
    </button>
  </div>
}
