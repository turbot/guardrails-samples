const { GraphQLClient } = require("graphql-request");
const btoa = require("btoa");

// Run any control stuck in TBD
//const filter = "state:tbd";

// Run any controls in error state
//const filter = "state:error";

// Run any controls in any bad state
//const filter = "state:tbd,error,alarm";

// Re-run installed control installed
// const filter = "state:tbd,error controlType:'tmod:@turbot/turbot#/control/types/controlInstalled'";

// Re-run all discovery controls
const filter = "Discovery controlCategory:'tmod:@turbot/turbot#/control/categories/cmdb'";

// Re-run all Event Handler controls
//const filter = "controlType:'tmod:@turbot/aws#/control/types/eventHandlers'";

async function main() {
  const endpoint = process.env.TURBOT_GRAPHQL_ENDPOINT;
  const accessKeyId = process.env.TURBOT_ACCESS_KEY_ID;
  const secretAccessKey = process.env.TURBOT_SECRET_ACCESS_KEY;

  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: "Basic " + btoa(`${accessKeyId}:${secretAccessKey}`),
    },
  });

  const query = `
    query Targets($filter: [String!]!, $paging: String) {
      targets: controls(filter: $filter, paging: $paging) {
        items {
          turbot { id }
          state
        }
        paging {
          next
        }
      }
    }
  `;

  var mutation = `
    mutation RunControl($input: RunControlInput!) {
      runControl(input: $input) {
        turbot {
          id
        }
      }
    }
  `;

  var targets = [];
  var paging = null;

  do {
    const variables = { filter, paging };
    const data = await graphQLClient.request(query, variables);
    targets = targets.concat(data.targets.items);
    console.log(`Targets: ${targets.length}`);
    paging = data.targets.paging.next;
  } while (paging);

  for (const i of targets) {
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

main().catch((error) => console.error(error));
