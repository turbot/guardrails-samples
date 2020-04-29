resource "turbot_policy_setting" "provider_registration_enable" {
  count    = length(var.provider_status)
  resource = var.target_resource
  type     = "tmod:@turbot/azure-provider#/policy/types/${lookup(var.provider_registration_map, "${element(keys(var.provider_status), count.index)}")}"
  value    = lookup(var.provider_status, "${element(keys(var.provider_status), count.index)}")
}
