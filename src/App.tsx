import React from 'react'
import './App.css'
import RepoList from './pages/RepoList.bs'
import { make as Test, Test as Test1 } from './pages/Test.bs'

function App() {
  return (
    <div className="App">
      <RepoList />
      <Test />
      <Test1.make />
    </div>
  )
}

export default App
