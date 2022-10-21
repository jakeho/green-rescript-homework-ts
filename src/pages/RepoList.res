module Query = %relay(`
  query RepoListSearchQuery($query: String!) {
    ...RepoList_frag_search @arguments(query: $query)
  }
`)

module Fragment = %relay(`
  fragment RepoList_frag_search on Query
  @refetchable(queryName: "RepoListSearchQueryFrag")
  @argumentDefinitions(
    first: { type: "Int", defaultValue: 20 }
    after: { type: "String" }
    query: { type: "String!" }
  ) {
    search(query: $query, type: REPOSITORY, first: $first, after: $after)
      @connection(key: "RepoList__search") {
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
  let {data: pageData} = data.fragmentRefs->Fragment.usePagination
  let fragData = pageData.search->Fragment.getConnectionNodes

  <div className="mx-auto p-2 w-4/5">
    <div className="text-right px-2">
      {`Total Repos:`->React.string}
      {pageData.search.repositoryCount->Belt_Int.toString->React.string}
    </div>
    <ul className="mt-2">
      {
        open Belt
        fragData
        ->Array.map(node => {
          switch node {
          | #Repository(node) => <RepoInfo repo=node.fragmentRefs key=node.id />
          | _ => React.null
          }
        })
        ->React.array
      }
    </ul>
  </div>
}
