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


resource "turbot_policy_setting" "aws_wellarchitected_sec08Encrypt" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec08Encrypt"
  resource = turbot_smart_folder.aws_waf_calc_smart_folder.id
  template_input = <<EOT
{
  alarms:controls(filter: "state:alarm controlCategoryId:'tmod:@turbot/turbot#/control/categories/resourceEncryptionAtRest','tmod:@turbot/turbot#/control/categories/resourceEncryptionInTransit'")
  { metadata
    {stats
      {
      	total
    	}
    }
  }
  ok:controls(filter: "state:ok controlCategoryId:'tmod:@turbot/turbot#/control/categories/resourceEncryptionAtRest','tmod:@turbot/turbot#/control/categories/resourceEncryptionInTransit'")
  { metadata
    {stats
      {
      	total
    	}
    }
  }
}
EOT
  template = <<EOT
{% if $.alarms.metadata.stats.total > 0 and $.ok.metadata.stats.total > 0 -%}
'True'
{% else -%}
'False'
{% endif -%}
EOT
}