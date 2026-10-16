# AWS > VPC > Security Group > Ingress Rules > Approved
#
# Calculated policy: security groups tagged with the exception tag, or living
# in an account tagged with it, are skipped; all other security groups are
# checked (or enforced).
#
# Replace the exception tag key/value ("quad-zero" / "true") in the template
# below to match your organization's exception tag.
resource "turbot_policy_setting" "aws_vpc_security_security_group_ingress_rules_approved" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApproved"
  template_input = <<-EOT
    {
      securityGroup: resource {
        turbot {
          tags
        }
      }
      account {
        turbot {
          tags
        }
      }
    }
  EOT
  # For Phase 2 (automatic remediation), swap the value in the template's
  # else-branch below for the commented alternative.
  template = <<-EOT
    {%- set sgTags = $.securityGroup.turbot.tags or {} -%}
    {%- set accountTags = $.account.turbot.tags or {} -%}
    {%- if (sgTags["quad-zero"] | lower) == "true" or (accountTags["quad-zero"] | lower) == "true" -%}
    "Skip"
    {%- else -%}
    "Check: Approved"
    {# "Enforce: Delete unapproved" #}
    {%- endif -%}
  EOT
}

# AWS > VPC > Security Group > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_security_security_group_ingress_rules_approved_rules" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApprovedRules"
  value    = <<-EOT
    # Reject any ingress rule open to the entire internet (quad-zero)
    REJECT $.turbot.cidr:0.0.0.0/0,::/0

    # Or restrict specific ports only, e.g. SSH (22) and RDP (3389) from the internet
    # REJECT $.turbot.fromPort:=22 $.turbot.toPort:=22 $.turbot.cidr:0.0.0.0/0,::/0
    # REJECT $.turbot.fromPort:=3389 $.turbot.toPort:=3389 $.turbot.cidr:0.0.0.0/0,::/0

    # APPROVE unmatched rules
    APPROVE *
  EOT
}
