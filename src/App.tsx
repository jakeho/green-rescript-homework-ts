import React from 'react'
import './App.css'
import { RepoList as RepoListTs } from './pages/RepoList'
import RepoList from './pages/RepoList.bs'

function App() {
  return (
    <div className="App">
      <RepoList />
      <RepoListTs />
    </div>
  )
}

export default App
