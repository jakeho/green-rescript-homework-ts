module Fragment = %relay(`
  fragment RepoList_frag_search on Query
  @refetchable(queryName: "RepoListSearchQueryFrag")
  @argumentDefinitions(
    first: { type: "Int", defaultValue: 20 }
    last: { type: "Int" }
    before: { type: "String" }
    after: { type: "String" }
    query: { type: "String!" }
  ) {
    search(
      query: $query
      type: REPOSITORY
      first: $first
      after: $after
      before: $before
      last: $last
    ) @connection(key: "RepoList__search") {
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
  let (data, refetch) = queryRef->Fragment.useRefetchable
  let fragData = data.search->Fragment.getConnectionNodes
  let {search: {pageInfo: {hasNextPage}, repositoryCount}} = data

  let onMoveNext = _ => {
    refetch(
      ~variables=Fragment.makeRefetchVariables(~after=data.search.pageInfo.endCursor, ()),
      (),
    )->ignore
  }

  <div className="mx-auto p-2 w-4/5">
    {repositoryCount > 0 ? <RepoPagination hasNextPage onMoveNext /> : React.null}
    <div className="text-right px-2">
      {`Total Repos:`->React.string}
      {data.search.repositoryCount->Belt_Int.toString->React.string}
    </div>
    <ul className="mt-2">
      {
        open Belt
        fragData
        ->Array.map(node => {
          switch node {
          | #Repository(node) => <RepoInfo fragRefs=node.fragmentRefs key=node.id />
          | _ => React.null
          }
        })
        ->React.array
      }
    </ul>
  </div>
}
