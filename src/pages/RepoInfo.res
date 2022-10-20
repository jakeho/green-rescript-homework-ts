module Fragment = %relay(`
  fragment RepoInfo_edges on SearchResultItemEdge {
    cursor
    node {
      ... on Repository {
        name
        owner {
          id
        }
        stargazerCount
      }
    }
  }
`)

@react.component
let make = (~repo) => {
  let repoInfo = Fragment.use(repo)

  switch repoInfo.node {
  | Some(repo') =>
    <li className="flex justify-between p-2" key={repo'.name ++ repo'.owner.id}>
      <div> {repo'.name->React.string} </div>
      <StarButton count={repo'.stargazerCount} />
    </li>
  | None => React.null
  }
}
