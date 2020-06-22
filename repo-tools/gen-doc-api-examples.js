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

async function harvestedOptions(calcPolicyName) {
  const resolved = path.resolve(
    `${__dirname}/../api_examples/graphql/clients/python/${calcPolicyName}/${calcPolicyName}.py`
  );
  let contents = await readFile(resolved, "utf8");
  contents = contents.split("\n");

  const options = [];
  options.hasMandatory = false;

  for (const line of contents) {
    const isClickOption = line.search(/@click.option/) !== -1;
    if (!isClickOption) continue;

    const names = [];

    const longName = line.match(/'(--[a-zA-Z-_]*)'/);
    if (longName && longName.length === 2) {
      names.push(longName[1]);
    }
    const shortName = line.match(/'(-[a-zA-Z][a-zA-Z-_]*)'/);
    if (shortName && shortName.length === 2) {
      names.push(shortName[1]);
    }
    const help = line.match(/help="(.*)"/)[1];
    const mandatory = line.search(/required=True/) !== -1;
    if (mandatory) {
      options.hasMandatory = true;
    }

    options.push({ names, help, mandatory });
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

  for (const pythonTemplate of pythonTemplates) {
    try {
      const definitionTemplate = await loadPythonTemplate(pythonTemplate.name);

      definitionTemplate.name = pythonTemplate.name;
      const options = await harvestedOptions(pythonTemplate.name);
      const renderContext = { configuration: definitionTemplate, options };
      const masterTemplate = await loadMasterTemplate("templates/api-examples/python.njk");

      const renderedDocument = nunjucks.renderString(masterTemplate, renderContext);

      await saveDocument(`api_examples/graphql/clients/python/${pythonTemplate.name}/README.md`, renderedDocument);

      console.log(chalk.white(`Generated Document: ${pythonTemplate.name}`));
    } catch (e) {
      console.error(chalk.red(`Error generating calculated policy ${pythonTemplate.name}\nOriginal Error:\n`, e));
    }
  }

  console.log(chalk.gray(`Generate Documentation: Api Examples Complete\nEnd time: ${moment().format()}`));
}

main();
