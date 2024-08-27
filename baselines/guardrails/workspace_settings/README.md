# Workspace Settings Installation

This script configures essential workspace settings within Turbot Guardrails, covering policies related to quick actions, retention, resource limits, Terraform versioning, and mod updates. These settings ensure that your Turbot environment is managed efficiently and adheres to your organization's best practices.

## Documentation

- **[Review Workspace Settings Documentation →](https://hub.guardrails.turbot.com/mods/turbot/policies)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)

### Credentials

To apply workspace settings using Terraform:

- Ensure you have `Turbot/Owner` permissions in Guardrails.
- [Create access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key) in Guardrails.

Then set your credentials:

```sh
export TURBOT_WORKSPACE=myworkspace.acme.com
export TURBOT_ACCESS_KEY=acce6ac5-access-key-here
export TURBOT_SECRET_KEY=a8af61ec-secret-key-here
```

Please see [Turbot Guardrails Provider authentication](https://registry.terraform.io/providers/turbot/turbot/latest/docs#authentication) for additional authentication methods.

## Usage

### Initialize Terraform

1. Navigate to the `workspace_settings` folder.
2. Run the command:

```sh
terraform init
```

### Install

After initializing Terraform, you can apply the configuration to set up the workspace settings:

```sh
terraform apply
```

### Destroy

You can remove the workspace settings configuration:

```sh
terraform destroy
```

## Overview of Workspace Settings

This setup configures the following key policies within your Turbot workspace:

### 1. Quick Actions Enabled

- **Policy**: `turbot_quick_actions_enabled`
- **Description**: Enables or disables quick actions in the Turbot console.
- **Setting**: `"Enabled"`

### 2. Retention Policy

- **Policy**: `turbot_retention`
- **Description**: Enforces smart retention policies for resource data within Turbot.
- **Setting**: `"Enforce: Enable purging via Smart Retention"`

### 3. Maximum Retention

- **Policy**: `turbot_maximum_retention`
- **Description**: Sets the maximum retention period for resource data in days.
- **Setting**: `90 days`

### 4. Resource Purge Limit

- **Policy**: `turbot_resource_purge_limit`
- **Description**: Sets the limit on the number of resources that can be purged at once.
- **Setting**: `500 resources`

### 5. Stack Terraform Version

- **Policy**: `turbot_stack_terraform_version`
- **Description**: Specifies the Terraform version to be used for stack deployments.
- **Setting**: `"0.15.*"`

### 6. Mod Auto-Update

- **Policy**: `turbot_mod_auto_update`
- **Description**: Controls the automatic update of mods within the defined change window.
- **Setting**: `"Enforce within Mod Change Window"`

### 7. Mod Change Window Schedule

- **Policy**: `turbot_mod_change_window_schedule`
- **Description**: Defines the schedule for when mod updates can occur.
- **Setting**: 
    ```yaml
    - name: Weekly
      description: 'Weekly, Saturday 09:00 AM to Saturday 09:00 PM UTC'
      cron: '0 9 * * SAT'
      duration: 12 hours
    ```
