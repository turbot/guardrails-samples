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

async function loadConfiguration(calcPolicyName) {
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

  const template = await readFile(`${__dirname}/templates/calc-policy/template.njk`, "utf8");

  for (const calcPolicy of calcPolicies) {
    try {
      const calcPolicyName = calcPolicy.name;
      const variables = await harvestedVariables(calcPolicyName);
      const configuration = await loadConfiguration(calcPolicyName);
      const renderContext = { variables, configuration };

      //const renderResultOld = nunjucks.render(`${__dirname}/templates/calc-policy/template.njk`, renderContext);

      var env = new nunjucks.Environment();

      env.addFilter("isString", isString);
      env.addFilter("isArray", isArray);
      const renderResult = env.renderString(template, renderContext);

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
