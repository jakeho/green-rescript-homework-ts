import { graphql } from 'babel-plugin-relay/macro'
import React, { useEffect } from 'react'
import { loadQuery, useClientQuery } from 'react-relay'
import { PageInfo } from 'relay-runtime'
import RelayEnv from '../RelayEnv'

interface Search {
  repositoryCount: number
  pageInfo?: PageInfo
  edges?: RepoNode[]
}

interface RepoNode {
  cursor: string
  node: Repo
}

interface Repo {
  name: string
  owner: {
    id: string
  }
  stargazerCount: number
}

interface RepoListSearchQuery {
  search: Search
}

const RepoListQuery = graphql`
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
`

export function RepoList() {
  const data = useClientQuery(RepoListQuery, {}) as RepoListSearchQuery

  useEffect(function () {
    loadQuery(RelayEnv, RepoListQuery, {})
  }, [])

  function renderRepository() {
    return (data?.search?.edges ?? []).map((record) => {
      return (
        <li key={`${record?.node?.owner?.id}-${record?.node?.name}`} className="p-2 flex justify-between">
          <div>{record?.node?.name}</div>
          <div><span>Stars: </span><span>{record?.node?.stargazerCount}</span></div>
        </li>
      )
    })
  }

  return (
    <div className="max-w-screen-md mx-auto px-4">
      <div>Hey~ I ❤️ TypeScript.</div>
      <div>
        <input type="text" className="border border-1 p-1 rounded w-1/2" />
        <button type="button" className="border border-1 p-1 ml-2 rounded">Search</button>
      </div>
      <ul className="text-left">
        {renderRepository()}
      </ul>
    </div>
  )
}
