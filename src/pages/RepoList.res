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
        ->Array.map(edge' =>
          <li className="flex justify-between p-2">
            {
              let (name, stargazerCount) = switch edge'.node {
              | Some(repo) =>
                switch repo {
                | #Repository(repo') => (repo'.name, repo'.stargazerCount)
                }
              }

              <>
                <div> {name->React.string} </div>
                <button className="button border border-1 rounded p-1 px-2">
                  <span className="mr-1"> {React.string("⭐️")} </span>
                  {stargazerCount->Int.toString->React.string}
                </button>
              </>
            }
          </li>
        )
        ->React.array
      | _ => React.null
      }}
    </ul>
  </div>
}
