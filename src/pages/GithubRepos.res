@react.component
let make = () => {
  <>
    <div> {React.string("Hey~ I ❤️ ReScript.")} </div>
    <input type_="text" className="border-solid border rounded w-1/2 p-1" />
    <button type_="submit" className="button border rounded p-1 px-4 bg-amber-100 ml-1">
      {React.string("Search")}
    </button>
    <RepoList />
  </>
}
