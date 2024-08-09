const { GraphQLClient } = require('graphql-request');
const btoa = require("btoa");

async function main() {
  const endpoint = process.env.TURBOT_GRAPHQL_ENDPOINT;
  const accessKeyId = process.env.TURBOT_ACCESS_KEY_ID;
  const secretAccessKey = process.env.TURBOT_SECRET_ACCESS_KEY;

  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: 'Basic ' + btoa(`${accessKeyId}:${secretAccessKey}`)
    }
  });

  const query = `
    {
      resources {
        items {
          title
        }
      }
    }
  `;

  const variables = {};

  const data = await graphQLClient.request(query, variables)

  console.log(JSON.stringify(data, null, 2))
}

main().catch(error => console.error(error))
