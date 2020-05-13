const { GraphQLClient } = require("graphql-request");
const btoa = require("btoa");

// Possible values can at the url https://turbot.com/v5/docs/concepts/notifications#notification-types
// Multiple type are possible - Below example is same as notificationType:resource
const NOTIFICATION_TYPE = "resource_created,resource_updated,resource_deleted";
// Single types are also possible, see commented example
// const NOTIFICATION_TYPE = "resource_created";

// Notifications can be filtered by a time range. The below examples returns all notifications for the last 10 days
// For more information on date time filters: https://turbot.com/v5/docs/reference/filter#datetime-filters
const DATE_TIME_FILTER = "<T-10d";

// Notifications can be sorted. The below examples sorts the returned results in reverse order (latest first).
// For more information on sorting: https://turbot.com/v5/docs/reference/filter#sorting
const SORT_TYPE = "-timestamp";

async function main() {
  const endpoint = process.env.TURBOT_GRAPHQL_ENDPOINT;
  const accessKeyId = process.env.TURBOT_ACCESS_KEY_ID;
  const secretAccessKey = process.env.TURBOT_SECRET_ACCESS_KEY;

  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: "Basic " + btoa(`${accessKeyId}:${secretAccessKey}`),
    },
  });

  console.log(`Query notifications for type: ${NOTIFICATION_TYPE}`);
  console.log(`Applying timestamp filter: ${DATE_TIME_FILTER}`);
  console.log(`Applying sorting: ${SORT_TYPE}`);

  /* 
    The query returns unnecessary fields which will be populated depending on the value of the resource type class
    
    If the type is a member of the notification class resource, fields returned: [ resource ]
    If the type is a member of the notification class policyValue, fields returned: [ resource, policyValue ]
    If the type is a member of the notification class policySetting, fields returned: [ resource, policySetting ]
    If the type is a member of the notification class control, fields returned: [ resource, control ]
    If the type is a member of the notification class grant, fields returned: [ resource, grant ]
    If the type is a member of the notification class activeGrant, fields returned: [ resource ]
  */
  const query = `
    query {
      notifications(filter: "type:${NOTIFICATION_TYPE} timestamp:${DATE_TIME_FILTER} sort:${SORT_TYPE}") {
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

  const emptyVariables = {};

  const data = await graphQLClient.request(query, emptyVariables);

  console.log(JSON.stringify(data, null, 2));
}

main().catch((error) => console.error(error));
