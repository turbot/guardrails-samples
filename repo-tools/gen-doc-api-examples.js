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

function isString(variable) {
  return typeof variable === "string";
}

function isArray(variable) {
  return variable instanceof Array;
}

async function harvestedOptions(calcPolicyName) {
  // "/home/omerosaienni/git-source/omerosaienni/tdk/api_examples/graphql/clients/python/aws_import/aws_import.py";
  const resolved = path.resolve(
    `${__dirname}/../api_examples/graphql/clients/python/${calcPolicyName}/${calcPolicyName}.py`
  );
  let contents = await readFile(resolved, "utf8");
  contents = contents.split("\n");

  const options = [];

  for (const line of contents) {
    const isClickOption = line.search(/@click.option/) !== -1;
    if (!isClickOption) continue;

    const name = line.match(/'--([a-zA-Z-_]*)'/)[1];
    const help = line.match(/help="(.*)"/)[1];
    const mandatory = line.search(/required=True/) !== -1;

    options.push({ name, help, mandatory });
  }

  return options;
}

async function saveDocument(location, document) {
  const documentDestination = path.resolve(`${__dirname}/../${location}`);

  await writeFile(documentDestination, document);
}

async function loadMasterTemplate(location) {
  return await readFile(`${__dirname}/${location}`, "utf8");
}

async function listTemplates(location) {
  const templates = await readdir(`${__dirname}/${location}`, { withFileTypes: true });
  return templates.filter((v) => v.isDirectory());
}

async function loadPythonTemplate(name) {
  const fileContents = await readFile(
    `${__dirname}/templates/api-examples/clients/python/${name}/template.yml`,
    "utf8"
  );

  return yaml.safeLoad(fileContents);
}

async function main() {
  console.log(chalk.gray(`Generate Documentation: Api Examples\nStart time: ${moment().format()}`));

  console.log(chalk.gray(`Generate Documentation: Python Examples`));

  const pythonTemplates = await listTemplates("templates/api-examples/clients/python");
  // const nodeTemplates = await listTemplates("templates/api-examples/clients/node");

  var env = new nunjucks.Environment();
  env.addFilter("isString", isString);
  env.addFilter("isArray", isArray);

  for (const pythonTemplate of pythonTemplates) {
    try {
      const pythonTemplateName = pythonTemplate.name;

      const options = await harvestedOptions(pythonTemplateName);

      //const variables = await harvestedVariables(pythonTemplateName);
      const definitionTemplate = await loadPythonTemplate(pythonTemplateName);
      definitionTemplate.name = pythonTemplateName;

      const masterTemplate = await loadMasterTemplate("templates/api-examples/python-template.njk");

      const renderContext = { configuration: definitionTemplate, options };
      const renderedDocument = env.renderString(masterTemplate, renderContext);

      await saveDocument(`api_examples/graphql/clients/python/${pythonTemplateName}/README.md`, renderedDocument);

      console.log(chalk.white(`Generated Document: ${pythonTemplateName}`));

      // calcPolicy.resource = definitionTemplate.resource;
      // calcPolicy.description = definitionTemplate.description;
      // calcPolicy.details = definitionTemplate.details;
    } catch (e) {
      console.error(chalk.red(`Error generating calculated policy ${pythonTemplate.name}\nOriginal Error:\n`, e));
    }
  }

  // const indexDocumentTemplate = await readFile(`${__dirname}/templates/calc-policy/index-document.njk`, "utf8");

  // const indexDocumentRenderContext = { configuration: { calcPolicies } };

  // const renderedIndexDocument = env.renderString(indexDocumentTemplate, indexDocumentRenderContext);
  // const indexDocumentDestination = path.resolve(`${__dirname}/../calculated_policies/README.md`);

  // await writeFile(indexDocumentDestination, renderedIndexDocument);

  // console.log(chalk.white(`Generated Index Document: Calculated Policies`));
  // console.log(chalk.gray(`Generate Documentation: Calculated Policies Complete\nEnd time: ${moment().format()}`));
}

main();
