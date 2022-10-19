export class GithubGraphQL {
  static fetch(query: string, variables?: any) {
    const TOKEN = process.env.REACT_APP_GITHUB_AUTH_TOKEN

    return fetch('https://api.github.com/graphql', {
      method: 'POST',
      headers: {
        Authorization: `bearer ${TOKEN}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        query,
        variables
      })
    }).then((res) => res.json())
  }
}
