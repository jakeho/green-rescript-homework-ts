import React, { useEffect, useState } from 'react'
import { GithubGraphQL } from '../GithubGraphQL'

export function RepoList() {
  const [list, setList] = useState({})

  useEffect(function () {
    GithubGraphQL.fetch(`
      query {
        search(query: "is:public", type:REPOSITORY, first:20) {
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
    `).then(function (res) {
        setList(res)
      }
    )

    return function () {
      setList({})
    }
  }, [])
  return (
    <>
      <div>Hey~ I ❤️ TypeScript.</div>
      <div>{JSON.stringify(list)}</div>
    </>
  )
}
