const { GraphQLClient } = require("graphql-request");
const btoa = require("btoa");

async function main() {
  const endpoint = process.env.TURBOT_GRAPHQL_ENDPOINT;
  const accessKeyId = process.env.TURBOT_ACCESS_KEY_ID;
  const secretAccessKey = process.env.TURBOT_SECRET_ACCESS_KEY;

  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: "Basic " + btoa(`${accessKeyId}:${secretAccessKey}`)
    }
  });

  var mutation = `
    mutation CreatePolicySetting($input: CreatePolicySettingInput!) {
      createPolicySetting(input: $input) {
        turbot {
          id
        }
      }
    }`;

  let services = [
    ["gcp-appengine", "appEngineApiEnabled"],
    ["gcp-bigquery", "bigQueryApiEnabled"],
    ["gcp-bigtable", "bigtableApiEnabled"],
    ["gcp-computeengine", "computeEngineApiEnabled"],
    ["gcp-dataproc", "dataprocApiEnabled"],
    ["gcp-dns", "dnsApiEnabled"],
    ["gcp-functions", "functionsApiEnabled"],
    ["gcp-iam", "iamApiEnabled"],
    ["gcp-kms", "kmsApiEnabled"],
    ["gcp-kubernetesengine", "kubernetesEngineApiEnabled"],
    ["gcp-logging", "loggingApiEnabled"],
    ["gcp-monitoring", "monitoringApiEnabled"],
    ["gcp-network", "networkServiceApiEnabled"],
    ["gcp-pubsub", "pubsubApiEnabled"],
    ["gcp-spanner", "spannerApiEnabled"],
    ["gcp-sql", "sqlApiEnabled"],
    ["gcp-storage", "storageApiEnabled"]
  ];

  let policymap = new Map(services);

  // Query to get the ID of Turbot
  const query = `
    query MyQuery {
      resource(id: "tmod:@turbot/turbot#/") {
        turbot {
          id
        }
      }
    }`;

  const data = await graphQLClient.request(query, {});
  console.log(data);
  // Turbot resource Id of the resource at which the policy should be set.
  // Can also set it explicitly to specific target like Folder or GCP Project
  // let resourceId = "176097085664257";
  let resourceId = data.resource.turbot.id;

  for (let [key, value] of policymap) {
    var vars = {
      input: {
        type: `tmod:@turbot/${key}#/policy/types/${value}`,
        resource: resourceId,
        precedence: "REQUIRED",
        value: "Enforce: Enabled",
        templateInput: null,
        template: null,
        note: null,
        validFromTimestamp: null,
        validToTimestamp: null
      }
    };
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
