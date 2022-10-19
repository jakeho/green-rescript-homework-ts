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
let make = () => {
  // how to declare queries and use them?
  let data = Query.use(
    ~variables={
      query: "is:public",
    },
    (),
  )

  <div className="p-5">
    <div className="text-right">
      {`Total Repos:`->React.string}
      {data.search.repositoryCount->Belt_Int.toString->React.string}
    </div>
    <div className="mt-2">
      {switch data.search.edges {
      | Some(edge) =>
        open Belt
        edge
        ->Array.keepMap(edge' => edge')
        ->Array.map(edge' =>
          <div className="p-1.5">
            {
              let name = switch edge'.node {
              | Some(repo) =>
                switch repo {
                | #Repository(repo') => repo'.name
                | _ => ""
                }
              | None => ""
              }
              name->React.string
            }
          </div>
        )
        ->React.array
      | _ => React.string("")
      }}
    </div>
  </div>
}
