# Create smart folder for policies
resource "turbot_smart_folder" "turbot_iam_roles" {
    title       = var.smart_folder_title
    description = "Create Turbot IAM roles as well as checking for boundary policies"
    parent      = "tmod:@turbot/turbot#/"
}

# Create Turbot IAM Roles
# AWS > Turbot > Permissions
resource "turbot_policy_setting" "turbot_permissions_iam" {
    resource = turbot_smart_folder.turbot_iam_roles.id
    type = "tmod:@turbot/aws-iam#/policy/types/permissions"
    value = "Enforce: Role Mode"
}

# Set Turbot IAM Roles Levels
# AWS > Turbot > Permissions > Levels
resource "turbot_policy_setting" "turbot_permissions_iamlevels" {
    resource = turbot_smart_folder.turbot_iam_roles.id
    type = "tmod:@turbot/aws-iam#/policy/types/permissionsLevels"
    value = yamlencode(["AWS/User","AWS/Metadata","AWS/Readonly","AWS/Operator","AWS/Admin","AWS/Owner","AWS/SuperUser"])
}


### Boundary / Lockdowns

# Boundary for Roles
# AWS > IAM > Role > Boundary
resource "turbot_policy_setting" "turbot_role_boundary_iam" {
    resource = turbot_smart_folder.turbot_iam_roles.id
    type = "tmod:@turbot/aws-iam#/policy/types/roleBoundary"
    value = "Check: Boundary > Policy"
}

# Boundary for Users
# AWS > IAM > Users > Boundary
resource "turbot_policy_setting" "turbot_user_boundary_iam" {
    resource = turbot_smart_folder.turbot_iam_roles.id
    type = "tmod:@turbot/aws-iam#/policy/types/userBoundary"
    value = "Check: Boundary > Policy"
}