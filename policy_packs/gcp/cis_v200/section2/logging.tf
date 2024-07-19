# GCP > Turbot > Event Handlers > Logging
resource "turbot_policy_setting" "gcp_turbot_event_handler_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlersLogging"
  note     = "GCP CIS v2.0.0 - Control: 2.1"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# GCP > Turbot > Event Handlers > Logging > Unique Writer Identity
resource "turbot_policy_setting" "gcp_turbot_event_handler_logging_unique_writer_identity" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlersLoggingUniqueWriterIdentity"
  note     = "GCP CIS v2.0.0 - Control: 2.1"
  value    = "Enforce: Default Service Account"
  # value    = "Enforce: Unique Identity"
}

# GCP > Turbot > Event Handlers > Logging > Sink > Name Prefix
resource "turbot_policy_setting" "gcp_turbot_event_handler_logging_sink_name_prefix" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlerLoggingSinkNamePrefix"
  note     = "GCP CIS v2.0.0 - Control: 2.1"
  value    = "myLoggingSinkNamePrefix"
  # value    = "_turbot"
}

# GCP > Turbot > Event Handlers > Logging > Sink > Destination Topic
resource "turbot_policy_setting" "gcp_turbot_event_handler_logging_sink_destination_topic" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlerLoggingSinkDestinationTopic"
  note     = "GCP CIS v2.0.0 - Control: 2.1"
  value    = "pubsub.googleapis.com/projects/myProjectId/topics/myTopicId"
}

# GCP > Turbot > Event Handlers > Pub/Sub
resource "turbot_policy_setting" "gcp_turbot_event_handler_pubsub" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlersPubSub"
  note     = "GCP CIS v2.0.0 - Control: 2.2"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# GCP > Turbot > Event Handlers > Pub/Sub > Topic > Name Prefix
resource "turbot_policy_setting" "gcp_turbot_event_handler_pubsub_topic_name_prefix" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlerPubSubTopicNamePrefix"
  note     = "GCP CIS v2.0.0 - Control: 2.2"
  value    = "myPubSubTopicNamePrefix"
  # value    = "_turbot"
}

# GCP > Turbot > Event Handlers > Pub/Sub > Subscription > Name Prefix
resource "turbot_policy_setting" "gcp_turbot_event_handler_pubsub_subscription_name_prefix" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlerPubSubSubscriptionNamePrefix"
  note     = "GCP CIS v2.0.0 - Control: 2.2"
  value    = "myPubSubSubscriptionNamePrefix"
  # value    = "_turbot"
}

# GCP > Project > Stack
resource "turbot_policy_setting" "gcp_project_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/projectStack"
  note     = "GCP CIS v2.0.0 - Controls: 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 2.10 and 2.11"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# GCP > Project > Stack > Source
resource "turbot_policy_setting" "gcp_project_stack_source" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp#/policy/types/projectStackSource"
  note           = "GCP CIS v2.0.0 - Controls: 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 2.10 and 2.11"
  template_input = <<-EOT
    {
      project  {
        metadata
      }
    }
    EOT
  template       = <<-EOT
    |
    resource "google_monitoring_notification_channel" "monitoring_notification_channel_2" {
      display_name = "gcp_cis_v200_s2_notification_channel"
      type         = "email"
      labels = {
        "email_address" = "test@example.com"
      }
    }

    resource "google_logging_metric" "logging_metric_2_4" {
      name   = "gcp_cis_v200_s2_4_metric"
      filter = "(protoPayload.serviceName=\"cloudresourcemanager.googleapis.com\") AND (ProjectOwnership OR projectOwnerInvitee) OR (protoPayload.serviceData.policyDelta.bindingDeltas.action=\"REMOVE\" AND protoPayload.serviceData.policyDelta.bindingDeltas.role=\"roles/owner\") OR (protoPayload.serviceData.policyDelta.bindingDeltas.action=\"ADD\" AND protoPayload.serviceData.policyDelta.bindingDeltas.role=\"roles/owner\")"

      metric_descriptor {
        metric_kind = "DELTA"
        value_type  = "INT64"
        unit        = "1"
      }
    }

    resource "google_monitoring_alert_policy" "monitoring_alert_policy_2_4" {
      display_name = "gcp_cis_v200_s2_4_alert_policy"
      combiner     = "OR"

      conditions {
        display_name = "gcp_cis_v200_s2_4_alert_policy_condition"
        condition_threshold {
          filter          = "metric.type=\"logging.googleapis.com/user/\$\{google_logging_metric.logging_metric_2_4.name\}\" AND resource.type=\"global\""
          duration        = "0s"
          comparison      = "COMPARISON_GT"
          threshold_value = 0

          aggregations {
            alignment_period     = "60s"
            per_series_aligner   = "ALIGN_RATE"
            cross_series_reducer = "REDUCE_NONE"
            group_by_fields      = []
          }
        }
      }

      notification_channels = [
        google_monitoring_notification_channel.monitoring_notification_channel_2.id,
      ]

      documentation {
        content   = "Alert for owner role changes in the project"
        mime_type = "text/markdown"
      }

      user_labels = {
        severity = "critical"
      }

      enabled = true
    }

    resource "google_logging_metric" "logging_metric_2_5" {
      name   = "gcp_cis_v200_s2_5_metric"
      filter = "protoPayload.methodName=\"SetIamPolicy\" AND protoPayload.serviceData.policyDelta.auditConfigDeltas:*"

      metric_descriptor {
        metric_kind = "DELTA"
        value_type  = "INT64"
        unit        = "1"
      }
    }

    resource "google_monitoring_alert_policy" "monitoring_alert_policy_2_5" {
      display_name = "gcp_cis_v200_s2_5_alert_policy"
      combiner     = "OR"

      conditions {
        display_name = "gcp_cis_v200_s2_5_alert_policy_condition"
        condition_threshold {
          filter          = "metric.type=\"logging.googleapis.com/user/\$\{google_logging_metric.logging_metric_2_5.name\}\" AND resource.type=\"global\""
          duration        = "0s"
          comparison      = "COMPARISON_GT"
          threshold_value = 0

          aggregations {
            alignment_period     = "60s"
            per_series_aligner   = "ALIGN_RATE"
            cross_series_reducer = "REDUCE_NONE"
            group_by_fields      = []
          }
        }
      }

      notification_channels = [
        google_monitoring_notification_channel.monitoring_notification_channel_2.id,
      ]

      documentation {
        content  = "Alert for IAM Policy changes"
        mime_type = "text/markdown"
      }

      user_labels = {
        "severity" = "critical"
      }

      enabled = true
    }

    resource "google_logging_metric" "logging_metric_2_6" {
      name   = "gcp_cis_v200_s2_6_metric"
      filter = "resource.type=\"iam_role\" AND (protoPayload.methodName=\"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.DeleteRole\" OR protoPayload.methodName=\"google.iam.admin.v1.UpdateRole\")"

      metric_descriptor {
        metric_kind = "DELTA"
        value_type  = "INT64"
        unit        = "1"
      }
    }

    resource "google_monitoring_alert_policy" "monitoring_alert_policy_2_6" {
      display_name = "gcp_cis_v200_s2_6_alert_policy"
      combiner     = "OR"
    
      conditions {
        display_name = "gcp_cis_v200_s2_6_alert_policy_condition"
        condition_threshold {
          filter          = "metric.type=\"logging.googleapis.com/user/\$\{google_logging_metric.logging_metric_2_6.name\}\" AND resource.type=\"global\""
          duration        = "0s"
          comparison      = "COMPARISON_GT"
          threshold_value = 0
    
          aggregations {
            alignment_period     = "60s"
            per_series_aligner   = "ALIGN_RATE"
            cross_series_reducer = "REDUCE_COUNT"
            group_by_fields      = []
          }
        }
      }
    
      notification_channels = [
        google_monitoring_notification_channel.monitoring_notification_channel_2.id,
      ]
    
      documentation {
        content   = "Alert for IAM role changes in the project"
        mime_type = "text/markdown"
      }
    
      user_labels = {
        severity = "critical"
      }
    
      enabled = true
    }

    resource "google_logging_metric" "logging_metric_2_7" {
      name   = "gcp_cis_v200_s2_7_metric"
      filter = "resource.type=\"gce_firewall_rule\" AND (protoPayload.methodName:\"compute.firewalls.patch\" OR protoPayload.methodName:\"compute.firewalls.insert\" OR protoPayload.methodName:\"compute.firewalls.delete\")"
    
      metric_descriptor {
        metric_kind = "DELTA"
        value_type  = "INT64"
        unit        = "1"
      }
    }
    
    resource "google_monitoring_alert_policy" "monitoring_alert_policy_2_7" {
      display_name = "gcp_cis_v200_s2_7_alert_policy"
      combiner     = "OR"
    
      conditions {
        display_name = "gcp_cis_v200_s2_7_alert_policy_condition"
        condition_threshold {
          filter          = "metric.type=\"logging.googleapis.com/user/\$\{google_logging_metric.logging_metric_2_7.name\}\" AND resource.type=\"global\""
          duration        = "0s"
          comparison      = "COMPARISON_GT"
          threshold_value = 0
    
          aggregations {
            alignment_period     = "60s"
            per_series_aligner   = "ALIGN_RATE"
            cross_series_reducer = "REDUCE_COUNT"
            group_by_fields      = []
          }
        }
      }
    
      notification_channels = [
        google_monitoring_notification_channel.monitoring_notification_channel_2.id,
      ]
    
      documentation {
        content   = "Alert for changes to GCE firewall rules in the project"
        mime_type = "text/markdown"
      }
    
      user_labels = {
        severity = "critical"
      }
    
      enabled = true
    }

    resource "google_logging_metric" "logging_metric_2_8" {
      name   = "gcp_cis_v200_s2_8_metric"
      filter = "resource.type=\"gce_route\" AND (protoPayload.methodName:\"compute.routes.delete\" OR protoPayload.methodName:\"compute.routes.insert\")"
    
      metric_descriptor {
        metric_kind = "DELTA"
        value_type  = "INT64"
        unit        = "1"
      }
    }
    
    resource "google_monitoring_alert_policy" "monitoring_alert_policy_2_8" {
      display_name = "gcp_cis_v200_s2_8_alert_policy"
      combiner     = "OR"
    
      conditions {
        display_name = "gcp_cis_v200_s2_8_alert_policy_condition"
        condition_threshold {
          filter          = "metric.type=\"logging.googleapis.com/user/\$\{google_logging_metric.logging_metric_2_8.name\}\" AND resource.type=\"global\""
          duration        = "0s"
          comparison      = "COMPARISON_GT"
          threshold_value = 0
    
          aggregations {
            alignment_period     = "60s"
            per_series_aligner   = "ALIGN_RATE"
            cross_series_reducer = "REDUCE_COUNT"
            group_by_fields      = []
          }
        }
      }
    
      notification_channels = [
        google_monitoring_notification_channel.monitoring_notification_channel_2.id,
      ]
    
      documentation {
        content   = "Alert for changes to GCE routes in the project"
        mime_type = "text/markdown"
      }
    
      user_labels = {
        severity = "critical"
      }
    
      enabled = true
    }

    resource "google_logging_metric" "logging_metric_2_9" {
      name   = "gcp_cis_v200_s2_9_metric"
      filter = "resource.type=\"gce_network\" AND (protoPayload.methodName:\"compute.networks.insert\" OR protoPayload.methodName:\"compute.networks.patch\" OR protoPayload.methodName:\"compute.networks.delete\" OR protoPayload.methodName:\"compute.networks.removePeering\" OR protoPayload.methodName:\"compute.networks.addPeering\")"
    
      metric_descriptor {
        metric_kind = "DELTA"
        value_type  = "INT64"
        unit        = "1"
      }
    }
    
    resource "google_monitoring_alert_policy" "monitoring_alert_policy_2_9" {
      display_name = "gcp_cis_v200_s2_9_alert_policy"
      combiner     = "OR"
    
      conditions {
        display_name = "gcp_cis_v200_s2_9_alert_policy_condition"
        condition_threshold {
          filter          = "metric.type=\"logging.googleapis.com/user/\$\{google_logging_metric.logging_metric_2_9.name\}\" AND resource.type=\"global\""
          duration        = "0s"
          comparison      = "COMPARISON_GT"
          threshold_value = 0
    
          aggregations {
            alignment_period     = "60s"
            per_series_aligner   = "ALIGN_RATE"
            cross_series_reducer = "REDUCE_COUNT"
            group_by_fields      = []
          }
        }
      }
    
      notification_channels = [
        google_monitoring_notification_channel.monitoring_notification_channel_2.id,
      ]
    
      documentation {
        content   = "Alert for changes to GCE networks in the project"
        mime_type = "text/markdown"
      }
    
      user_labels = {
        severity = "critical"
      }
    
      enabled = true
    }

    resource "google_logging_metric" "logging_metric_2_10" {
      name   = "gcp_cis_v200_s2_10_metric"
      filter = "resource.type=\"gcs_bucket\" AND protoPayload.methodName=\"storage.setIamPermissions\""
    
      metric_descriptor {
        metric_kind = "DELTA"
        value_type  = "INT64"
        unit        = "1"
      }
    }
    
    resource "google_monitoring_alert_policy" "monitoring_alert_policy_2_10" {
      display_name = "gcp_cis_v200_s2_10_alert_policy"
      combiner     = "OR"
    
      conditions {
        display_name = "gcp_cis_v200_s2_10_alert_policy_condition"
        condition_threshold {
          filter          = "metric.type=\"logging.googleapis.com/user/\$\{google_logging_metric.logging_metric_2_10.name\}\" AND resource.type=\"gcs_bucket\""
          duration        = "0s"
          comparison      = "COMPARISON_GT"
          threshold_value = 0
    
          aggregations {
            alignment_period     = "60s"
            per_series_aligner   = "ALIGN_RATE"
            cross_series_reducer = "REDUCE_COUNT"
            group_by_fields      = []
          }
        }
      }
    
      notification_channels = [
        google_monitoring_notification_channel.monitoring_notification_channel_2.id,
      ]
    
      documentation {
        content   = "Alert for changes to GCS bucket IAM permissions in the project"
        mime_type = "text/markdown"
      }
    
      user_labels = {
        severity = "critical"
      }
    
      enabled = true
    }

    resource "google_logging_metric" "logging_metric_2_11" {
      name   = "gcp_cis_v200_s2_11_metric"
      filter = "protoPayload.methodName=\"cloudsql.instances.update\""
    
      metric_descriptor {
        metric_kind = "DELTA"
        value_type  = "INT64"
        unit        = "1"
      }
    }
    
    resource "google_monitoring_alert_policy" "monitoring_alert_policy_2_11" {
      display_name = "gcp_cis_v200_s2_11_alert_policy"
      combiner     = "OR"
    
      conditions {
        display_name = "gcp_cis_v200_s2_11_alert_policy_condition"
        condition_threshold {
          filter          = "metric.type=\"logging.googleapis.com/user/\$\{google_logging_metric.logging_metric_2_11.name\}\" AND resource.type=\"cloudsql_database\""
          duration        = "0s"
          comparison      = "COMPARISON_GT"
          threshold_value = 0
    
          aggregations {
            alignment_period     = "60s"
            per_series_aligner   = "ALIGN_RATE"
            cross_series_reducer = "REDUCE_COUNT"
            group_by_fields      = []
          }
        }
      }
    
      notification_channels = [
        google_monitoring_notification_channel.monitoring_notification_channel_2.id,
      ]
    
      documentation {
        content   = "Alert for Cloud SQL instance updates in the project"
        mime_type = "text/markdown"
      }
    
      user_labels = {
        severity = "critical"
      }
    
      enabled = true
    }
    EOT
}

# GCP > Project > Stack > Terraform Version
resource "turbot_policy_setting" "gcp_project_stack_terraform_version" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/projectStackTerraformVersion"
  note     = "GCP CIS v2.0.0 - Controls: 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 2.10 and 2.11"
  value    = "0.15.*"
}
