module Fragment = %relay(`
  fragment RepoPagination_frag_search on Query
  @refetchable(queryName: "RepoPaginationFrag")
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
  let {hasNext, loadNext} = queryRef->Fragment.usePagination

  let move = _ => {
    loadNext(~count=20, ())->ignore
    // refetch(
    //   ~variables={
    //     after: Some(data.search.pageInfo.endCursor),
    //     first: Some(Some(20)),
    //     query: Some(keyword),
    //   },
    //   (),
    // )->ignore
  }

  <div className="flex mx-auto p-2 w-4/5 sticky top-0 bg-white">
    // <button
    //   className="button p-1 px-4 rounded border"
    //   disabled={!hasPrevious}
    //   onClick={_ => loadPrevious(~count=20, ())->ignore}>
    //   {"Prev"->React.string}
    // </button>
    <button className="button p-1 px-4 rounded border ml-1" disabled={!hasNext} onClick={move}>
      {"More"->React.string}
    </button>
  </div>
}
