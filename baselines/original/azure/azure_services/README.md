# Azure Services Baseline

Turbot Azure Services baseline provides a Terraform configuration to enable or disable Azure services in Turbot.

**NOTE:** `service_status` must match values found in the `policy_map` map.

**NOTE:** It is advised not to modify the `policy_map` map.

## Prerequisites

- Setup Turbot [credentials](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials)
- Installed [Terraform](https://www.terraform.io/downloads.html)
- Installed [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)

## Running the Baseline

Scripts can be run in the folder that contains the script.

### Configure the script

Update default.tfvars or create a new Terraform configuration file.

Variables that are exposed by this script are:

- target_resource
- smart_folder_title
- folder_parent (Optional)
- service_status (Optional)
- policy_map (Optional)

Open the file `variables.tf` for further details.

### Initialize Terraform

If not previously run then initialize Terraform to get all necessary providers.

Command: `terraform init`

### Apply using default configuration

If seeking to apply the configuration using the configuration file `defaults.tfvars`.

Command: `terraform apply -var-file=default.tfvars`

### Apply using custom configuration

If seeking to apply the configuration using a custom configuration file `<custom_filename>.tfvars`.

Command: `terraform apply -var-file=<custom_filename>.tfvars`

### Destroy using default configuration

If seeking to apply the configuration using the configuration file `defaults.tfvars`.

Command: `terraform destroy -var-file=default.tfvars`

### Destroy using custom configuration

If seeking to apply the configuration using a custom configuration file `<custom_filename>.tfvars`.

Command: `terraform destroy -var-file=<custom_filename>.tfvars`
