import React from 'react'
import { RelayEnvironmentProvider } from 'react-relay'
import './App.css'
import { RepoList as RepoListTs } from './pages/RepoList'
// import RepoList from './pages/RepoList.bs'
import RelayEnv from './RelayEnv'

function App() {
  return (
    <RelayEnvironmentProvider environment={RelayEnv}>
      <div className="App text-sm">
        {/*<RepoList />*/}
        <RepoListTs />
      </div>
    </RelayEnvironmentProvider>
  )
}

export default App
