resource "google_pubsub_topic" "turbot_test_demo" {
  name = "turbot_test_demo_topic"
}

resource "google_pubsub_subscription" "turbot_test_demo" {
  name                       = "turbot_test_demo_subscription"
  topic                      = google_pubsub_topic.turbot_test_demo.name
  message_retention_duration = "1000s"
  retain_acked_messages      = true
  ack_deadline_seconds       = 20

  expiration_policy {
    ttl = "300000.5s"
  }
}

resource "google_pubsub_topic_iam_member" "pubsubpublisher" {
  topic  = google_pubsub_topic.turbot_test_demo.name
  role   = "roles/pubsub.publisher"
  member = "allAuthenticatedUsers"
}
