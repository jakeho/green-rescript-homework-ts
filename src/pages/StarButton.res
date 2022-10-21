@react.component
let make = (~count: int) => {
  open Belt
  <button className="button border border-1 rounded p-1 px-2">
    <span className="mr-1"> {React.string("⭐️")} </span>
    {count->Int.toString->React.string}
  </button>
}
