# Baseline - GCP Check Encryption Policies

GCP Check Encryption Policies focuses enabling some commonly used GCP resource encryption status. 

Encryption at Rest refers specifically to the encryption of data when written to an underlying storage system.

Encryption in Transit refers specifically to the encryption of data while data moves between your site and the cloud provider or between two services.

More details on [Encryption Guardrails](https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest)

## Overview

Baseline policies are initial set of policies recommended to start with while using Turbot. These policies mostly focuses on enabling services, frequently used policies to run in check mode & enabling security features such as various encryption standards. Baseline TF scripts allows you to toggle the value to apply or ignore. See the below sections for more information.

Some of these policies overlap with other set of baselines. Hence Turbot provided set of baseline TF files are executed in separate [Smart Folder](https://turbot.com/v5/docs/getting-started/smart_folder). The advantage of setting up of each baseline in their own Smart Folder prevents conflicting with the policy settings created by other baseline scripts.

This baseline will not attach to a resource by default. This needs to be done manually using the Turbot UI.

## Requirements

- Terraform v0.13 or greater installed
- Valid Turbot configuration credentials

For further information on configuring Turbot credentials can be found [here](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials).

## Applying baseline

The baseline is defined by a set of files which together define the configuration of the baseline.

### Initialize baseline

If not previously run, Initialize Terraform to get all necessary providers for the baseline.

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform init
   ```

### Deploying demo example

1. Navigate to the folder of the baseline
2. Initialize Terraform
3. Apply the baseline.

On the terminal this will look like:

```shell
cd <baseline_folder>
terraform init
terraform apply
```

### Apply baseline without input variable file

The baseline can be applied without an input variable file.

1. By this time Terraform initialization is done as mentioned above.
3. Prefer to check the outcome by running the Terraform plan
3. Apply the Terraform
4. Run the command:

```shell
cd <baseline_folder>
terraform plan
terraform apply
```

`This may prompt the user applying the baseline to enter values for variables that do not have default values.`

### Destroy baseline without input variable file

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