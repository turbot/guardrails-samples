provider "google" {
  # The credentials file location or alternatively set the environment variable below
  # export GOOGLE_CLOUD_KEYFILE_JSON={{path}}
  credentials = file("/Users/venu/Downloads/demo/key002.json")
  project     = var.gcp_project_id
  region      = var.gcp_region
}

resource "google_project_iam_custom_role" "my-custom-role" {
  count       = var.number_of_resources
  role_id     = "${var.resource_prefix}iam_custom_role_${count.index}"
  title       = "IAM Custom Role ${count.index}"
  description = "A description"
  stage       = "DISABLED"
  permissions = ["iam.roles.list"]
}

resource "google_service_account" "my-service-account" {
  count        = var.number_of_resources
  account_id   = "${replace(var.resource_prefix, "_", "-")}sa${count.index}"
  display_name = "Service Account ${count.index}"
  project      = var.gcp_project_id
}

resource "google_pubsub_topic" "my-pubsub-topic" {
  count = var.number_of_resources
  name  = "${var.resource_prefix}topic_${count.index}"
  labels = {
    foo = "bar"
  }
}

resource "google_storage_bucket" "my-storage-bucket" {
  count         = var.number_of_resources
  name          = "${var.resource_prefix}bucket_${count.index}"
  location      = var.gcp_region
  force_destroy = true
  labels = {
    foo = "bar"
  }
}
