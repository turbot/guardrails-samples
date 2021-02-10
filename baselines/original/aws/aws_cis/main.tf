#### Configures the provider to use a specific profile, otherwise the provider will use the default profile
provider "turbot" {
  profile = "trailblazer"
}

resource "turbot_smart_folder" "aws_cis_enumerated" {
  title = "CISv1 Enumerated Policies"
  description = "Create a smart folder to apply the Turbot Trail policy settings"
  parent = "tmod:@turbot/turbot#/"
}

//https://turbot.com/v5/mods/turbot/aws-cisv1/inspect#/policy/types/attestation
resource "turbot_policy_setting" "aws_cis_max_attestation_period" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/attestation"
  value = "1 year"
  //     Skip
  //30 days
  //60 days
  //90 days
  //1 year
  //2 years
  //3 years
}

resource "turbot_policy_setting" "aws_cis" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/cis"
  value = "Skip"
  count      = var.full_cis ? 0 : 1
  //  Skip
  //Check: Level 1 (Scored)
  //Check: Level 1 (Scored & Not Scored)
  //Check: Level 1 & Level 2 (Scored)
  //Check: Level 1 & Level 2 (Scored & Not Scored)
}

resource "turbot_policy_setting" "aws_cis_r0101" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0101"
  value = "Check: Level 1 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0102" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0102"
  value = "Check: Level 1 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0103" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0103"
  value = "Check: Level 1 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0104" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0104"
  value = "Check: Level 1 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0105" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0105"
  value = "Check: Level 1 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0106" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0106"
  value = "Check: Level 1 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0107" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0107"
  value = "Check: Level 1 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0108" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0108"
  value = "Check: Level 1 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0109" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0109"
  value = "Check: Level 1 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0110" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0110"
  value = "Check: Level 1 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0111" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0111"
  value = "Check: Level 1 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0112" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0112"
  value = "Check: Level 1 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0113" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0113"
  value = "Check: Level 1 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0114" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0114"
  value = "Check: Level 2 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0115" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0115"
  value = "Check: Level 1 (Not Scored) using attestation"
  count      = var.full_cis ? 1 : 0
}

// https://turbot.com/v5/mods/turbot/aws-cisv1/inspect#/policy/types/r0115Attestation
// The format should be a date-time.  As the data cannot be programmatically verified, this should be done manually.
// resource "turbot_policy_setting" "aws_cis_r0115Attestation" {
//   resource = turbot_smart_folder.aws_cis_enumerated.id
//   type = "tmod:@turbot/aws-cisv1#/policy/types/r0115Attestation"
//   value = ""
//   count      = var.full_cis ? 1 : 0
// }

resource "turbot_policy_setting" "aws_cis_r0116" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0116"
  value = "Check: Level 1 (Scored)"
  count      = var.full_cis ? 1 : 0
}

resource "turbot_policy_setting" "aws_cis_r0117" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0117"
  value = "Check: Level 1 (Not Scored) using attestation"
  count      = var.full_cis ? 1 : 0
}

// The format should be a date-time.  As the data cannot be programmatically verified, this should be done manually.
// resource "turbot_policy_setting" "aws_cis_r0117Attestation" {
//   resource = turbot_smart_folder.aws_cis_enumerated.id
//   type = "tmod:@turbot/aws-cisv1#/policy/types/r0117Attestation"
// }

resource "turbot_policy_setting" "aws_cis_r0118" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0118"
  value = "Check: Level 1 (Not Scored) using attestation"
  count      = var.full_cis ? 1 : 0
}

// The format should be a date-time.  As the data cannot be programmatically verified, this should be done manually.
// resource "turbot_policy_setting" "aws_cis_r0118Attestation" {
//   resource = turbot_smart_folder.aws_cis_enumerated.id
//   type = "tmod:@turbot/aws-cisv1#/policy/types/r0118Attestation"
// }

resource "turbot_policy_setting" "aws_cis_r0119" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0119"
  value = "Check: Level 2 (Not Scored) using attestation"
}

// The format should be a date-time.  As the data cannot be programmatically verified, this should be done manually.
// resource "turbot_policy_setting" "aws_cis_r0119Attestation" {
//   resource = turbot_smart_folder.aws_cis_enumerated.id
//   type = "tmod:@turbot/aws-cisv1#/policy/types/r0119Attestation"
// }

resource "turbot_policy_setting" "aws_cis_r0121" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0121"
  value = "Check: Level 1 (Not Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0122" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0122"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0201" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0201"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0202" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0202"
  value = "Check: Level 2 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0203" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0203"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0204" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0204"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0205" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0205"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0206" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0206"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0207" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0207"
  value = "Check: Level 2 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0208" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0208"
  value = "Check: Level 2 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0209" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0209"
  value = "Check: Level 2 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0301" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0301"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0302" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0302"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0303" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0303"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0304" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0304"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0305" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0305"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0306" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0306"
  value = "Check: Level 2 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0307" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0307"
  value = "Check: Level 2 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0308" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0308"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0309" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0309"
  value = "Check: Level 2 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0310" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0310"
  value = "Check: Level 2 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0311" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0311"
  value = "Check: Level 2 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0312" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0312"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0313" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0313"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0314" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0314"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0401" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0401"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0402" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0402"
  value = "Check: Level 1 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0403" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0403"
  value = "Check: Level 2 (Scored)"
}

resource "turbot_policy_setting" "aws_cis_r0404" {
  resource = turbot_smart_folder.aws_cis_enumerated.id
  type = "tmod:@turbot/aws-cisv1#/policy/types/r0404"
  value = "Check: Level 2 (Not Scored) using attestation"
}

// The format should be a date-time.  As the data cannot be programmatically verified, this should be done manually.
// resource "turbot_policy_setting" "aws_cis_r0404Attestation" {
//   resource = turbot_smart_folder.aws_cis_enumerated.id
//   type = "tmod:@turbot/aws-cisv1#/policy/types/r0404Attestation"
//   value = ""
// }
//