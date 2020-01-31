const { GraphQLClient } = require('graphql-request');
const btoa = require("btoa");
const _ = require("lodash");

// Match a single cost center tag
const RESOURCE_FILTER = "$.turbot.tags.'Cost Center':zz-386651821766";

// Resources in Sales department
// const RESOURCE_FILTER = "$.turbot.tags.Department:Sales";

// Resources in Sales or Marketing
// const RESOURCE_FILTER = "$.turbot.tags.Department:Sales,Marketing";

// Resources with Department=Sales and Cost Center=zz-386651821766
//const RESOURCE_FILTER = "$.turbot.tags.Department:Sales $.turbot.tags.'Cost Center':zz-386651821766";

// Resources with Department=Sales and in AWS region us-east-1 or us-east-2
// const RESOURCE_FILTER = "$.turbot.tags.Department:Sales $.turbot.custom.aws.regionName:us-east-1,us-east-2";


async function main() {

  const endpoint = process.env.TURBOT_GRAPHQL_ENDPOINT;
  const accessKeyId = process.env.TURBOT_ACCESS_KEY_ID;
  const secretAccessKey = process.env.TURBOT_SECRET_ACCESS_KEY;

  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: 'Basic ' + btoa(`${accessKeyId}:${secretAccessKey}`)
    }
  });

  const resourcesWithTagQuery = `
    query {
      resources(filter: "${RESOURCE_FILTER} limit:300") {
        items {
          turbot { id }
        }
      }
    }
  `;

  const resourcesWithTag = await graphQLClient.request(resourcesWithTagQuery);

  const resourceIdsWithTag = resourcesWithTag.resources.items.map(i => { return i.turbot.id });

  var controlsQuery = `
    query {

      controlSummariesByResource(filter:"resource:${resourceIdsWithTag.join(',')} limit:300") {
        metadata {
          stats {
            control { error invalid alarm ok skipped tbd }
          }
        }
      }

      controls(filter: "resource:${resourceIdsWithTag.join(',')} state:alarm,error,invalid limit:300 sort:resourceId,state") {
        items {
          state
          turbot { id }
          type {
            uri
            trunk { items { turbot { title } } }
          }
          resource {
            turbot { id title }
            trunk { items { turbot { title } } }
          }
        }
      }

    }

  `;

  const controlsResult = await graphQLClient.request(controlsQuery, {});

  console.log();
  console.log(`Filter: ${RESOURCE_FILTER}`);
  console.log();
  console.log(`Resources found: ${resourceIdsWithTag.length}`);
  console.log();
  console.log(`Control summary:`);

  Object.entries(controlsResult.controlsByResourceList.metadata.stats.control).forEach(([state,count]) => {
    console.log("  " + state.toUpperCase().padStart(7) + ": " + count);
  });

  if (controlsResult.controlList.items.length > 0) {

    console.log();
    console.log(`Alerts by resource:`);
    var currentResourceId = null;
    for (const control of controlsResult.controlList.items) {
      if (control.resource.turbot.id != currentResourceId) {
        console.log();
        console.log("  " + control.resource.trunk.items.map(i => { return i.turbot.title }).join(" > ") + ":");
        currentResourceId = control.resource.turbot.id;
      }
      console.log("    " + control.state.toUpperCase().padStart(7) + ": " + control.type.trunk.items.map(i => { return i.turbot.title }).join(" > "));
    }

    console.log();
    console.log(`Alerts by control type:`);
    var currentControlTypeUri = null;
    for (const control of _.sortBy(controlsResult.controlList.items, i => { return i.type.uri })) {
      if (control.type.uri != currentControlTypeUri) {
        console.log();
        console.log("  " + control.type.trunk.items.map(i => { return i.turbot.title }).join(" > ") + ":");
        currentControlTypeUri = control.type.uri;
      }
      console.log("    " + control.state.toUpperCase().padStart(7) + ": " + control.resource.trunk.items.map(i => { return i.turbot.title }).join(" > "));
    }

  }

  console.log();

}

main().catch(error => console.error(error))
