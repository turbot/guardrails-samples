# Turbot Events

Pause and resume Guardrails event processing in a Turbot Guardrails Enterprise (TE) hosting account, for one or more TE versions. The script works for both worker runtimes, and it finds the runtime of each version by itself:

| Runtime | `disable` (pause)                                                              | `enable` (resume)               |
| ------- | ------------------------------------------------------------------------------ | ------------------------------- |
| Lambda  | Disables the SQS triggers (event source mappings) of the TE's Lambda functions. | Enables them.                   |
| Fargate | Scales the ECS worker services to 0.                                            | Restores the saved scale.       |

While event processing is paused, incoming events queue safely in SQS; nothing is lost. Resuming drains the queues and returns to normal processing. This is typically used to quiesce a workspace around a maintenance window or database migration.

## Prerequisites

To run the script, you must have:

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) (v1 or v2)
- [jq](https://jqlang.github.io/jq/download/)

AWS credentials for the Guardrails hosting account with these permissions:

Lambda workers:

- `lambda:ListFunctions`
- `lambda:ListEventSourceMappings`
- `lambda:UpdateEventSourceMapping` (only needed for `enable` / `disable`; `status` is read-only)

Fargate workers (the script always reads ECS, unless you use `--lambda-only`):

- `ecs:ListServices`
- `ecs:DescribeServices`
- `ecs:DescribeTaskDefinition`
- `ecs:ListTagsForResource`
- `application-autoscaling:DescribeScalableTargets`
- `ecs:UpdateService`, `ecs:TagResource`, `ecs:UntagResource`, `application-autoscaling:RegisterScalableTarget` (only needed for `enable` / `disable`)

The script works on bash 3.2 (macOS default) and newer.

## Synopsis

```shell
./turbot-events.sh <te-version[,te-version...]> <enable|disable|status> \
    [--profile <profile>] [--region <region>] [--prefix <name>] \
    [--cluster <name>] [--lambda-only] [--dry-run] [--jobs <n>]
```

The TE version is mapped to a name prefix: `5.55.0` matches all Lambda functions named `turbot_5_55_0_*`. A stable version never matches its release candidates (`5.61.0` does not match `turbot_5_61_0_rc_*`). Give several versions as a comma-separated list.

| Action    | Description                                                                        |
| --------- | ---------------------------------------------------------------------------------- |
| `status`  | Show the runtime of each version and the state of its triggers and worker services. |
| `disable` | Pause event processing.                                                            |
| `enable`  | Resume event processing.                                                           |

| Option             | Description                                                                                                                     |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------- |
| `--profile`        | AWS CLI profile.                                                                                                                |
| `--region`         | AWS region.                                                                                                                     |
| `--prefix <name>`  | Name prefix of the install (default `turbot`). Letters, digits, `-` and `_` only.                                               |
| `--cluster <name>` | ECS cluster that runs the Fargate workers (default: the prefix).                                                                |
| `--lambda-only`    | Do not look at ECS. Use only on a TE without Fargate workers, or with credentials that have no ECS permissions (see below).     |
| `--dry-run`        | `enable` / `disable` only: show what would change, and change nothing.                                                          |
| `--jobs <n>`       | Parallel AWS calls for Lambda (default 8, maximum 16).                                                                          |

## Examples

Check the current state (read-only):

```shell
./turbot-events.sh 5.55.0 status --profile my-hosting-profile
```

Pause event processing (see what would change first):

```shell
./turbot-events.sh 5.55.0 disable --profile my-hosting-profile --dry-run
./turbot-events.sh 5.55.0 disable --profile my-hosting-profile
```

Resume event processing:

```shell
./turbot-events.sh 5.55.0 enable --profile my-hosting-profile --region us-east-2
```

Several versions, and an install with a different name prefix:

```shell
./turbot-events.sh 5.60.12,5.60.14,5.60.16 enable --profile my-hosting-profile
./turbot-events.sh 5.60.12 status --profile my-hosting-profile --prefix myturbot
```

## Behavior notes

- The script reads everything first. If a read fails, it stops before any change. An ECS read error (other than "cluster not found") also stops the run, so a pause never skips Fargate workers without a message.
- It is idempotent: anything already in the target state is skipped, as are Lambda mappings in a transient state (`Enabling` / `Disabling` / `Updating`). Re-run later to pick those up.
- If a version matches no Lambda functions and no Fargate worker services (usually a typo), the script stops before it changes anything.
- Trigger and task changes are asynchronous on the AWS side. Run `status` afterward to confirm the final state.
- Exit codes: `0` success, `1` usage error, no matching functions or services, or a failed read, `2` one or more updates failed or could not be planned.

### Fargate workers

A TE runs its workers on Fargate when the ECS services `<prefix>_<version>_worker_*_fg` exist. The event intake service (`<prefix>_<version>_events_fg`) is never changed.

- A Fargate TE keeps its Lambda functions. The triggers for the queues that Fargate serves stay `Disabled`. The script reads these queues from `WORKER_QUEUE_TYPES` in the worker task definitions. `enable` never turns those triggers on, because Lambda and Fargate would then read the same queues. The other triggers (retry, osquery, the DLQs) are paused and resumed as for Lambda.
- `disable` runs these steps for each service, and stops at the first failure:
  1. Save the desired count and the autoscaling bounds in the service tags `turbot-events-pause:*`, and read them back.
  2. Set the autoscaling bounds to 0-0, so autoscaling does not start tasks again.
  3. Set the desired count to 0.
- `enable` runs these steps:
  1. Restore the autoscaling bounds.
  2. Set the desired count, only if it is 0.
  3. Remove the saved tags.
- The saved values are in AWS, not on your machine. You can run `disable` from one machine and `enable` from another. Saved values are never overwritten, so a second `disable` cannot replace them with zeros.
- `enable` on a service that has desired count 0 and no saved values is an error (exit `2`). The script does not guess a scale. Set the desired count by hand.
- Tasks stop one by one after `disable`. The pause is complete when `status` shows `RUNNING 0` for every worker service. A message that is in flight returns to the queue when its visibility timeout ends.
- Do not deploy a TE update while the workers are paused. A TE update can reset the desired count and start the workers again.
- `--lambda-only` skips ECS. On a Fargate TE it does not pause the workers, and `enable` would turn on the Lambda triggers that Fargate serves.
