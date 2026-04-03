# ──────────────────────────────────────────────────────────────────────────────
# Policy pack in Check mode so alarms are visible without auto-remediation
# ──────────────────────────────────────────────────────────────────────────────

module "policy_pack" {
  source            = "../"
  enforcement_level = "Check: Enabled"
}

# Attach the policy pack to the Nashua test account
resource "turbot_policy_pack_attachment" "nashua" {
  resource    = "318995835878713"
  policy_pack = module.policy_pack.policy_pack_id
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

# ──────────────────────────────────────────────────────────────────────────────
# PASS buckets — should evaluate to "Skip" (effective EIT statement found)
# ──────────────────────────────────────────────────────────────────────────────

# Test 1: Pattern A — No Sid, Principal {"AWS": "*"} (60% of Truist alarms)
resource "aws_s3_bucket" "pass_pattern_a" {
  bucket        = "${var.test_prefix}-pass-pattern-a-${local.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "pass_pattern_a" {
  bucket = aws_s3_bucket.pass_pattern_a.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Deny"
      Principal = { AWS = "*" }
      Action    = "s3:*"
      Resource = [
        aws_s3_bucket.pass_pattern_a.arn,
        "${aws_s3_bucket.pass_pattern_a.arn}/*"
      ]
      Condition = { Bool = { "aws:SecureTransport" = "false" } }
    }]
  })
}

# Test 2: Pattern B — Sid "ForceHTTPSUse", Principal {"AWS": "*"} (40% of Truist alarms)
resource "aws_s3_bucket" "pass_pattern_b" {
  bucket        = "${var.test_prefix}-pass-pattern-b-${local.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "pass_pattern_b" {
  bucket = aws_s3_bucket.pass_pattern_b.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "ForceHTTPSUse"
      Effect    = "Deny"
      Principal = { AWS = "*" }
      Action    = "s3:*"
      Resource = [
        aws_s3_bucket.pass_pattern_b.arn,
        "${aws_s3_bucket.pass_pattern_b.arn}/*"
      ]
      Condition = { Bool = { "aws:SecureTransport" = "false" } }
    }]
  })
}

# Test 3: Canonical — Sid + Principal "*" (string)
resource "aws_s3_bucket" "pass_canonical" {
  bucket        = "${var.test_prefix}-pass-canonical-${local.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "pass_canonical" {
  bucket = aws_s3_bucket.pass_canonical.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "MustBeEncryptedInTransit"
      Effect    = "Deny"
      Principal = "*"
      Action    = "s3:*"
      Resource = [
        aws_s3_bucket.pass_canonical.arn,
        "${aws_s3_bucket.pass_canonical.arn}/*"
      ]
      Condition = { Bool = { "aws:SecureTransport" = "false" } }
    }]
  })
}

# Test 4: No Sid, Principal string "*"
resource "aws_s3_bucket" "pass_no_sid_string_principal" {
  bucket        = "${var.test_prefix}-pass-no-sid-str-${local.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "pass_no_sid_string_principal" {
  bucket = aws_s3_bucket.pass_no_sid_string_principal.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Deny"
      Principal = "*"
      Action    = "s3:*"
      Resource = [
        aws_s3_bucket.pass_no_sid_string_principal.arn,
        "${aws_s3_bucket.pass_no_sid_string_principal.arn}/*"
      ]
      Condition = { Bool = { "aws:SecureTransport" = "false" } }
    }]
  })
}

# Test 5: Principal as array {"AWS": ["*"]}
resource "aws_s3_bucket" "pass_principal_array" {
  bucket        = "${var.test_prefix}-pass-princ-arr-${local.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "pass_principal_array" {
  bucket = aws_s3_bucket.pass_principal_array.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "DenyInsecureTransport"
      Effect    = "Deny"
      Principal = { AWS = ["*"] }
      Action    = "s3:*"
      Resource = [
        aws_s3_bucket.pass_principal_array.arn,
        "${aws_s3_bucket.pass_principal_array.arn}/*"
      ]
      Condition = { Bool = { "aws:SecureTransport" = "false" } }
    }]
  })
}

# Test 6: Resources in reversed order
resource "aws_s3_bucket" "pass_reversed_resources" {
  bucket        = "${var.test_prefix}-pass-rev-res-${local.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "pass_reversed_resources" {
  bucket = aws_s3_bucket.pass_reversed_resources.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Deny"
      Principal = { AWS = "*" }
      Action    = "s3:*"
      Resource = [
        "${aws_s3_bucket.pass_reversed_resources.arn}/*",
        aws_s3_bucket.pass_reversed_resources.arn
      ]
      Condition = { Bool = { "aws:SecureTransport" = "false" } }
    }]
  })
}

# Test 7: Effective statement among other unrelated statements
resource "aws_s3_bucket" "pass_mixed_statements" {
  bucket        = "${var.test_prefix}-pass-mixed-${local.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "pass_mixed_statements" {
  bucket = aws_s3_bucket.pass_mixed_statements.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudTrail"
        Effect    = "Allow"
        Principal = { Service = "cloudtrail.amazonaws.com" }
        Action    = "s3:GetBucketAcl"
        Resource  = aws_s3_bucket.pass_mixed_statements.arn
      },
      {
        Effect    = "Deny"
        Principal = { AWS = "*" }
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.pass_mixed_statements.arn,
          "${aws_s3_bucket.pass_mixed_statements.arn}/*"
        ]
        Condition = { Bool = { "aws:SecureTransport" = "false" } }
      }
    ]
  })
}

# ──────────────────────────────────────────────────────────────────────────────
# FAIL buckets — should evaluate to "Check: Enabled" (alarm expected)
# ──────────────────────────────────────────────────────────────────────────────

# Test 9: No bucket policy at all
resource "aws_s3_bucket" "fail_no_policy" {
  bucket        = "${var.test_prefix}-fail-no-policy-${local.account_id}"
  force_destroy = true
}

# Test 10: Policy with no SecureTransport statement
resource "aws_s3_bucket" "fail_no_eit_statement" {
  bucket        = "${var.test_prefix}-fail-no-eit-${local.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "fail_no_eit_statement" {
  bucket = aws_s3_bucket.fail_no_eit_statement.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "AllowCloudTrail"
      Effect    = "Allow"
      Principal = { Service = "cloudtrail.amazonaws.com" }
      Action    = "s3:GetBucketAcl"
      Resource  = aws_s3_bucket.fail_no_eit_statement.arn
    }]
  })
}

# Test 11: Skipped — SecureTransport "true" creates a Deny-HTTPS policy that
# locks out the IAM user from reading the bucket policy back over HTTPS,
# causing Terraform to fail. This case is valid for template logic testing
# but cannot be provisioned via Terraform.

# Test 12: Effect "Allow" instead of "Deny"
# Bucket policy with Allow+Principal "*" is blocked by S3 Block Public Access,
# so this bucket is left without a policy (same fail outcome).
resource "aws_s3_bucket" "fail_allow_effect" {
  bucket        = "${var.test_prefix}-fail-allow-${local.account_id}"
  force_destroy = true
}

# Test 13: Action too narrow (s3:GetObject only)
resource "aws_s3_bucket" "fail_narrow_action" {
  bucket        = "${var.test_prefix}-fail-narrow-act-${local.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "fail_narrow_action" {
  bucket = aws_s3_bucket.fail_narrow_action.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Deny"
      Principal = { AWS = "*" }
      Action    = "s3:GetObject"
      Resource = [
        aws_s3_bucket.fail_narrow_action.arn,
        "${aws_s3_bucket.fail_narrow_action.arn}/*"
      ]
      Condition = { Bool = { "aws:SecureTransport" = "false" } }
    }]
  })
}

# Test 14: Resource only covers objects, not bucket
resource "aws_s3_bucket" "fail_objects_only" {
  bucket        = "${var.test_prefix}-fail-obj-only-${local.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "fail_objects_only" {
  bucket = aws_s3_bucket.fail_objects_only.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Deny"
      Principal = { AWS = "*" }
      Action    = "s3:*"
      Resource  = "${aws_s3_bucket.fail_objects_only.arn}/*"
      Condition = { Bool = { "aws:SecureTransport" = "false" } }
    }]
  })
}

# Test 15: Principal is a specific account, not "everyone"
# AWS rejects fake account ARNs as invalid principals, so this bucket is left
# without a policy (same fail outcome — no effective EIT statement).
resource "aws_s3_bucket" "fail_specific_principal" {
  bucket        = "${var.test_prefix}-fail-spec-princ-${local.account_id}"
  force_destroy = true
}

# Test 16: Empty policy (no statements)
# AWS rejects empty Statement arrays, so this bucket is left without a policy.
resource "aws_s3_bucket" "fail_empty_statements" {
  bucket        = "${var.test_prefix}-fail-empty-stmt-${local.account_id}"
  force_destroy = true
}
