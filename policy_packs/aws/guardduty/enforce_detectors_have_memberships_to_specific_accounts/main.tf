resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS GuardDuty Detectors Have Membership Only to Specific Accounts"
  description = "Ensure that GuardDuty findings and data are shared only with authorized accounts, enhancing security by preventing unauthorized access to sensitive security information."
  akas        = ["aws_guardduty_enforce_detectors_have_memberships_to_specific_accounts"]
}
