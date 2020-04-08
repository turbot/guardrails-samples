const { GraphQLClient } = require("graphql-request");
const btoa = require("btoa");

// Possible values allowed are: [ "resource", "policyValue", "policySetting", "control", "grant", "activeGrant" ]
const NOTIFICATION_TYPE_CLASS = "resource";

async function main() {
  const endpoint = process.env.TURBOT_GRAPHQL_ENDPOINT;
  const accessKeyId = process.env.TURBOT_ACCESS_KEY_ID;
  const secretAccessKey = process.env.TURBOT_SECRET_ACCESS_KEY;

  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: "Basic " + btoa(`${accessKeyId}:${secretAccessKey}`),
    },
  });

  /* 
    The query returns unnecessary fields which will be populated depending on the value of the resource type class
    
    If the NOTIFICATION_TYPE_CLASS is set to resource, fields returned: [ resource ]
    If the NOTIFICATION_TYPE_CLASS is set to policyValue, fields returned: [ resource, policyValue ]
    If the NOTIFICATION_TYPE_CLASS is set to policySetting, fields returned: [ resource, policySetting ]
    If the NOTIFICATION_TYPE_CLASS is set to control, fields returned: [ resource, control ]
    If the NOTIFICATION_TYPE_CLASS is set to grant, fields returned: [ resource, grant ]
    If the NOTIFICATION_TYPE_CLASS is set to activeGrant, fields returned: [ resource ]
  */
  const query = `
    query {
      notifications(filter: "notificationType:${NOTIFICATION_TYPE_CLASS} limit:300 sort:-timestamp") {
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

  const variables = {};

  const data = await graphQLClient.request(query, variables);

  console.log(JSON.stringify(data, null, 2));
}

main().catch((error) => console.error(error));
