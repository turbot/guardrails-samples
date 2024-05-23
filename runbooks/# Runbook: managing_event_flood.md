# Runbook: Managing Event Floods

## Introduction

**Purpose**: This runbook guides administrators through the process of identifying, analyzing, and resolving event floods in the Guardrails environment.

**Prerequisites**:
- Access to the Guardrails master account.
- Familiarity with Guardrails Console, CloudWatch, and Guardrails policies.

---

## Procedure

### Step 1: Identify Event Flood

**Check Event Queue Backlog**:
- Go to the "Events Queue Backlog" graph in the TE CloudWatch dashboard to see if an event flood is underway.

  <img src="images/event_flood/event_flood_events_queue_backlog.png" alt="Event Flood Events Queue Backlog" width="500"/>

**Initial Symptoms**:
- **Control Run in the Turbot Console**: Manually run control processes may remain in `Running`, `Initializing` or `Handling` states.

  <img src="images/event_flood/event_flood_stuck_control.png" alt="Event Flood Stuck Control" width="300"/>

**CloudWatch Alarms**:
- Check alarms configured with `turbot_5_{minor}_{patch}_events_queue_messages_visible_alarm` in your cloudwatch.

  <img src="images/event_flood/event_flood_cloudwatch_alarms.png" alt="Event Flood Cloudwatch Alarm" width="300"/>

### Step 2: Analyze Common Causes

- **Automation Issues**:
  - Rogue automation scripts or high workloads causing excessive events.

- **Policy Misconfigurations**:
  - Misconfigured policies leading to resource conflicts and continuous creation/deletion cycles.

- **System Misconfigurations**:
  - Undersized databases, low worker concurrency, or insufficient ECS hosts causing processing issues.

### Step 3: Investigate Event Flood

1. **TE CloudWatch Dashboard**:
   - Use the top TE graphs to identify the flood state.

   <img src="images/event_flood/event_flood_cloudwatch_alarms_dashboard.png" alt="Event Flood Cloudwatch Alarm" width="500"/>

2. **TED CloudWatch Dashboard**:
   - Check the TED DB and Elasticache Redis health graphs for any performance issues.

   <img src="images/event_flood/event_flood_rds_dashboards.png" alt="Event Flood Cloudwatch Alarm" width="500"/>

3. **Identify and Analyze Noisy Tenant**:

- Use the "View All Messages By Workspace" widget in the TE Dashboard to find the tenant with the most messages and compare the message counts of the top tenants to identify a potential event flood.

   <img src="images/event_flood/event_flood_tenant_dashboard.png" alt="TE Dashboard View All Messages By Workspace " width="500"/>

- Correlate high event activity with the number of accounts/regions in the workspace and compare with the busiest workspaces.

### Step 4: Use CloudWatch Log Insights

Use CloudWatch Insights to find external messages by AWS Account ID and events, identifying high activity. Correlate this with the number of accounts/regions and compare with the busiest workspaces.

1. **Navigate to CloudWatch Log Insights**:
   - Select the appropriate TE worker log group and set the duration for the query.

      <img src="images/event_flood/event_flood_log_insights.png" alt="Cloudwatch Log Insights " width="500"/>

2. **Run Queries**:
   - **Top 10 External Messages by Tenant**:
     ```sql
     fields @timestamp, @message
     | filter message='received SQS message' and ispresent(data.msgObj.payload.account)
     | filter data.msgObj.type='event.turbot.com:External'
     | stats count() as Count by data.msgObj.meta.tenantId as Tenant | sort Count desc | limit 10
     ```

      <img src="images/event_flood/event_flood_log_insights_query.png" alt="Cloudwatch Log Insights " width="500"/>

   - **Top 10 External Messages by Accounts**:
     ```sql
     fields @timestamp, @message
     | filter message='received SQS message' and ispresent(data.msgObj.payload.account) and data.msgObj.meta.tenantId='demo-turbot.cloud.turbot.com'
     | filter data.msgObj.type='event.turbot.com:External'
     | stats count() as Count by data.msgObj.meta.tenantId as Tenant, data.msgObj.payload.account as AccountId
     | sort Count desc | limit 10
     ```

   - **Top 10 External Messages by Source**:
     ```sql
     fields @timestamp, @message
     | filter message='received SQS message' and ispresent(data.msgObj.payload.account) and ispresent(data.msgObj.payload.source) and data.msgObj.meta.tenantId='demo-turbot.cloud.turbot.com'
     | filter data.msgObj.type='event.turbot.com:External'
     | stats count() as Count by data.msgObj.meta.tenantId as Tenant, data.msgObj.payload.source as Source
     | sort Count desc | limit 10
     ```

   - **Top 10 External Messages by Events**:
     ```sql
     fields @timestamp, @message
     | filter message='received SQS message' and ispresent(data.msgObj.payload.account) and ispresent(data.msgObj.payload.source) and data.msgObj.meta.tenantId='demo-turbot.cloud.turbot.com' and data.msgObj.payload.account='123456789012'
     | filter data.msgObj.type='event.turbot.com:External'
     | stats count() as Count by data.msgObj.meta.tenantId as Tenant, data.msgObj.payload.account as AccountId, data.msgObj.payload.source as Source, data.msgObj.meta.eventRaw as EventName
     | sort Count desc | limit 15
     ```

   - **Top 15 External Messages by Source Event**:
     ```sql
     fields @timestamp, @message
     | filter message='received SQS message' and ispresent(data.msgObj.payload.account) and ispresent(data.msgObj.payload.source) and data.msgObj.meta.tenantId='demo-turbot.cloud.turbot.com' and data.msgObj.payload.source='aws.tagging'
     | filter data.msgObj.type='event.turbot.com:External'
     | stats count() as Count by data.msgObj.meta.tenantId as Tenant,  data.msgObj.payload.account as AccountId, data.msgObj.payload.source as Source
     | sort Count desc | limit 15
     ```

### Step 5: Fix Event Flood

1. **Move Noisy Workspace**:
   - Move the noisy workspace to a separate TE version to mitigate performance issues for other workspaces.

   <!-- ![Move Noisy Workspace](screenshot_move_noisy_workspace.png) -->

2. **Update Event Poller Policy**:
   - Exclude specific events using the [AWS > Turbot > Event Poller > Excluded Events](https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/eventPollerExcludedEvents) policy.

   <!-- ![Update Event Poller Policy](screenshot_update_event_poller_policy.png) -->

3. **Send Turbot Alert**:
   - Notify the customer and request off-boarding the account or turning off relevant policies.

   <!-- ![Send Turbot Alert](screenshot_send_turbot_alert.png) -->

---

## Validation

- Ensure the event queue backlog returns to normal levels.
- Verify that no new event floods occur and system performance is stable.

<!-- ![Validation](screenshot_validation.png) -->

---

## Troubleshooting

**Common Issues**:
1. **Persistent Event Flood**:
   - Solution: Check for additional policy misconfigurations or automation conflicts.

2. **High DB Load**:
   - Solution: Optimize database performance and increase worker concurrency.

<!-- ![Troubleshooting](screenshot_troubleshooting.png) -->

---

## Conclusion

**Summary**: Successfully identified, analyzed, and resolved event floods in the Turbot environment.

**Next Steps**: Monitor the system for any new issues and update runbooks as necessary.

<!-- ![Conclusion](screenshot_conclusion.png) -->
