# Baseline - GCP Baseline

GCP Baseline Policies focuses on base minimum set of example policies & services to start with such as 

- Sevice Enablement
- Service API Enablement
- Event Polling
- Enable CIS

This baseline turns on GCP services that are provided by an input variable file.
If none are provided then all services will be enabled.
Enabling / disabling a service consists of enabling / disabling the service and API access to that service.
The variable to use is `service_status`.

The baseline will configure GCP to use polling unless specified to use event handling in the input variable file.
The variable to use is `use_event_polling`.

Additionally the baseline will enable CIS and set attestation of CIS to be a year.
Currently there is no variable to control this behavior.

## Important

Running the baseline without an input variable file assumes that you have **ALL** GCP mods installed.
To limit the baseline, look at the example input variable file [demo.tfvars](demo.tfvars).

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

### Deploying demo example

The demo baseline expects that the following mods are installed:

- gcp-iam
- gcp-pubsub
- gcp-storage
- gcp-logging

To run the baseline:

1. Navigate to the folder of the baseline
2. Initialise Terraform
3. Apply the baseline using the demo input variable file [demo.tfvars](demo.tfvars)

On the terminal this will look like:

```shell
cd <baseline_folder>
terraform init
terraform apply --var-file demo.tfvars
```

**Note** 

- Most of the variables in demo.tfvars are marked as `false`, as they are not part of required initial policies. This can be made `true` based on need.

- Some of the baseline scripts may not have the `demo.tfvars`, you may execute only with default varialble file.

### Input variable files

Input variable files allow for the user to configure configuration definitions for multiple environments in different files.

It will be used to define which parts of the baseline to apply and which to ignore.

The variables that can be overwritten by the input variable files are defined in the [variables.tf](variables.tf) file.

This baseline comes with an example input variable file called [demo.tfvars](demo.tfvars).

Further details found in official [Terraform documentation](https://www.terraform.io/docs/language/values/variables.html).

### Initialise baseline

If not previously run, initialise Terraform to get all necessary providers for the baseline.

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform init
   ```

### Apply baseline without input variable file

The baseline can be applied without an input variable file.

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform apply
   ```

This may prompt the user applying the baseline to enter values for variables that do not have default values.

### Apply baseline using input variable files

If seeking to apply the baseline using an input variable file such as [demo.tfvars](demo.tfvars).

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform apply --var-file=demo.tfvars
   ```

### Destroy baseline without input variable file

If seeking to apply the baseline without using an input variable file.

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform destroy
   ```

### Destroy using input variable files

If seeking to destoy the baseline configuration using an input variable file such as [demo.tfvars](demo.tfvars).

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform destroy --var-file=demo.tfvars
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
