import React from 'react'
import { RelayEnvironmentProvider } from 'react-relay'
import './App.css'
import { make as GithubRepos } from './pages/GithubRepos.bs'
import { environment } from './RelayEnv.bs'
import { url } from './router.bs'

const parseParam = (search: string, param: string) => {
  const reg = new RegExp(param + "=([\\w\\d]+)[&|$]?")
  const res = reg.exec(search)
  return res ? res[1] : undefined
}

function App() {
  const { search } = url()
  console.log(search)

  const after = parseParam(search, "after")
  const before = parseParam(search, "before")

  const variables = {
    after,
    before,
    first: before ? undefined : 20,
    last: before ? 20 : undefined
  }

  return (
    <RelayEnvironmentProvider environment={environment}>
      <div className="App text-sm p-4 max-w-5xl mx-auto">
        <GithubRepos {...variables} />
      </div>
    </RelayEnvironmentProvider>
  )
}

export default App
