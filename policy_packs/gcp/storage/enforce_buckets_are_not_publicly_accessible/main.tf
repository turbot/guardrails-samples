resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Storage Buckets Are Not Publicly Accessible"
  description = "Ensure that only authorized users and applications can access the data, reducing the risk of data breaches and maintaining compliance."
  akas        = ["gcp_storage_enforce_buckets_are_not_publicly_accessible"]
}
