const { GraphQLClient } = require("graphql-request");
const btoa = require("btoa");
const fs = require("fs");

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
    query MyQuery($paging: String) {
      policies: policyTypes(filter: "limit:300", paging: $paging) {
        items {
          trunk {
            title
          }
        }
        paging {
          next
        }
      }
    }`;

  var targets = [];
  var paging = null;

  do {
    const variables = { paging };
    const data = await graphQLClient.request(query, variables);
    targets = targets.concat(data.policies.items);
    paging = data.policies.paging.next;
  } while (paging);

  var totalPolicies = targets.map(i => {
    return i.trunk.title;
  });

  // console.log("Total Policies: ", totalPolicies);
  console.log(`Total No Policies: ${totalPolicies.length}`);
  fs.writeFile(
    "policiesInEnvironment.csv",
    JSON.stringify(totalPolicies, null, 1),
    err => {
      if (err) throw err;
      console.log(
        "Policies written in policiesInEnvironment.csv file successfully"
      );
    }
  );
}

main().catch(error => console.error(error));
