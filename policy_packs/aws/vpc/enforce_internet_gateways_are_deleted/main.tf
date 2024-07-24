resource "turbot_policy_pack" "main" {
  title       = "policy_packs/aws/vpc/enforce_enable_flow_logging_to_s3_buckets_is_enabled_for_vpcs"
  description = "This measure minimizes the attack surface, reduces the risk of unauthorized access and potential data breaches, and ensures that all external connectivity is tightly controlled and monitored through alternative, more secure methods."
  akas        = ["aws_vpc_enforce_internet_gateways_are_deleted"]
}
