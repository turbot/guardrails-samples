terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
  required_version = ">= 0.13"
}

provider "turbot" {
  profile = var.turbot_profile
}
# Smart Folder Definition
resource "turbot_smart_folder" "aws_waf_calc_smart_folder" {
  parent = "tmod:@turbot/turbot#/"
  title = var.smart_folder_title
  description = var.smart_folder_description
}

resource "turbot_policy_setting" "aws_wellarchitected_sec08" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec08"
  resource = turbot_smart_folder.aws_waf_calc_smart_folder.id
  value = "Enforce: Choices based on sub policies"
}


resource "turbot_policy_setting" "aws_wellarchitected_sec08KeyMgmt" {
  resource = turbot_smart_folder.aws_waf_calc_smart_folder.id
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec08KeyMgmt"
    template_input = <<EOT
{
  topsecret:resources(filter:"resourceTypeId:'tmod:@turbot/aws-kms#/resource/types/key' tags:'classification'='top-secret'")
  {
   metadata {
    stats {
      total
    }
  }
  }
  ultrasecret:resources(filter:"resourceTypeId:'tmod:@turbot/aws-kms#/resource/types/key' tags:'classification'='ultra-secret'")
  {
   metadata {
    stats {
      total
    }
  }
  }
}
EOT
  template = <<EOT
{% if $.topsecret.metadata.stats.total > 0 and $.ultrasecret.metadata.stats.total > 0 -%}
'True'
{% else -%}
'False'
{% endif -%}
EOT
}
