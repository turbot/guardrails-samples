# Runbook: Installing Mods

## Introduction

**Purpose**: This runbook guides administrators through the process of installing mods in the Guardrails environment.

**Prerequisites**: 
- `Turbot/Owner` permissions at Turbot resource level.
- Familiarity with Guardrails Console, Terraform, and Guardrails CLI.
- Large AWS environments (>100 accounts), accounts for AWS Event Handler churn. Refer to [Mod Installation in Large Environments](https://turbot.com/guardrails/docs/mods/guide/troubleshooting#mod-management-in-large-environments) instructions.

---

## Procedure

### Install Mod via Guardrails Console

#### Step 1: Access Guardrails Console

Log into the Guardrails console and click the gear icon for the Admin page.

<img src="images/mod_install/guardrails_console.png" alt="Guardrails Console" width="500"/>

#### Step 2: Navigate to Mods

Click on the `Mods` tab.

<img src="images/mod_install/guardrails_mod_tab.png" alt="Guardrails Mod Tab" width="400"/>

#### Step 3: Install Mod

Click `Install Mod`. This launches the Install Mod dialog

<img src="images/mod_install/install_mod_action.png" alt="Mod Install" width="400"/>

Browse or search for the mod, select it, and click `Install Mod`.

<img src="images/mod_install/install_mod_dialog.png" alt="Mod Install Dialog" width="400"/>

#### Step 4: Verify Installation

 The mod will appear in the list and the status icon changes to a green check when installation is complete.

 <img src="images/mod_install/install_mod_success.png" alt="Mod Install Success" width="400"/>

## Install Mod via CLI

Note: Ensure that the Guardrails CLI is installed and properly configured.

#### Step 1: Install Mod

Run the following command to install the desired mod (e.g., `aws-s3`):

```bash
turbot install @turbot/aws-s3
```
Syntax will be similar across other mod types, such as @turbot/aws-sns, @turbot/gcp, etc.

#### Step 2: Verify Installation

The mod will appear on the Guardrails console installed mods list.

## Install Mod via Terraform

Use the `turbot_mod` resource to install, uninstall, and update mods across an environment.

#### Example Terraform Code

**To use the latest version:**

```hcl
resource "turbot_mod" "aws-s3" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "aws-s3"
}
```

**To install a pinned mod version**

Note: Ensure Mod Auto-update is disabled when using pinned versions.

```hcl
resource "turbot_mod" "aws-s3" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "aws-s3"
  version = "5.5.2"
}
```

**To install mod with dependencies**

```hcl
resource "turbot_mod" "aws-s3" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-kms]
  org        = "turbot"
  mod        = "aws-s3"
}
```

**Notes for Terraform Installation:**

- Run with `-parallelism=1` to minimize issues from multiple mods performing Discovery simultaneously.
- Terraform does not handle mod dependencies. Specify dependencies in Terraform files to avoid errors.
- High DB load from Discovery and CMDB controls can cause API timeouts. This load is proportional to the number of accounts/subs/projects and resources discovered.

## Troubleshooting

**Common Issues**:
1. **Mod installed is in error state**:
    - Solution: Click the mod name to verify its details, including dependent controls, upgrade history, and dependencies.
2. **Terraform installation failed**:
    - Solution: Review the resource type, dependencies and environment config.

## Conclusion

**Summary**: You have successfully installed a mod.

**Next Steps**: Monitor the mod for any issues post-installation and document any anomalies.