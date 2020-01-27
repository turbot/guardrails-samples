# CHANGELOG FOR BASELINES

## v0.2.0 (November 25, 2019)

### FEATURES:

- New Baseline: azure_sub_import
- New Baseline: aws_permission
- New Baseline: gcp_permission

### ENHANCEMENTS:

- Supports Terraform version 12.
- Supports Turbot provider version 1.0.0-beta.8 and above
- Supports Turbot smart folders
- Updated mod list
- Updated terraform syntax and style conventions
- Updated README files

### TECHNICAL

- New implemented file structure.
- Inclusion of .tfvars files consisting values for each baseline defaults

### BREAKING CHANGES

- resource/turbot_policy_setting - rename policy_type to type
- resource/turbot_policy_value - rename policy_type to type
- renamed credentials environment variables TURBOT_ACCESS_KEY and TURBOT_SECRET_KEY
- resource/turbot_policy_setting - change default precedence to REQUIRED


## v0.1.0 (October 30, 2019)

Baselines v0.1.0 work on and follow the syntax of Terraform version 11.

Supports Turbot provider version 1.0.0-beta.5 or below.

### FEATURES:

- New Baseline: s3_baseline
- New Baseline: mod_install
- New Baseline: aws_setup
- New Baseline: aws_account_import
- New Baseline: aws_services
- New Baseline: azure_setup
- New Baseline: azure_provider_registration
- New Baseline: gcp_setup
- New Baseline: gcp_services