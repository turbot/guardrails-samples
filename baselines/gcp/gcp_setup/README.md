# GCP Setup Baseline

The GCP setup baseline terraform implements common configurations on your Turbot environment required to import a GCP project.

## Prerequisites

To run the GCP setup baseline, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace and GCP Project.
- `turbot`, `turbot-iam`, `gcp` and `gcp-pubsub` mods with their dependencies


## Running the Baseline

To run the GCP setup baseline:
- Go to the GCP setup baseline directory in the repository with `cd gcp_setup`
- Run `terraform plan -var-file=default.tfvars` and review the plan to be applied.
- Run `terraform apply -var-file=default.tfvars` to apply the plan.