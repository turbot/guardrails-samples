resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP VPC Network Firewall Rules With Range Of Ports To Not Allow Incoming Traffic"
  description = "Ensure that only necessary and specific ports are open for inbound traffic, minimizing the risk of unauthorized access and potential attacks."
  parent      = "tmod:@turbot/turbot#/"
}
