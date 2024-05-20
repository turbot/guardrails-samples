# Smart Folder Definition
resource "turbot_smart_folder" "aws_iam_access_keys_expiration" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# Below examples assume starting in Check mode to identify the impact.
# Can use the commented values to replace the template.
# Edit the template below to meet your requirements.

# Ensure your AWS IAM Access Keys are periodically rotated based on your company policies to avoid risk exposure. 
resource "turbot_policy_setting" "iam_user_access_key_active" {
  resource        = turbot_smart_folder.aws_iam_access_keys_expiration.id
  type            = "tmod:@turbot/aws-iam#/policy/types/accessKeyActive"
  value           = "Check: Active"
                    # Skip
                    # Check: Active
                    # Enforce: Delete inactive with 1 day warning
                    # Enforce: Delete inactive with 3 days warning
                    # Enforce: Delete inactive with 7 days warning
                    # Enforce: Delete inactive with 14 days warning
                    # Enforce: Delete inactive with 30 days warning
                    # Enforce: Delete inactive with 60 days warning
                    # Enforce: Delete inactive with 90 days warning
                    # Enforce: Delete inactive with 180 days warning
                    # Enforce: Delete inactive with 365 days warning
}

# Set the Age requirement; typically 90 days is reccomended in most security benchmarks
resource "turbot_policy_setting" "iam_user_access_key_active_age" {
  resource        = turbot_smart_folder.aws_iam_access_keys_expiration.id
  type            = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveAge"
  value           = "Force inactive if age > 90 days"
                    # Skip
                    # Force inactive if age > 1 day
                    # Force inactive if age > 3 days
                    # Force inactive if age > 7 days
                    # Force inactive if age > 14 days
                    # Force inactive if age > 30 days
                    # Force inactive if age > 60 days
                    # Force inactive if age > 90 days
                    # Force inactive if age > 180 days
                    # Force inactive if age > 365 days
}

# Can also consider using a Last Used Condition into the logic.
# Set the Last Used requirement to mark inactive if it has not been used within 60 days.
# Inconjunction with the Age conditions, would mean: if key has not been used in 60 days, or is 90 days old, mark inactive.
resource "turbot_policy_setting" "iam_user_access_key_active_recently_used" {
  resource        = turbot_smart_folder.aws_iam_access_keys_expiration.id
  type            = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveRecentlyUsed"
  value           = "Active if recently used <= 60 days"
                    # Skip
                    # Active if recently used <= 1 day
                    # Active if recently used <= 3 days
                    # Active if recently used <= 7 days
                    # Active if recently used <= 14 days
                    # Active if recently used <= 30 days
                    # Active if recently used <= 60 days
                    # Active if recently used <= 90 days
                    # Active if recently used <= 180 days
                    # Active if recently used <= 365 days
                    # Force active if recently used <= 1 day
                    # Force active if recently used <= 3 days
                    # Force active if recently used <= 7 days
                    # Force active if recently used <= 14 days
                    # Force active if recently used <= 30 days
                    # Force active if recently used <= 60 days
                    # Force active if recently used <= 90 days
                    # Force active if recently used <= 180 days
                    # Force active if recently used <= 365 days
}