---
policy_pack: Configure VPC Flow Logs
icon: TODO
category: TODO
mod_dependencies:
  - "@turbot/aws"
  - "@turbot/aws-vpc-core"
  - "@turbot/aws-vpc-security"
---

# Configure VPC Flow Logs

This policy pack provides a Terraform configuration for checking and enabling Flow Logs in a VPC.

## Installation

Installing this Policy Pack requires [admin credentials to a Turbot Guardrails workspace](https://turbot.com/guardrails/docs/guides/iam/access-keys) and [a way to run Terraform](https://turbot.com/guardrails/docs/7-minute-labs/terraform).

Clone the repo locally:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/aws/aws_vpc_flow_logs
```

## How to use

1. **Set the variable values**:

    ```sh
    cp default.tfvars.example default.tfvars
    vi default.tfvars
    ```

    ```hcl
    # Log Metric Filter name for control 4.1
    policy_pack_title = "Policy Pack for VPC Flow Logs"
    ```

1. **Create the Policy Pack in your workspace**:

    ```sh
    terraform init
    export TURBOT_PROFILE="my-workspace"
    terraform plan 
    terrafrom apply
    ```

1. **Attach the Policy Pack to your test account**: Within the Guardrails UI navigate to [{workspace-url}/apollo?exploreMode=account](#). Select the account from the list for testing. Click on the "Detail" subtab and look for the "Policy Packs" widget in the bottom right of the page. Select the "MANAGE" link and `+ Add` the `Configure VPC Flow Logs` Policy Pack from the dropdown menu, then select "Save".
    > [!IMPORTANT]
    > Do not add or remove more than one Policy Pack to a resource at a time. Adding Policy Packs is an asynchronous operation, after changing the Policy Pack configuration for a resource, wait at least 5 minutes before adding or removing other Policy Packs.

1. **Verify state (`OK`, `Alarm`, `Error`) of associated controls**: Within the Guardrails UI navigate to:

    ```
    {workspace-url}/apollo/controls/explore?filter=controlTypeId%3A%27tmod%3A%40turbot%2Faws-vpc-core%23%2Fcontrol%2Ftypes%2FvpcFlowloggingStack%27
    ```

    Replace `{workspace-url}` with the FQDN of your workspace (e.g. <https://company.cloud.turbot.com>). Use the "Resource" filter to select the test account where the Policy Pack is attached. Review all controls in `Alarm` state to understand why they are violating this policy pack objective.

1. For each control type, choose to [resolve the alarms](https://turbot.com/guardrails/docs/guides/quick-actions), [create resource exceptions](https://turbot.com/guardrails/docs/getting-started/activity-exceptions#manual-policy-exceptions) or to apply enforcement settings. The default setting for all controls are set to `Check: ...`. Each policy with an enforcement option will have a corresponding enforcement setting that is commented out. These can easily be found by searching across the `*.tf` files for `Enforce:`.

1. To apply enforcement automation: Open the Policy Pack Terraform source files in your code editor. Toggle individual controls between `Check` and `Enforce` by changing which line is commented out:

    ```hcl
    resource "turbot_policy_setting" "vpc_flow_logs" {
        resource = turbot_smart_folder.vpc_flow_logging.id
        type = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLogging"
        # value = "Check: Configured per `Flow Logging > *`"
        value = "Enforce: Configured per `Flow Logging > *`"
    }
    ```

    Then re-apply the Terraform stack:

    ```sh
    terraform plan 
    terrafrom apply
    ```

    > [!CAUTION]
    > Enforcement controls have the ability delete data, remove permissions and change configuration of your cloud resources. Guardrails automation is very fast and there is no undo; if you do not fully understand the scope of an enforcement or the potential impact to your applications then do not implement enforcement options.
