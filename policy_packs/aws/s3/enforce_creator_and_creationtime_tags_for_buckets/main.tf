resource "turbot_policy_pack" "main" {
  title       = "Enforce Creator and Creation Time Tags for AWS S3 Buckets"
  description = "Enforcing the use of Creator and Creation Time tags provides critical metadata that helps in identifying the origin and creation time of S3 buckets."
  akas        = ["aws_s3_enforce_creator_and_creationtime_tags_for_buckets"]
}
