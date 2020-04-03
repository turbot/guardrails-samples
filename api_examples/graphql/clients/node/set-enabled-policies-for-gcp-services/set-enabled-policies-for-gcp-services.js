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
    ["gcp-appengine", "appEngineEnabled"],
    ["gcp-bigquery", "bigQueryEnabled"],
    ["gcp-bigtable", "bigtableEnabled"],
    ["gcp-computeengine", "computeEngineEnabled"],
    ["gcp-dataproc", "dataprocEnabled"],
    ["gcp-dns", "dnsEnabled"],
    ["gcp-functions", "functionsEnabled"],
    ["gcp-iam", "iamEnabled"],
    ["gcp-kms", "kmsEnabled"],
    ["gcp-kubernetesengine", "kubernetesEngineEnabled"],
    ["gcp-logging", "loggingEnabled"],
    ["gcp-monitoring", "monitoringEnabled"],
    ["gcp-network", "networkServiceEnabled"],
    ["gcp-pubsub", "pubsubEnabled"],
    ["gcp-spanner", "spannerEnabled"],
    ["gcp-sql", "sqlEnabled"],
    ["gcp-storage", "storageEnabled"]
  ];

  let policyMap = new Map(services);

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

  for (let [key, value] of policyMap) {
    var vars = {
      input: {
        type: `tmod:@turbot/${key}#/policy/types/${value}`,
        resource: resourceId,
        precedence: "REQUIRED",
        value: "Enabled",
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
