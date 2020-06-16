const { GraphQLClient } = require("graphql-request");
const btoa = require("btoa");

// Example Filters
// ---------------
// Run policies in TBD (Default):     "state:tbd"
// Run policies in error state:       "state:error"
// Run policies in multiple states:   "state:tbd,error,invalid"

async function main() {
  // Default filter
  const filter = "state:tbd";

  // Set up connection to Turbot Workspace using environment variables
  const endpoint = process.env.TURBOT_GRAPHQL_ENDPOINT;
  const accessKeyId = process.env.TURBOT_ACCESS_KEY_ID;
  const secretAccessKey = process.env.TURBOT_SECRET_ACCESS_KEY;

  // Create the client and apply the authorization details
  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: "Basic " + btoa(`${accessKeyId}:${secretAccessKey}`),
    },
  });

  // The GraphQL query to return the policies that are match the filter
  const query = `
    query Targets($filter: [String!]!, $paging: String) {
      targets: policyValues(filter: $filter, paging: $paging) {
        items {
          turbot {
            id
          }
        }
        paging {
          next
        }
      }
    }
  `;

  let targets = [];
  let paging = null;

  do {
    const variables = { filter, paging };

    const data = await graphQLClient.request(query, variables);
    targets = targets.concat(data.targets.items);
    paging = data.targets.paging.next;

    console.log(`Targets: ${targets.length}`);
  } while (paging);

  // Defines the GraphQL mutation to run the policies that were returned from the GraphQL query
  const mutation = `
    mutation RunPolicy($input: RunPolicyInput!) {
      runPolicy(input: $input) {
        turbot {
          id
        }
      }
    }
  `;

  for (const i of targets) {
    const vars = { input: { id: i.turbot.id } };
    console.log(vars);

    const run = await graphQLClient.request(mutation, vars).catch((error) => console.error(error));
    console.log(run);
  }
}

main().catch((error) => console.error(JSON.stringify(error, null, 2)));
