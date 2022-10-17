import { graphql } from 'babel-plugin-relay/macro'
import React, { useEffect, useState } from 'react'
import { loadQuery, useClientQuery } from 'react-relay'
import { EdgeRecord, PageInfo } from 'relay-runtime'
import { GithubGraphQL } from '../GithubGraphQL'
import RelayEnv from '../RelayEnv'

interface Search {
  repositoryCount: number
  pageInfo?: PageInfo
  edges?: EdgeRecord
}

interface RepoListSearchQuery {
  search: Search
}

const RepoListQuery = graphql`
    query RepoListSearchQuery {
        search(query: "is:public", type:REPOSITORY, first:10) {
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
`

export function RepoList() {
  const [list, setList] = useState({})

  const data = useClientQuery(RepoListQuery, {}) as RepoListSearchQuery

  useEffect(function () {
    loadQuery(RelayEnv, RepoListQuery, {})
    GithubGraphQL.fetch(`
      query RepoListSearchQuery {
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
      <div>{JSON.stringify(data)}</div>
    </>
  )
}
