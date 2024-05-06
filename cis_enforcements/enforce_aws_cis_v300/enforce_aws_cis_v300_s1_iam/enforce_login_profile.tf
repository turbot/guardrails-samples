# AWS > IAM > User > Login Profile 
resource "turbot_policy_setting" "aws_iam_user_login_profile" {
  resource       = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type           = "tmod:@turbot/aws-iam#/policy/types/userLoginProfile"
  template_input = <<-EOT
    {
      value: constant(value: "Check: Login profile enabled")
      #value: constant(value: "Enforce: Delete login profile")
      user {
        children(filter:[
            "resourceTypeId:'tmod:@turbot/aws-iam#/resource/types/accessKey'",
            "level:self"
          ]){
          items {
            status: get(path:"Status")
          }
        }
        UserName
        parent {
          children(filter:[
            "resourceTypeId:'tmod:@turbot/aws-iam#/resource/types/mfaVirtual'",
            "level:self",
            "limit:2000"
          ]) {
            items {
              mfa_user: get(path:"User.UserName")
            }
          }
        }
      }
    }
    EOT
  template       = <<-EOT
    {%- set has_mfa = false -%}
    {%- set has_key = false -%}
    {# Check for MFA - AWS CIS 3.0.0 - 1.10 #}
    {%- for mfa in $.user.parent.children.items -%}
      {%- if mfa.mfa_user == $.user.UserName -%}
        {%- set has_mfa = true -%}
      {%- endif -%}
    {%- endfor -%}
    {# Check for Access Keys - AWS CIS 3.0.0 - 1.11 #}
    {%- for key in $.user.children.items -%}
      {%- if key.status == "Active" -%}
        {%- set has_key = true -%}
      {%- endif -%}
    {%- endfor -%}
    {# Result #}
    {%- if (not has_mfa) or has_key -%}
      {{ $.value | json }}
    {%- else -%}
      Skip
    {%- endif -%}
    EOT
  note     = "AWS CIS v3.0.0 - Controls: 1.10 & 1.11"
}