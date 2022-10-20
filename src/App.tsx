import React from 'react'
import { RelayEnvironmentProvider } from 'react-relay'
import './App.css'
import { make as GithubRepos } from './pages/GithubRepos.bs'
import { environment } from './RelayEnv.bs'

function App() {
  return (
    <RelayEnvironmentProvider environment={environment}>
      <div className="App text-sm p-4 max-w-5xl mx-auto">
        <GithubRepos />
      </div>
    </RelayEnvironmentProvider>
  )
}

export default App
