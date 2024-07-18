resource "turbot_policy_setting" "aws_wellarchitectedtool_wellarchitectedframework_security_sec08" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec08"
  resource = turbot_policy_pack.main.id
  value    = "Check: Choices based on sub policies"
  # value    = "Enforce: Choices based on sub policies"
}


resource "turbot_policy_setting" "aws_wellarchitectedtool_wellarchitectedframework_security_sec08_key_mgmt" {
  resource = turbot_smart_folder.aws_waf_calc_smart_folder.id
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec08KeyMgmt"
  template_input = <<-EOT
  {
    topsecret:resources(filter:"resourceTypeId:'tmod:@turbot/aws-kms#/resource/types/key' tags:'classification'='top-secret'") {
      metadata {
        stats {
          total
        }
      }
    }
    ultrasecret:resources(filter:"resourceTypeId:'tmod:@turbot/aws-kms#/resource/types/key' tags:'classification'='ultra-secret'") {
      metadata {
        stats {
          total
        }
      }
    }
  }
  EOT
  template = <<-EOT
  {% if $.topsecret.metadata.stats.total > 0 and $.ultrasecret.metadata.stats.total > 0 -%}
      'True'
  {% else -%}
      'False'
  {% endif -%}
  EOT
}