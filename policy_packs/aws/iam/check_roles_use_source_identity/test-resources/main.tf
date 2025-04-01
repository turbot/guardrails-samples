terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# 1. Correct Role with Two Distinct Statements
resource "aws_iam_role" "correct" {
  name = "correct_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::111222333444:saml-provider/azprod"
        },
        "Action": "sts:AssumeRoleWithSAML",
        "Condition": {
          "StringEquals": {
            "SAML:aud": "https://signin.aws.amazon.com/saml"
          }
        }
      },
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::111222333444:saml-provider/azprod"
        },
        "Action": "sts:SetSourceIdentity",
        "Condition": {
          "StringEquals": {
            "SAML:aud": "https://signin.aws.amazon.com/saml"
          }
        }
      }
    ]
  })
}

# 2. Role Without Either Statement
resource "aws_iam_role" "missing_both" {
  name = "missing_both_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# 3. Role Missing the AssumeRoleWithSAML Statement
resource "aws_iam_role" "missing_assume_role_with_saml" {
  name = "missing_assume_role_with_saml_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::111222333444:saml-provider/azprod"
        },
        "Action": "sts:SetSourceIdentity",
        "Condition": {
          "StringEquals": {
            "SAML:aud": "https://signin.aws.amazon.com/saml"
          }
        }
      }
    ]
  })
}

# 4. Role Missing the STS-SetSourceIdentity Statement
resource "aws_iam_role" "missing_set_source_identity" {
  name = "missing_set_source_identity_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::111222333444:saml-provider/azprod"
        },
        "Action": "sts:AssumeRoleWithSAML",
        "Condition": {
          "StringEquals": {
            "SAML:aud": "https://signin.aws.amazon.com/saml"
          }
        }
      }
    ]
  })
}

# 5. Role with Both Actions in a Single Statement
resource "aws_iam_role" "combined" {
  name = "combined_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::111222333444:saml-provider/azprod"
        },
        "Action": [
          "sts:AssumeRoleWithSAML",
          "sts:SetSourceIdentity"
        ],
        "Condition": {
          "StringEquals": {
            "SAML:aud": "https://signin.aws.amazon.com/saml"
          }
        }
      }
    ]
  })
}