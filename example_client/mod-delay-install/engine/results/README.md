# Mods install

You will need to ensure that the Turbot environment that you would like to connect to has a correctly configured Turbot Profile.
See [Turbot Configure](https://turbot.com/v5/docs/reference/cli/commands/configure) for more details

You need to navigate to the folder which contains the scripts to install the mods to an environment.

By default, the script has a 5 minutes backoff timer set.
This is configurable.

## Basic Install

Assumptions:

- That an environment has no currently installed mods.
- Turbot configuration exits

To install, run the commands:

```shell
terraform init
terraform plan
terraform apply
```

## FAQ

### What happens if the mod exists?

Sometimes it is impossible to not have a mod installed in the environment before installing the remaining mods.

For this type of error, you will observe an error from Terraform in the form:

```text
│ Error: mod tmod:@turbot/aws is already installed ( id: 175644365378576 ). To manage this mod using Terraform, import the mod using command 'terraform import <resource_address> <id>'
│
│   with turbot_mod.aws,
│   on mods.tf line 34, in resource "turbot_mod" "aws":
│   34: resource "turbot_mod" "aws" {
│
```

This error message detailst that the mod already is installed in the environment.
You will need to notify Terraform of its existence.
To do this you will simply use the command `terraform import` with the details given in the error message.

How to add the resource to tracking:

```shell
terraform import turbot_mod.aws 175644365378576
```

As you can see from the error message, we were given both the ID and the name of the control that was at fault.

Once you have inported the existing resource, you can then re-use `terraform apply` and continue applying for missing mods.

### Terraform is taking forever to startup

This is generally due to a huge terraform script.
You could help terraform by creating a plan and saving that to disk then reusing that plan.

To create the plan:

```shell
terraform plan --out myplan
```

To use a created plan:

```shell
terraform apply myplan
```

**NOTE:** If you run a `terraform import` then `terraform plan --out myplan` will have to be re-run before running apply once again.
