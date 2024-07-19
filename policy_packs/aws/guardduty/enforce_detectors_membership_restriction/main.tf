resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS GuardDuty Detectors Membership Restriction"
  description = "Ensure that only authorized activities are monitored, minimizing security risks and ensuring compliance with organizational policies."
  akas        = ["aws_guardduty_enforce_detectors_membership_restriction"]
}
