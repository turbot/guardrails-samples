const yaml = require("js-yaml");
const fs = require("fs");
const util = require("util");
const hclParser = require("js-hcl-parser");
const path = require("path");
const nunjucks = require("nunjucks");
const moment = require("moment");
const chalk = require("chalk");

const readFile = util.promisify(fs.readFile);
const writeFile = util.promisify(fs.writeFile);
const readdir = util.promisify(fs.readdir);

async function loadVariables(calcPolicyName) {
  const resolved = path.resolve(`${__dirname}/../calculated_policies/${calcPolicyName}/variables.tf`);
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

async function loadConfiguration(calcPolicyName) {
  const fileContents = await readFile(`${__dirname}/templates/calc-policy/${calcPolicyName}/template.yml`, "utf8");
  return yaml.safeLoad(fileContents);
}

async function harvestedVariables(calcPolicyName) {
  const harvestedVariables = [];
  const variables = await loadVariables(calcPolicyName);

  for (const variable of variables) {
    const name = Object.keys(variable)[0];
    const mandatory = !variable[name][0].default;

    harvestedVariables.push({ name, mandatory });
  }

  return harvestedVariables;
}

async function main() {
  console.log(chalk.gray(`Generate Documentation: Calculated Policies\nStart time: ${moment().format()}`));

  let calcPolicies = await readdir(`${__dirname}/templates/calc-policy`, { withFileTypes: true });
  calcPolicies = calcPolicies.filter((v) => v.isDirectory());

  for (const calcPolicy of calcPolicies) {
    try {
      const calcPolicyName = calcPolicy.name;
      const variables = await harvestedVariables(calcPolicyName);
      const configuration = await loadConfiguration(calcPolicyName);
      const renderContext = { variables, configuration };

      const renderResult = nunjucks.render(`${__dirname}/templates/calc-policy/template.njk`, renderContext);

      const destination = path.resolve(`${__dirname}/../calculated_policies/${calcPolicyName}/README.md`);
      await writeFile(destination, renderResult);
      console.log(chalk.white(`Generated Document: ${calcPolicyName}`));
    } catch (e) {
      console.error(chalk.red(`Error generating calculated policy ${calcPolicy.name}\nOriginal Error:\n`, e));
    }
  }

  console.log(chalk.gray(`Generate Documentation Complete\nEnd time: ${moment().format()}`));
}

main();
