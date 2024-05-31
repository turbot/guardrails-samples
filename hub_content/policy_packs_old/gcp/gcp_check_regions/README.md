# Baseline - GCP Check Regions

This baseline will allow you to discover resources in multiple regions and not approve usage of resource that are not in an allowable region.

This baseline is only effective when the account regions policies have multiple regions set.

The account approved regions `GCP > Account > Approved Regions [Default]` policy contains a list of GCP regions in which cloud resources are approved for use.

If the [GCP Baseline](../gcp_baseline/) has only one region enabled then the approving regions policy will not be
effective as Turbot will only discovers resources for that one region.

Turbot also supports GCP Lockdown / Boundary policies to limit access to regions which are not part of this baseline.

More Info

- [Approved Regions](https://turbot.com/v5/docs/guides/regions#approved-regions)


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
### Profile name as input

The baseline example set requires you to provide `turbot_profile` name as input. This is to help in case you are having more profiles than only `default`. In case it's default, specify name as default.

```shell
var.turbot_profile
  Enter profile matching your turbot cli credentials.
  Enter a value: <Enter name of the profile>
```

### Deploying demo example

The demo baseline expects that the following mods are installed:

  - gcp-bigtable-cluster
  - gcp-composer-environment
  - gcp-computeengine-disk
  - gcp-computeengine-instance
  - gcp-computeengine-node-group
  - gcp-computeengine-node-template
  - gcp-computeengine-region-disk
  - gcp-computeengine-region-health-check
  - gcp-dataflow-job 
  - gcp-dataproc-cluster
  - gcp-dataproc-job
  - gcp-dataproc-workflowtemplate
  - gcp-functions-function
  - gcp-kms-cryptokey
  - gcp-kubernetesengine-region-cluster 
  - gcp-kubernetesengine-region-node-pool
  - gcp-kubernetesengine-zone-cluster
  - gcp-kubernetesengine-zone-node-pool
  - gcp-network-address
  - gcp-network-forwarding-rule
  - gcp-network-router
  - gcp-network-region-backend-service
  - gcp-network-region-url-map
  - gcp-network-subnetwork
  - gcp-network-target-pool
  - gcp-network-target-vpn-gateway
  - gcp-network-vpn-tunnel
  - gcp-scheduler-job
  - gcp-spanner-instance
  - gcp-sql-backup
  - gcp-sql-database
  - gcp-sql-instance
  - gcp-storage-bucket

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

This baseline comes with an example input variable file called [demo.tfvars](demo.tfvars).

It will be used to define which parts of the baseline to apply and which to ignore.

The variables that can be overwritten by the input variable files i.e. [demo.tfvars](demo.tfvars) are defined in the [variables.tf](variables.tf) file.

Further details found in official [Terraform documentation](https://www.terraform.io/docs/language/values/variables.html).

### Apply baseline using input variable files

If seeking to apply the baseline using an input variable file such as [demo.tfvars](demo.tfvars).

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform apply --var-file=demo.tfvars
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
