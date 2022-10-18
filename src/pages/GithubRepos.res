module Query = %relay(`
   query GithubReposQuery($query: String!) {
       search(query: $query, type:REPOSITORY, first:20) {
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
  <>
    <div> {React.string("hey?")} </div>
    <RepoList />
  </>
}
