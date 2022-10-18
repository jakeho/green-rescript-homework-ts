import React from 'react'
import { RelayEnvironmentProvider } from 'react-relay'
import './App.css'
import { Loading } from './components/Loading'
import { make as GithubRepos } from './pages/GithubRepos.bs'
import { environment } from './RelayEnv.bs'

function App() {
  return (
    <RelayEnvironmentProvider environment={environment}>
      <div className="App text-sm p-4">
        <React.Suspense fallback={<Loading />}>
          <GithubRepos />
        </React.Suspense>
      </div>
    </RelayEnvironmentProvider>
  )
}

export default App
