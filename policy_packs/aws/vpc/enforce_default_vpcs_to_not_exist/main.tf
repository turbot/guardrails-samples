resource "turbot_policy_pack" "main" {
  title       = "Enforce Default AWS VPCs To Not Exist"
  description = "This measure ensure that all VPCs are created with custom configurations tailored to their security policies and operational needs, reducing the risk of unintended exposure or misconfiguration."
  akas        = ["aws_vpc_enforce_default_vpcs_to_not_exist"]
}
