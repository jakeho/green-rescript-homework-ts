type location
@val @scope(("window"))
external location: location = "location"
@set external href: (location, string) => unit = "href"

// @send 는 href()
// @set href = ...

module Fragment = %relay(`
  fragment RepoList_frag_search on Query
  @refetchable(queryName: "RepoListSearchQueryFrag")
  @argumentDefinitions(
    first: { type: "Int" }
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
    ) {
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
  let data = queryRef->Fragment.use
  // let fragData = data.search->Fragment.getConnectionNodes
  let {
    search: {pageInfo: {hasNextPage, hasPreviousPage, startCursor, endCursor}, repositoryCount},
  } = data

  let push = (url) => location->href(url)
  
  let onMoveNext = _ => {
    switch endCursor {
    | Some(cursor) => push("/?after=" ++ cursor)
    | None => ()
    }
  }

  let onMovePrev = _ => {
    switch startCursor {
    | Some(cursor) => push("/?before=" ++ cursor)
    | None => ()
    }
  }
  

  <div className="mx-auto p-2 w-4/5">
    {repositoryCount > 0
      ? <RepoPagination hasNextPage onMoveNext hasPreviousPage onMovePrev />
      : React.null}
    <div className="text-right px-2">
      {`Total Repos:`->React.string}
      {data.search.repositoryCount->Belt_Int.toString->React.string}
    </div>
    <ul className="mt-2">
      {
        open Belt
        switch data.search.edges {
        | Some(edges) =>
          edges
          ->Array.keepMap(edge => edge)
          ->Array.map(edge => {
            switch edge.node {
            | Some(#Repository(node)) => <RepoInfo fragRefs=node.fragmentRefs key=node.id />
            | _ => React.null
            }
          })
          ->React.array
        | None => React.null
        }
      }
    </ul>
  </div>
}
