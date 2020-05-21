const yaml = require("js-yaml");
const fs = require("fs");
const util = require("util");
const hclParser = require("js-hcl-parser");
const path = require("path");
const nunjucks = require("nunjucks");
const moment = require("moment");

const readFile = util.promisify(fs.readFile);
const writeFile = util.promisify(fs.writeFile);
const readdir = util.promisify(fs.readdir);

async function loadVariables(calcPolicy) {
  const resolved = path.resolve(`${__dirname}/../calculated_policies/${calcPolicy}/variables.tf`);
  let contents = await readFile(resolved, "utf8");
  contents = contents.match(/.*\n/g);

  for (let index in contents) {
    contents[index] = contents[index].replace(/\s+/g, " ");
    contents[index] = contents[index].replace("= string", '= "string"');
    contents[index] = contents[index].trimEnd();
  }

  contents = contents.join("\n");
  contents = hclParser.parse(contents);
  contents = JSON.parse(contents);

  return contents.variable;
}

async function loadConfiguration(configuration) {
  const fileContents = await readFile(`${__dirname}/templates/calc-policy/${configuration}/template.yml`, "utf8");
  return yaml.safeLoad(fileContents);
}

async function harvestedVariables(configuration) {
  const harvestedVariables = [];
  const variables = await loadVariables(configuration);

  for (const variable of variables) {
    const name = Object.keys(variable)[0];
    const mandatory = !variable[name][0].default;

    harvestedVariables.push({ name, mandatory });
  }

  return harvestedVariables;
}

async function main() {
  console.log(`Generate Documentation: Calculated Policies - ${moment().format()}`);

  const calcPolicies = await readdir(`${__dirname}/templates/calc-policy`);

  for (const calcPolicy of calcPolicies) {
    try {
      const variables = await harvestedVariables(calcPolicy);
      const configuration = await loadConfiguration(calcPolicy);
      const renderContext = { variables, configuration };

      const renderResult = nunjucks.render(`${__dirname}/templates/calc-policy-template.njk`, renderContext);

      const destination = path.resolve(`${__dirname}/../calculated_policies/${calcPolicy}/README.md`);
      await writeFile(destination, renderResult);
    } catch (e) {
      console.error(`Error generating calculated policy: ${calcPolicy}`, e);
    }
  }

  console.log(`Generate Documentation Complete - ${moment().format()}`);
}

main();
