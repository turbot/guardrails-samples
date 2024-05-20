# List of services and resources to be Check: Approved.
# Started with a few resource types to get started aligned with the initial mods installed
# You can remove the comment per row to include the resource type.  Make sure you have the related service mod installed

# NOTE: For full list of values, look in variables.tf at the default value
resource_approved_regions = {
  aws-ec2-ami                     = "Check: Approved"
  aws-ec2-applicationLoadBalancer = "Check: Approved"
  aws-ec2-classicLoadBalancer     = "Check: Approved"
  aws-ec2-instance                = "Check: Approved"
  aws-ec2-keyPair                 = "Check: Approved"
  aws-ec2-networkLoadBalancer     = "Check: Approved"
  aws-ec2-snapshot                = "Check: Approved"
  aws-ec2-volume                  = "Check: Approved"
  aws-lambda-function             = "Check: Approved"
  aws-s3-bucket                   = "Check: Approved"
  aws-vpc-security-securityGroup  = "Check: Approved"
  aws-vpc-core-vpc                = "Check: Approved"
}

# NOTE: For full list of values, look in variables.tf at the default value
resource_approved_regions_region_list = [
  "us-east-1",
  "us-east-2",
]
