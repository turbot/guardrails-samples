# Baseline - Azure Check Regions

This baseline will allow you to discover resources in multiple regions and not approve usage of resource that are not
in an allowable region.

This baseline is only effective when the account regions policies have multiple regions set.

The account approved regions `Azure > Subscription > Approved Regions [Default]` policy contains a list of Azure regions in which
cloud resources are approved for use.

The policy `Azure > Subscription > Regions [Default]` contains a list of Azure region where a resource can be recorded (discovered).

If the [Azure Baseline](../azure_baseline/) has only one region enabled then the approving regions policy will not be
effective as Turbot will only discovers resources for that one region.

This baseline needs to be considered carefully in conjunction with the `Azure > Subscription > Regions [Default]` policy set in
the [Azure Baseline](../azure_baseline/).

Turbot also supports Azure Lockdown / Boundary policies to limit access to regions which are not part of this baseline.

The advantage of setting up of each baseline in their own Smart Folder prevents conflicting with the policy settings
created by other baselines.

This baseline will not attach to a resource and will need to be done manually using the Turbot UI.

## Important

Running the baseline without an input variable file assumes that you have **ALL** Azure mods installed.
To limit the baseline, look at the example input variable file [demo.tfvars](demo.tfvars).

## Requirements

- Terraform v0.13 or greater installed
- Valid Turbot configuration credentials

For further information on configuring Turbot credentials can be found [here](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials).

## Applying baseline

The baseline is defined by a set of files which together define the configuration of the baseline.

### Deploying demo example

The demo baseline expects that the following mods are installed:

- azure-akz
- azure-apimanagement
- azure-application
- azure-appservice
- azure-compute
- azure-cosmosdb
- azure-databricks
- azure-datafactory
- azure-firewall
- azure-keyvault
- azure-loganalytics
- azure-loadbalancer
- azure-mysql-server
- azure-network
- azure-networkwatcher
- azure-postgresql
- azure-recoveryservice
- azure-searchmanagement
- azure-sql
- azure-storage
- azure-synapseanalytics

To run the baseline:

1. Navigate to the folder of the baseline
2. Initialise Terraform
3. Apply the baseline using the demo input variable file [demo.tfvars](demo.tfvars)

TODO: Omero clean up
From the workspace root folder using the the terminal, to apply the install the demo run the following commands:

```shell
cd ./baselines/getting_started/Azure/Azure_check_encryption
terraform init
terraform apply --var-file demo.tfvars
```

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
