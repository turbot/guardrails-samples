output "policy_pack_id" {
  value = module.policy_pack.policy_pack_id
}

output "pass_buckets" {
  description = "Buckets that should evaluate to Skip (no alarm)"
  value = {
    "test1_pattern_a"       = aws_s3_bucket.pass_pattern_a.id
    "test2_pattern_b"       = aws_s3_bucket.pass_pattern_b.id
    "test3_canonical"       = aws_s3_bucket.pass_canonical.id
    "test4_no_sid_str"      = aws_s3_bucket.pass_no_sid_string_principal.id
    "test5_principal_array" = aws_s3_bucket.pass_principal_array.id
    "test6_reversed_res"    = aws_s3_bucket.pass_reversed_resources.id
    "test7_mixed_stmts"     = aws_s3_bucket.pass_mixed_statements.id
  }
}

output "fail_buckets" {
  description = "Buckets that should evaluate to Check: Enabled (alarm expected)"
  value = {
    "test9_no_policy"       = aws_s3_bucket.fail_no_policy.id
    "test10_no_eit"         = aws_s3_bucket.fail_no_eit_statement.id
    "test12_allow_effect"   = aws_s3_bucket.fail_allow_effect.id
    "test13_narrow_action"  = aws_s3_bucket.fail_narrow_action.id
    "test14_objects_only"   = aws_s3_bucket.fail_objects_only.id
    "test15_specific_princ" = aws_s3_bucket.fail_specific_principal.id
    "test16_empty_stmts"    = aws_s3_bucket.fail_empty_statements.id
  }
}
