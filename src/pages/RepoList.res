module Query = %relay(`
  query RepoListSearchQuery($query: String!) {
    ...RepoList_frag_search
  }
`)

module Fragment = %relay(`
  fragment RepoList_frag_search on Query {
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
            id
            ...RepoInfo_edges
          }
        }
      }
    }
  }
`)

@react.component
let make = (~queryRef) => {
  let data = Query.usePreloaded(~queryRef, ())
  let fragData = Fragment.use(data.fragmentRefs)

  <div className="mx-auto p-2 w-4/5">
    <div className="text-right px-2">
      {`Total Repos:`->React.string}
      {fragData.search.repositoryCount->Belt_Int.toString->React.string}
    </div>
    <ul className="mt-2">
      {switch fragData.search.edges {
      | Some(edge) =>
        open Belt
        edge
        ->Array.keepMap(edge' => edge')
        ->Array.map(edge' => {
          switch edge'.node {
          | Some(node) =>
            switch node {
            | #Repository(node) => <RepoInfo repo=node.fragmentRefs key=node.id />
            | _ => React.null
            }
          | _ => React.null
          }
        })
        ->React.array
      | _ => React.null
      }}
    </ul>
  </div>
}
