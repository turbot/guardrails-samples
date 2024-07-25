resource "turbot_policy_pack" "main" {
  title       = "Enforce Removal of Common Admin Ports Open to the Internet for AWS VPC Security Groups"
  description = "This measure reduces the risk of unauthorized access, data breaches, and compromising the integrity of the cloud infrastructure by ensuring admin ports (e.g., 22, 3389) are not open to the internet."
  akas        = ["aws_vpc_enforce_removal_of_common_admin_ports_open_to_internet_for_security_groups"]
}

