import { graphql } from 'babel-plugin-relay/macro'
import React, { SyntheticEvent, useEffect, useState } from 'react'
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
    query RepoListSearchQuery($query: String!) {
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
`

export function RepoList() {
  const [repoName, setRepoName] = useState('')
  const data = useClientQuery(RepoListQuery, { query: repoName }) as RepoListSearchQuery

  useEffect(function () {
    loadQuery(RelayEnv, RepoListQuery, { query: repoName || 'is:public' })
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

  function onRepoNameChange(e: SyntheticEvent<HTMLInputElement>) {
    setRepoName((e.target as HTMLInputElement).value)
  }

  function search() {
    loadQuery(RelayEnv, RepoListQuery, { query: repoName || 'is:public' })
  }

  return (
    <div className="max-w-screen-md mx-auto px-4">
      <div>Hey~ I ❤️ TypeScript.</div>
      <div>
        <input type="text" className="border border-1 p-1 rounded w-1/2" onChange={onRepoNameChange} value={repoName} />
        <button type="button" className="border border-1 p-1 ml-2 rounded" onClick={search}>Search</button>
      </div>
      <ul className="text-left">
        {renderRepository()}
      </ul>
    </div>
  )
}
