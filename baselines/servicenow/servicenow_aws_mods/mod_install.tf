# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-aws
resource "turbot_mod" "servicenow-aws" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "servicenow-aws"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "servicenow-aws") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-aws-cloudtrail
resource "turbot_mod" "servicenow-aws-cloudtrail" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-aws]
  org        = "turbot"
  mod        = "servicenow-aws-cloudtrail"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-aws-cloudtrail") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-aws-cloudwatch
resource "turbot_mod" "servicenow-aws-cloudwatch" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-aws]
  org        = "turbot"
  mod        = "servicenow-aws-cloudwatch"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-aws-cloudwatch") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-aws-ec2
resource "turbot_mod" "servicenow-aws-ec2" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-aws]
  org        = "turbot"
  mod        = "servicenow-aws-ec2"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-aws-ec2") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-aws-iam
resource "turbot_mod" "servicenow-aws-iam" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-aws]
  org        = "turbot"
  mod        = "servicenow-aws-iam"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-aws-iam") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-aws-kms
resource "turbot_mod" "servicenow-aws-kms" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-aws]
  org        = "turbot"
  mod        = "servicenow-aws-kms"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-aws-kms") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-aws-rds
resource "turbot_mod" "servicenow-aws-rds" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-aws]
  org        = "turbot"
  mod        = "servicenow-aws-rds"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-aws-rds") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-aws-s3
resource "turbot_mod" "servicenow-aws-s3" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-aws]
  org        = "turbot"
  mod        = "servicenow-aws-s3"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-aws-s3") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-aws-vpc-connect
resource "turbot_mod" "servicenow-aws-vpc-connect" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-aws]
  org        = "turbot"
  mod        = "servicenow-aws-vpc-connect"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-aws-vpc-connect") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-aws-vpc-core
resource "turbot_mod" "servicenow-aws-vpc-core" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-aws]
  org        = "turbot"
  mod        = "servicenow-aws-vpc-core"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-aws-vpc-core") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-aws-vpc-internet
resource "turbot_mod" "servicenow-aws-vpc-internet" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-aws]
  org        = "turbot"
  mod        = "servicenow-aws-vpc-internet"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-aws-vpc-internet") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-aws-vpc-security
resource "turbot_mod" "servicenow-aws-vpc-security" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-aws]
  org        = "turbot"
  mod        = "servicenow-aws-vpc-security"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-aws-vpc-security") ? 1 : 0
}
