# Determine the action to take when an AWS EC2 instances is not approved based on AWS > EC2 > Instance > Approved > * policies
# AWS > EC2 > Instance > Approved
resource "turbot_policy_setting" "ec2_instance_approved" {
    resource = turbot_smart_folder.ec2_approved.id
    type = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
    value = "Check: Approved"
}

# A list of instance types that AWS EC2 instances are approved to use.
# Examples include, "t3.*" (a family of instance types) and "m5.xlarge" (specific instance types)
# AWS > EC2 > Instance > Approved > Instance Types
resource "turbot_policy_setting" "ec2_instance_approved_types" {
   resource = turbot_smart_folder.ec2_instance_approved.id
   type = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedInstanceTypes"
   value = yamlencode(["t3.*", "m5.xlarge"])
}

# Determine whether the AWS EC2 instance is allowed to have a public IP address assigned.
# AWS > EC2 > Instance > Approved > Public IP
resource "turbot_policy_setting" "ec2_instance_approved_publicip" {
    resource = turbot_smart_folder.ec2_instance_approved.id
    type = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedPublicIp"
    value = "Approved if not assigned"
}