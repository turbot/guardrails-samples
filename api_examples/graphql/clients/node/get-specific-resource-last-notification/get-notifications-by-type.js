const { GraphQLClient } = require("graphql-request");
const btoa = require("btoa");

// For this example, we have used the aka of the Turbot resource as we know this is constant.
// The code will take the resource AKA and do a resource id lookup.
// The code will then use this resource id to get the notifications for that resource.
const RESOURCE_AKA = "tmod:@turbot/turbot#/";

// Sets the amount of notifications we want to get back from the Turbot instance.
// In the example it is set to 1, getting the last notification.
// Changing this will return the last n notifications, where n is the limit.
const FILTER_LIMIT = "1";

async function main() {
  const endpoint = process.env.TURBOT_GRAPHQL_ENDPOINT;
  const accessKeyId = process.env.TURBOT_ACCESS_KEY_ID;
  const secretAccessKey = process.env.TURBOT_SECRET_ACCESS_KEY;

  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: "Basic " + btoa(`${accessKeyId}:${secretAccessKey}`),
    },
  });

  const emptyVariables = {};

  // -------------------------------------------------------------------
  // Query 1: Find the resource id when an aka is provided
  // -------------------------------------------------------------------

  console.log(`Looking up resource id for resource: ${RESOURCE_AKA}`);
  const lookupQuery = `
    query {
      resource(id: "${RESOURCE_AKA}") {
        turbot {
          title
          id
        }
      }
    }
  `;

  const lookupResult = await graphQLClient.request(lookupQuery, emptyVariables);

  // Look up was successful, set the id
  const foundItem = lookupResult.resource.turbot;
  console.log(`Resource id found: ${foundItem.id}`);

  // -------------------------------------------------------------------
  // Query 2: Find the notifications based on the id found in the lookup
  // -------------------------------------------------------------------

  console.log(`Querying last ${FILTER_LIMIT} notification(s) for resource ${foundItem.title}`);

  /* 
    The query returns unnecessary fields which will be populated depending on the value of the resource type class
    
    If the type is a member of the notification class resource, fields returned: [ resource ]
    If the type is a member of the notification class policyValue, fields returned: [ resource, policyValue ]
    If the type is a member of the notification class policySetting, fields returned: [ resource, policySetting ]
    If the type is a member of the notification class control, fields returned: [ resource, control ]
    If the type is a member of the notification class grant, fields returned: [ resource, grant ]
    If the type is a member of the notification class activeGrant, fields returned: [ resource ]
  */
  const notificationsQuery = `
    query {
      notifications(filter: "resource:${foundItem.id} limit:${FILTER_LIMIT} sort:-timestamp") {
        items
        {
          notificationType

          policyValue {
            default
            value
            state
            reason
            details
            secretValue
            isCalculated
          }

          policyValue {
            default
            value
            state
            reason
            details
            secretValue
            isCalculated
          }
          grant {
            permissionTypeId
            permissionLevelId
            roleName
            validFromTimestamp
            validToTimestamp
          }

          control {
            reason
            details
          }

          resource {
            object
          }
        }
      }
    }
  `;

  const notificationsResult = await graphQLClient.request(notificationsQuery, emptyVariables);

  console.log(JSON.stringify(notificationsResult, null, 2));
}

main().catch((error) => console.error(error));
