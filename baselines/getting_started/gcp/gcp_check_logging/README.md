# Baseline - GCP Check Logging Policies

GCP Check Logging Policies focuses on an example of a deeper baseline for a specific service.

Some of these policies might overlap with other baselines.

The advantage of setting up of each baseline in their own Smart Folder prevents conflicting with the policy settings created by other baselines.

This baseline will not attach to a resource and will need to be done manually using the Turbot UI.

## Requirements

- Terraform v0.13 or greater installed
- Valid Turbot configuration credentials

For further information on configuring Turbot credentials can be found [here](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials).

## Applying baseline

The baseline is defined by a set of files which together define the configuration of the baseline.

### Deploying demo example

1. Navigate to the folder of the baseline
2. Initialize Terraform

On the terminal this will look like:

```shell
cd <baseline_folder>
terraform init
terraform apply
```

### Input variable files

Input variable files allow for the user to configure configuration definitions for multiple environments in different files.

It will be used to define which parts of the baseline to apply and which to ignore.

The variables that can be overwritten by the input variable files are defined in the [variables.tf](variables.tf) file.

Further details found in official [Terraform documentation](https://www.terraform.io/docs/language/values/variables.html).

### Initialize baseline

If not previously run, initialize Terraform to get all necessary providers for the baseline.

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform init
   ```

### Apply baseline

The baseline can be applied without an input variable file.

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform apply
   ```

This may prompt the user applying the baseline to enter values for variables that do not have default values.

### Destroy baseline

If seeking to apply the baseline without using an input variable file.

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform destroy
   ```

## Commenting strategy

All Turbot policies used by the baselines will have a link to the official Turbot Mods documentation.

Opening the links will give you further details about:

- The purpose of the policy
- Policy URI name
- Parent information
- Category information
- Target information
- All valid values