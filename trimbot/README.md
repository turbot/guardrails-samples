# TrimBot

This is a general clean up tool that is extensible by creating your own ingredients and adding them to a clean up recipe.

TrimBot can clean up multiple environments in a single run and is by default run in `dry-run` mode.

The application comes with a recipe to clear down V3 resources, which can be found in the file [managed_recipe.yaml](recipes/managed_recipe.yaml)

Sections:

- [Installing](#Installing)
- [Configuring](#Configuring)
- [Running](#Running)
- [Uninstalling](#Uninstalling)

## Installing

To install the application will require you to [create a virtual environment](#Creating%20the%20virtual%20environment) and then [install the application](#Installing%20the%20application).

### Creating the virtual environment

This sections details how to set up a virtual environment in order for the script to run.

### Virtual environments activation

This application uses the Python version 3 module, [venv](https://docs.python.org/3/library/venv.html) to create the a virtual environment.

1. Navigate to the the root folder of the Trimbot application.
2. Use the following command to create the virtual environment. <BR>The command will create a folder called `.venv` which is a child of the root folder for the applications.

```shell
python3 -m venv .venv
```

3. Activate the environment by running the following command.

```shell
source .venv/bin/activate
```

### Installing the application

1. Ensure that the virual enviroment is activated.
1. Navigate to the the root folder of the Trimbot application.
1. Install application Python library dependencies by running the following command.

```shell
pip3 install .
```

## Configuring

The application is driven by configuration files and expect that AWS has been correctly configured onto the machine that you would like to run the application. More details on configuring the AWS CLI can be found on [offical AWS documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).

Available recipes:

- managed_recipe.yaml

### Configuring master account

To clean up a master account, all you will need is for the AWS client to have a profile that connects to the AWS master account. A typical configuration looks as follows:

```yaml
recipe: "./recipes/managed_recipe.yaml"
workspaces:
  - account: "111122223333"
    profile: v3-master
    turbot:
      account: aaa
      cluster: maincluster
      host: https://test.turbot.com/
      accessKey: "11112222-fac3-424e-94fb-325db1d65503"
      secretAccessKey: 424e94fb-1b3c-4681-944d-cb27d3a325db
```

| Field                       | Purpose                                                                           | Needed |
| --------------------------- | --------------------------------------------------------------------------------- | ------ |
| recipe                      | Configures which recipe to use for all workspaces configured to run with TrimBot. | Yes    |
| workspaces                  | Runs the recipe against the configured workspaces.                                | Yes    |
| workspaces.account          | The AWS account number of the account that will be uninstalled.                   | Yes    |
| workspaces.profile          | The AWS profile of the master account where Turbot master is installed.           | No     |
| workspaces.turbot.account   | The Turbot Account ID of the account to uninstall.                                | Yes    |
| workspaces.turbot.cluster   | The Turbot Cluster ID of the account to uninstall.                                | Yes    |
| workspaces.turbot.host      | The Turbot Host where the account was installed.                                  | Yes    |
| workspaces.turbot.accessKey | The access key used to preform API calls against the Turbot Host.                 | Yes    |
| workspaces.turbot.cluster   | The secret access key used to preform API calls against the Turbot Host.          | Yes    |

The above configuration will set the entire run to use the recipe located at `./recipes/managed_recipe.yaml`.
The account that will be removed from Turbot management is the AWS account with ID `111122223333` using the AWS profile `v3-master`.
The account is given the ID of `aaa` in cluster `maincluster`.

### Configuring managed account

To clean up a managed account is similar to cleaning a master account but this time we provide a role.
The role will be used to assume the role to access the managed account.

```yaml
recipe: "./recipes/managed_recipe.yaml"
workspaces:
  - account: "333322221111"
    profile: v3-master
    roleArn: arn:aws:iam::333322221111:role/turbot-service-role
    externalId: keyphrase
    turbot:
      account: aab
      cluster: awscluster
      host: https://test.turbot.com/
      accessKey: "11112222-fac3-424e-94fb-325db1d65503"
      secretAccessKey: 424e94fb-1b3c-4681-944d-cb27d3a325db
```

| Field                       | Purpose                                                                           | Needed |
| --------------------------- | --------------------------------------------------------------------------------- | ------ |
| recipe                      | Configures which recipe to use for all workspaces configured to run with TrimBot. | Yes    |
| workspaces                  | Runs the recipe against the configured workspaces.                                | Yes    |
| workspaces.account          | The AWS account number of the account that will be uninstalled.                   | Yes    |
| workspaces.profile          | The AWS profile of the master account where Turbot master is installed.           | No     |
| workspaces.roleArn          | The AWS role which will be assumed to access the managed account.                 | Yes    |
| workspaces.externalId       | The External ID for the role if there is one needed.                              | No     |
| workspaces.turbot.account   | The Turbot Account ID of the account to uninstall.                                | Yes    |
| workspaces.turbot.cluster   | The Turbot Cluster ID of the account to uninstall.                                | Yes    |
| workspaces.turbot.host      | The Turbot Host where the account was installed.                                  | Yes    |
| workspaces.turbot.accessKey | The access key used to preform API calls against the Turbot Host.                 | Yes    |
| workspaces.turbot.cluster   | The secret access key used to preform API calls against the Turbot Host.          | Yes    |

The above configuration will set the entire run to use the recipe located at `./recipes/managed_recipe.yaml`.
The account that will be removed from Turbot management is the AWS account with ID `333322221111` using the AWS role.
The account is given the ID of `aab` in cluster `awscluster`.

### Configuring multiple accounts

```yaml
recipe: "./recipes/managed_recipe.yaml"
turbot:
  host: https://test.turbot.com/
  accessKey: "11112222-fac3-424e-94fb-325db1d65503"
  secretAccessKey: 424e94fb-1b3c-4681-944d-cb27d3a325db
workspaces:
  - account: "111122223333"
    profile: v3-master
    turbot:
      account: aaa
      cluster: maincluster
  - account: "333322221111"
    profile: v3-master
    roleArn: arn:aws:iam::333322221111:role/turbot-service-role
    externalId: keyphrase
    turbot:
      account: aab
      cluster: awscluster
  - account: "222233331111"
    roleArn: arn:aws:iam::222233331111:role/turbot-service-role
    turbot:
      account: rex
      cluster: awsaccount
      host: https://production.turbot.com/
      accessKey: "11112222-aaaa-bbbb-cccc-325db1d65503"
      secretAccessKey: 424e94fb-bbbb-aaaa-dddd-cb27d3a325db
```

There is no needed to repeat Turbot host information for each workspace.
If you configure the Turbot details at the parent level, it will be applied to each workspace.
You can override the Turbot connection details on a individual workspace as seen for the Turbot account `rex`.

## Running

### Getting available options

Use the terminal to get available options:

```shell
trimbot --help
```

### TrimBot dry run

To run a dry run clean, you will need a configuration file.

```shell
trimbot --config-file './path/to/file.yaml'
```

### TrimBot trace approved run

To run an approved clean up run, you will need to add the option `--approve`.

```shell
trimbot --config-file './path/to/file.yaml' --approve
```

### TrimBot check run

To run check ingredients only, you will have to add the option `--check`.
The check ingredient for recipe `managed_recipe.yaml` checks to see if the S3 buckets are ready to be deleted.

```shell
trimbot --config-file './path/to/file.yaml' --check
```

## Uninstalling

In order to uninstall the application, it is advised to simply remove the virtual folder that was created when [creating a virtual enviroment](#Creating%20the%20virtual%20environment).

If the virtual environment is currently active, you will have to [deactivate the virtual environnment](#Deactivating%20current%20virtual%20environment) before removing the folder.

### Deactivating current virtual environment

This is accomplished by running the command in the same folder that we created the environment by applying the command:

```shell
deactivate
```

### Remove the folder

In the same directory that we created the virtual enviroment, you can remove the vitual environment by running the command:

```shell
rm -rf ./.venv
```
