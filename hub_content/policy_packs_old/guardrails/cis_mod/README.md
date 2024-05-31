# CIS - Mods install

Turbot provides CIS mod, covering CIS policies and controls definition, mods are installed with the top Turbot resource as the parent. This means that administrators must be at the Turbot resource level with Turbot/Owner permissions to make modifications, installing, uninstalling, or updating, to mods in the environment.

More information can be found [here](https://turbot.com/v5/docs/mods)

## Requirements

- Terraform v0.13 or greater installed
- Valid Turbot configuration credentials

For further information on configuring Turbot credentials can be found [here](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials).

### Initialize

1. Navigate to the cis_mod folder.
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

### Apply installation

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

### Destroy installation

If seeking to apply the installation without using an input variable file.

1. Navigate to the folder containing the installation configuration.
2. Run the command:

   ```shell
   terraform destroy
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
