const yaml = require("js-yaml");
const fs = require("fs");
const util = require("util");
const path = require("path");
const nunjucks = require("nunjucks");
const moment = require("moment");
const chalk = require("chalk");

const readFile = util.promisify(fs.readFile);
const writeFile = util.promisify(fs.writeFile);
const readdir = util.promisify(fs.readdir);

async function loadTemplate(calcPolicyName) {
  const fileContents = await readFile(`${__dirname}/templates/calc-policy/${calcPolicyName}/template.yml`, "utf8");
  return yaml.safeLoad(fileContents);
}

async function harvestedVariables(calcPolicyName) {
  const resolved = path.resolve(`${__dirname}/../calculated_policies/${calcPolicyName}/variables.tf`);
  let contents = await readFile(resolved, "utf8");
  contents = contents.split("\n\n");

  const variables = [];

  for (const line of contents) {
    const result = line.match(/variable "(\w+)"/);

    if (result.length === 1) {
      console.log(chalk.red(`Error finding variable name for block\n${line}`));
      continue;
    }

    const mandatoryTest = RegExp("default\\s*=");
    const mandatory = !mandatoryTest.test(line);

    variables.push({ name: result[1], mandatory });
  }

  return variables;
}

function isString(variable) {
  return typeof variable === "string";
}

function isArray(variable) {
  return variable instanceof Array;
}

async function main() {
  console.log(chalk.gray(`Generate Documentation: Calculated Policies\nStart time: ${moment().format()}`));

  let calcPolicies = await readdir(`${__dirname}/templates/calc-policy`, { withFileTypes: true });
  calcPolicies = calcPolicies.filter((v) => v.isDirectory());

  var env = new nunjucks.Environment();
  env.addFilter("isString", isString);
  env.addFilter("isArray", isArray);

  for (const calcPolicy of calcPolicies) {
    try {
      const calcPolicyName = calcPolicy.name;

      const variables = await harvestedVariables(calcPolicyName);
      const template = await loadTemplate(calcPolicyName);
      const documentTemplate = await readFile(`${__dirname}/templates/calc-policy/document.njk`, "utf8");

      const documentRenderContext = { variables, configuration: template };

      const renderedDocument = env.renderString(documentTemplate, documentRenderContext);
      const documentDestination = path.resolve(`${__dirname}/../calculated_policies/${calcPolicyName}/README.md`);

      await writeFile(documentDestination, renderedDocument);

      console.log(chalk.white(`Generated Document: ${calcPolicyName}`));

      calcPolicy.resource = template.resource;
      calcPolicy.description = template.description;
      calcPolicy.details = template.details;
    } catch (e) {
      console.error(chalk.red(`Error generating calculated policy ${calcPolicy.name}\nOriginal Error:\n`, e));
    }
  }

  const indexDocumentTemplate = await readFile(`${__dirname}/templates/calc-policy/index-document.njk`, "utf8");

  const indexDocumentRenderContext = { configuration: { calcPolicies } };

  const renderedIndexDocument = env.renderString(indexDocumentTemplate, indexDocumentRenderContext);
  const indexDocumentDestination = path.resolve(`${__dirname}/../calculated_policies/README.md`);

  await writeFile(indexDocumentDestination, renderedIndexDocument);

  console.log(chalk.white(`Generated Index Document: Calculated Policies`));
  console.log(chalk.gray(`Generate Documentation: Calculated Policies Complete\nEnd time: ${moment().format()}`));
}

main();
