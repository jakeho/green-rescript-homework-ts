module Query = %relay(`
  query RepoListSearchQuery($query: String!) {
    search(query: $query, type: REPOSITORY, first: 20) {
      repositoryCount
      pageInfo {
        startCursor
        endCursor
        hasNextPage
        hasPreviousPage
      }
      edges {
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
    }
  }
`)

@react.component
let make = (~queryRef) => {
  let data = Query.usePreloaded(~queryRef, ())

  <div className="mx-auto p-2 w-4/5">
    <div className="text-right px-2">
      {`Total Repos:`->React.string}
      {data.search.repositoryCount->Belt_Int.toString->React.string}
    </div>
    <ul className="mt-2">
      {switch data.search.edges {
      | Some(edge) =>
        open Belt
        edge
        ->Array.keepMap(edge' => edge')
        ->Array.map(edge' => {
          switch edge'.node {
          | Some(repo) =>
            switch repo {
            | #Repository(repo') =>
              <li className="flex justify-between p-2" key={repo'.name ++ repo'.owner.id}>
                <div> {repo'.name->React.string} </div>
                <StarButton count={repo'.stargazerCount} />
              </li>
            | #UnselectedUnionMember(_str) => React.null
            }
          | None => React.null
          }
        })
        ->React.array
      | _ => React.null
      }}
    </ul>
  </div>
}
