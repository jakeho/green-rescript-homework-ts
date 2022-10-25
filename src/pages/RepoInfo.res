module Fragment = %relay(`
  fragment RepoInfo_edges on Repository {
    id
    name
    description
    owner {
      id
    }
    stargazerCount
    viewerHasStarred
  }
`)

@react.component
let make = (~fragRefs) => {
  let repoInfo = fragRefs->Fragment.use

  <li className="flex justify-between p-2">
    <div className="text-left">
      <div className="text-base font-semibold"> {repoInfo.name->React.string} </div>
      <div className="text-gray-400">
        {repoInfo.description->Belt_Option.getWithDefault("")->React.string}
      </div>
    </div>
    <StarButton
      count={repoInfo.stargazerCount} starred={repoInfo.viewerHasStarred} id={repoInfo.id}
    />
  </li>
}
