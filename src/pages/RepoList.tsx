import { graphql } from 'babel-plugin-relay/macro'
import React, { SyntheticEvent, useState } from 'react'
import { loadQuery, usePreloadedQuery, useQueryLoader } from 'react-relay'
import RelayEnv from '../RelayEnv'
import { RepoListSearchQuery, RepoListSearchQuery$data } from './__generated__/RepoListSearchQuery.graphql'

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

const preLoadedQuery = loadQuery(RelayEnv, RepoListQuery, { query: 'is:public' })

export function RepoList() {
  const [repoName, setRepoName] = useState('')
  const [queryRef, loadQuery] = useQueryLoader<RepoListSearchQuery>(RepoListQuery)
  const data = usePreloadedQuery(RepoListQuery, queryRef ?? preLoadedQuery) as RepoListSearchQuery$data

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

  function search(e?: SyntheticEvent<HTMLFormElement | HTMLButtonElement>) {
    e?.preventDefault()
    loadQuery({ ...queryRef?.variables, query: repoName })
  }

  return (
    <div className="max-w-screen-md mx-auto px-4">
      <div>Hey~ I ❤️ TypeScript.</div>
      <div>
        <form onSubmit={search}>
          <input type="text" className="border border-1 p-1 rounded w-1/2" onChange={onRepoNameChange} value={repoName} />
          <button type="submit" className="border border-1 p-1 ml-2 rounded" onClick={search}>Search</button>
        </form>
      </div>
      <ul className="text-left">
        {renderRepository()}
      </ul>
    </div>
  )
}
