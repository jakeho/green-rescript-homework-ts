import React from 'react'
import { RelayEnvironmentProvider } from 'react-relay'
import './App.css'
import { Loading } from './components/Loading'
import { RepoList as RepoListTs } from './pages/RepoList'
// import RepoList from './pages/RepoList.bs'
import RelayEnv from './RelayEnv'

function App() {
  return (
    <RelayEnvironmentProvider environment={RelayEnv}>
      <div className="App text-sm p-4">
        <React.Suspense fallback={<Loading />}>
          {/*<RepoList />*/}
          <RepoListTs />
        </React.Suspense>
      </div>
    </RelayEnvironmentProvider>
  )
}

export default App
