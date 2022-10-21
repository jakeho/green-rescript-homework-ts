# Homework for front-end candidates of Greenlabs
You need to create an application that you can search GitHub repositories, and can star/unstar repositories in the list of search result.

- You should use Relay
- You should use React (Next.js also good)
- It would be better to write in Rescript but you may choose JavaScript or TypeScript.

## Scripts

There are 3 parts you need to run to build or run the application.

### Relay
`relay:start` is for build and watch Rescript-Relay compiler

### Rescript
Rescript-Relay is building related files by `relay:start` or `relay:build`.
Then you should run `res:start` to make Rescript complier watches the files and compile into JavaScript.

### React
`npm start` will run a local server using `react-rescript`.

## Token
This application uses GraphQL API of GitHub.
To see the repositories and stargaze, you need to provide a token.

To do that, create a dotenv file - `env.local` and put your token to a key `REACT_APP_GITHUB_AUTH_TOKEN`.

**.env.local**
```dotenv
REACT_APP_GITHUB_AUTH_TOKEN=YOUR_TOKEN_HERE
```

