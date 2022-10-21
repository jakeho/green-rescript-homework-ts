module Fragment = %relay(`
  fragment RepoInfo_edges on Repository {
    id
    name
    owner {
      id
    }
    stargazerCount
  }
`)

@react.component
let make = (~repo) => {
  let repoInfo = Fragment.use(repo)

  <li className="flex justify-between p-2">
    <div> {repoInfo.name->React.string} </div>
    <StarButton count={repoInfo.stargazerCount} />
  </li>
}
