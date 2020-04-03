/**
 * To get the list of installed mods which requires update.
 */

const { GraphQLClient } = require("graphql-request");
const btoa = require("btoa");

const filter =
  "resourceType:'tmod:@turbot/turbot#/resource/types/mod' resourceTypeLevel:self limit:300";

async function main() {
  const endpoint = process.env.TURBOT_GRAPHQL_ENDPOINT;
  const accessKeyId = process.env.TURBOT_ACCESS_KEY_ID;
  const secretAccessKey = process.env.TURBOT_SECRET_ACCESS_KEY;

  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: "Basic " + btoa(`${accessKeyId}:${secretAccessKey}`)
    }
  });

  const installedModsQuery = `
    query installedMods($filter: [String!]!, $paging: String) {
      installedMods: resources(filter: $filter, paging: $paging) {
        items {
          modId: get(path: "$id")
          tModId: get(path: "tmod.$id")
          initialName: get(path: "package.name")
          initialVersion: get(path: "package.version")
          name: get(path: "name")
          version: get(path: "version")
        }
        paging {
          next
        }
      }
    }
  `;

  const eachModInfo = `
    query modInfo($orgName: String, $modName: String) {
      modInfo: modVersionSearches(orgName: $orgName, modName: $modName) {
        items {
          identityName
          name
          versions {
            status
            version
          }
        }
      }
    }
  `;

  let installedMods = [];
  let modsToUpdate = [];
  let modWithoutRecommended = [];
  let paging = null;

  // Get list of all installed Mods in workspace
  do {
    const variables = { filter, paging };
    const data = await graphQLClient.request(installedModsQuery, variables);
    installedMods = installedMods.concat(data.installedMods.items);
    paging = data.installedMods.paging.next;
  } while (paging);
  console.log(`No of Mods : ${installedMods.length}`);

  // For each installed Mod get details from registry and
  for (mod of installedMods) {
    let modName = mod.modId.split("/").pop();
    console.log("\nMod Name: ", modName);
    let vars = { orgName: "turbot", modName };
    try {
      let run = await graphQLClient.request(eachModInfo, vars);
      let currentVersion = mod.version;

      // Get the recommended version of the mod
      let recommended = run.modInfo.items[0].versions.find(
        info => info.status === "RECOMMENDED"
      );

      // If recommended version is not available mod not required to be updated
      if (!recommended) {
        modWithoutRecommended.push(run.modInfo.items[0].name);
        continue;
      }
      console.info("\x1b[37mCurrent :      \x1b[0m", currentVersion);
      console.info("\x1b[34mRecommended :  \x1b[0m", recommended.version);

      // If current version and recommended version is same mod is not required to be updated
      if (currentVersion !== recommended.version) {
        modsToUpdate.push({
          name: run.modInfo.items[0].name,
          version: recommended.version
        });
      }
    } catch (e) {
      console.error(e);
    }
  }

  console.info("\nMODS TO BE UPDATED: \n", modsToUpdate);
  console.info("\nMODS WITHOUT RECOMMENDED VERSION: \n", modWithoutRecommended);
}

main().catch(error => console.error(error));
