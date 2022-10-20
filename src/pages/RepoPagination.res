@react.component
let make = (~queryRef) => {
  queryRef->Js.log
  <div className="flex mx-auto p-2 w-4/5">
    <button className="button p-1 px-4 rounded border"> {"Prev"->React.string} </button>
    <button className="button p-1 px-4 rounded border ml-1"> {"Next"->React.string} </button>
  </div>
}
