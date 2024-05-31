# AWS - Mods install

Turbot provides dozens of AWS mods, covering hundreds of AWS resources, with thousands of policies and controls. By definition, mods are installed with the top Turbot resource as the parent. This means that administrators must be at the Turbot resource level with Turbot/Owner permissions to make modifications, installing, uninstalling, or updating, to mods in the environment.

More information can be found [here](https://turbot.com/v5/docs/mods)

## Requirements

- Terraform v0.13 or greater installed
- Valid Turbot configuration credentials

For further information on configuring Turbot credentials can be found [here](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials).

### Initialize

1. Navigate to the aws_mods folder.
2. Run the command:

   ```shell
   terraform init
   ```

### Profile name as input

This set requires you to provide `turbot_profile` name as input. This is to help in case you are having more profiles than only `default`. In case it's default, specify name as default.

```shell
var.turbot_profile
  Enter profile matching your turbot cli credentials.
  Enter a value: <Enter name of the profile>
```

### Deploying demo example

1. Navigate to the aws_mods folder.
2. Initialize Terraform
3. Apply the installation using the demo input variable file [demo.tfvars](demo.tfvars)

On the terminal this will look like:

```shell
cd <mod_install_folder>
terraform init
terraform apply --var-file demo.tfvars
```

### Input variable files

Input variable files allow for the user to configure configuration definitions for multiple environments in different files.

This script comes with an example input variable file called [demo.tfvars](demo.tfvars).

The variables that can be overwritten by the input variable files i.e. [demo.tfvars](demo.tfvars) are defined in the [variables.tf](variables.tf) file.

Further details found in official [Terraform documentation](https://www.terraform.io/docs/language/values/variables.html).

### Apply installation using input variable files

If seeking to apply the installation using an input variable file such as [demo.tfvars](demo.tfvars).

1. Navigate to the folder containing the installation configuration.
2. Run the command:

   ```shell
   terraform apply --var-file=demo.tfvars
   ```
### Apply installation without input variable file

The installation can be applied without an input variable file.

1. By this time Terraform initialization is done as mentioned above.
3. Prefer to check the outcome by running the Terraform plan
3. Apply the Terraform
4. Run the command:

```shell
cd <mod_install_folder>
terraform plan
terraform apply
```

### Destroy installation without input variable file

If seeking to apply the installation without using an input variable file.

1. Navigate to the folder containing the installation configuration.
2. Run the command:

   ```shell
   terraform destroy
   ```

### Destroy using input variable files

If seeking to destoy the installation configuration using an input variable file such as [demo.tfvars](demo.tfvars).

1. Navigate to the folder containing the installation configuration.
2. Run the command:

   ```shell
   terraform destroy --var-file=demo.tfvars
   ```

## Commenting strategy

All Turbot policies used by the installation will have a link to the official Turbot Mods documentation.

Opening the links will give you further details about:

- The purpose of the policy
- Policy URI name
- Parent information
- Category information
- Target information
- All valid values
