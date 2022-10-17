import { Environment, Network, RecordSource, Store } from 'relay-runtime'
import { RequestParameters } from 'relay-runtime/lib/util/RelayConcreteNode'
import { Variables } from 'relay-runtime/lib/util/RelayRuntimeTypes'
import { GithubGraphQL } from './GithubGraphQL'

async function fetchRelay(request: RequestParameters, variables: Variables) {
  console.log('fetch relay')
  return GithubGraphQL.fetch(request.text!, variables)
}

export default new Environment({
  network: Network.create(fetchRelay),
  store: new Store(new RecordSource())
})
