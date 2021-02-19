#Loop through var.service_status and set disable policies
resource "turbot_policy_setting" "set_resource_cmdb_policies" {
  for_each        = var.resource_cmdb
  resource        = turbot_smart_folder.aws_cmdb.id
  type            = var.policy_map[each.key]
  value           = each.value
}
