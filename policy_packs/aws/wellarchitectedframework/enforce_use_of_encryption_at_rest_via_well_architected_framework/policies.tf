resource "turbot_policy_setting" "aws_wellarchitectedtool_wellarchitectedframework_security_sec08" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec08"
  resource = turbot_policy_pack.main.id
  value    = "Check: Choices based on sub policies"
  # value    = "Enforce: Choices based on sub policies"
}


resource "turbot_policy_setting" "aws_wellarchitectedtool_wellarchitectedframework_security_sec08_encrypt" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec08Encrypt"
  resource = turbot_policy_pack.main.id
  template_input = <<-EOT
  {
    alarms:controls(filter: "state:alarm controlCategoryId:'tmod:@turbot/turbot#/control/categories/resourceEncryptionAtRest','tmod:@turbot/turbot#/control/categories/resourceEncryptionInTransit'") { 
      metadata {
        stats {
          total
        }
      }
    }
    ok:controls(filter: "state:ok controlCategoryId:'tmod:@turbot/turbot#/control/categories/resourceEncryptionAtRest','tmod:@turbot/turbot#/control/categories/resourceEncryptionInTransit'") { 
      metadata {
        stats {
          total
        }
      }
    }
  }
  EOT
  template = <<-EOT
  {% if $.alarms.metadata.stats.total > 0 and $.ok.metadata.stats.total > 0 -%}
      'True'
  {% else -%}
      'False'
  {% endif -%}
  EOT
}