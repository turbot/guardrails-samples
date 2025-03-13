# AWS > S3 > Bucket > Configured
resource "turbot_policy_setting" "bucket_configured" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketConfigured"
  value    = "Check: Per Configured > Source (unless claimed by a stack)"
  # value    = "Enforce: Per Configured > Source (unless claimed by a stack)"
}

# AWS > S3 > Bucket > Configured > Source
resource "turbot_policy_setting" "bucket_configured_source" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketConfiguredSource"
  # Define the Terraform configuration to add replication configuration
  value    = <<EOT
# This template configures S3 bucket replication
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Get the existing bucket name from the resource metadata
locals {
  # Extract bucket name from the resource metadata
  bucket_name = turbot.resource.bucketName
  
  # Define target bucket and region for replication
  # Note: In a real scenario, these would be defined by the customer or pulled from policy settings
  target_bucket_name = "${local.bucket_name}-replica"
  target_region      = "us-west-2"
}

# Create an IAM role for replication
resource "aws_iam_role" "replication" {
  name = "s3-replication-role-${local.bucket_name}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
POLICY
}

# Create an IAM policy for the replication role
resource "aws_iam_policy" "replication" {
  name = "s3-replication-policy-${local.bucket_name}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${local.bucket_name}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersionForReplication",
        "s3:GetObjectVersionAcl",
        "s3:GetObjectVersionTagging"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${local.bucket_name}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete",
        "s3:ReplicateTags"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${local.target_bucket_name}/*"
    }
  ]
}
POLICY
}

# Attach the replication policy to the role
resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

# Configure the source bucket for replication
resource "aws_s3_bucket_replication_configuration" "replication" {
  # Role used by S3 for replication
  role   = aws_iam_role.replication.arn
  bucket = local.bucket_name

  rule {
    id     = "ReplicateAll"
    status = "Enabled"

    destination {
      bucket        = "arn:aws:s3:::${local.target_bucket_name}"
      storage_class = "STANDARD"
    }
  }
}
EOT
}
