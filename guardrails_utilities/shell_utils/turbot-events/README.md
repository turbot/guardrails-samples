# Turbot Events

Pause and resume Guardrails event processing in a Turbot Guardrails Enterprise (TE) hosting account by enabling or disabling the SQS triggers (Lambda event source mappings) on all worker Lambda functions for a given TE version.

While the triggers are disabled, incoming events queue safely in SQS; nothing is lost. Re-enabling the triggers drains the queues and resumes normal processing. This is typically used to quiesce a workspace around a maintenance window or database migration.

## Prerequisites

To run the script, you must have:

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) (v1 or v2)
- [jq](https://jqlang.github.io/jq/download/)

AWS credentials for the Guardrails hosting account with these permissions:

- `lambda:ListFunctions`
- `lambda:ListEventSourceMappings`
- `lambda:UpdateEventSourceMapping` (only needed for `enable` / `disable`; `status` is read-only)

## Synopsis

```shell
./turbot-events.sh <te-version> <enable|disable|status> [--profile <profile>] [--region <region>]
```

The TE version is mapped to a Lambda function name prefix: `5.55.0` matches all functions named `turbot_5_55_0*`.

| Action    | Description                                                        |
| --------- | ------------------------------------------------------------------ |
| `status`  | Show the current trigger state for all matching Lambda functions.  |
| `disable` | Disable all SQS triggers (pause event processing).                 |
| `enable`  | Enable all SQS triggers (resume event processing).                 |

## Examples

Check the current state (read-only):

```shell
./turbot-events.sh 5.55.0 status --profile my-hosting-profile
```

Pause event processing:

```shell
./turbot-events.sh 5.55.0 disable --profile my-hosting-profile
```

Resume event processing:

```shell
./turbot-events.sh 5.55.0 enable --profile my-hosting-profile --region us-east-2
```

## Behavior notes

- The script is idempotent: mappings already in the target state are skipped, as are mappings in a transient state (`Enabling` / `Disabling` / `Updating`). Re-run later to pick those up.
- Trigger state changes are asynchronous on the AWS side. Run `status` afterward to confirm the final state.
- Exit codes: `0` success, `1` usage error or no matching functions, `2` one or more mapping updates failed.
