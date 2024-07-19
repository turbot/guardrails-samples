resource "turbot_policy_pack" "main" {
  title       = "Enforce Block Public Access for Ingress Rules for Ports 22 and -1 from 0.0.0.0/0, ::/0 in AWS VPC Security Groups"
  description = "Prevent unintended exposure of SSH (port 22) and all ports (-1) to the public internet for AWS VPC Security Groups."
  akas        = ["aws_vpc_enforce_block_public_access_for_security_groups"]
}
