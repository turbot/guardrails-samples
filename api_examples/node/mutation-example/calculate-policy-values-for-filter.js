const { GraphQLClient } = require("graphql-request");
const btoa = require("btoa");

const FILTER = "state:tbd,error,invalid";

async function main() {
  const endpoint = process.env.TURBOT_GRAPHQL_ENDPOINT;
  const accessKeyId = process.env.TURBOT_ACCESS_KEY_ID;
  const secretAccessKey = process.env.TURBOT_SECRET_ACCESS_KEY;

  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: "Basic " + btoa(`${accessKeyId}:${secretAccessKey}`)
    }
  });

  const query = `
    {
      targets: policyValues(filter:"${FILTER} sort:timestamp limit:300") {
        items {
          turbot { id }
          state
        }
      }
    }
  `;

  var mutation = `
    mutation RunPolicy($input: RunPolicyInput!) {
      runPolicy(input: $input) {
        turbot {
          id
        }
      }
    }
  `;

  const variables = {};

  const data = await graphQLClient.request(query, variables);

  for (const i of data.targets.items) {
    var vars = { input: { id: i.turbot.id } };
    console.log(vars);
    try {
      var run = await graphQLClient.request(mutation, vars);
      console.log(run);
    } catch (e) {
      console.error(e);
    }
  }
}

main().catch(error => console.error(error));
