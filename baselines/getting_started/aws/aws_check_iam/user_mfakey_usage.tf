# IAM users must have MFA keys associated
# AWS > IAM > User > Approved
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/userApproved
resource "turbot_policy_setting" "iam_user_mfa_approved" {
  resource        = turbot_smart_folder.aws_iam.id
  type            = "tmod:@turbot/aws-iam#/policy/types/userApproved"
  value           = "Check: Approved"
}

# AWS > IAM > User > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/userApprovedUsage
resource "turbot_policy_setting" "iam_user_mfa_approved_usage" {
  resource        = turbot_smart_folder.aws_iam.id
  type            = "tmod:@turbot/aws-iam#/policy/types/userApprovedUsage"
  # GraphQL to pull info from IAM User and MFA virtual keys
  template_input  = <<-QUERY
	{
		user{
			Arn
			UserName
			}
	resources(filter:"resourceType:'tmod:@turbot/aws-iam#/resource/types/mfaVirtual'") {
		items {
			usertest: get(path:"User.UserName")
			trunk {
				title
				}
			}
		}
	}
QUERY
  # Nunjucks template to set usage approval based on user and MFA key matching
  template        = <<-TEMPLATE
	{%- set matches = false -%}
	{%- for v in $.resources.items -%}
		{%- if v.usertest == $.user.UserName -%}
		{%- set matches = true -%}
		{%- endif -%}
	{%- endfor -%}
	{%- if matches -%}
	"Approved"
	{%- else -%}
	"Not approved"
	{%- endif -%}
TEMPLATE
}