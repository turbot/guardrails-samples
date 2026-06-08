# OpenAI > Organization > ZDR Status
resource "turbot_policy_setting" "openai_organization_zdr_status" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/openai#/policy/types/zdrStatus"
  value    = "Check: Enabled"
}

# OpenAI > Organization > ZDR Status > ZDR Status Attested
#
# No Admin API endpoint exposes ZDR state, so this control cannot auto-verify. After
# you have configured Zero Data Retention and Modified Abuse Monitoring with OpenAI,
# an operator should set this value to `true` to attest that the organization is compliant.
resource "turbot_policy_setting" "openai_organization_zdr_status_attested" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/openai#/policy/types/zdrStatusAttested"
  value    = false
}
