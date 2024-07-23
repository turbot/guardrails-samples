resource "turbot_policy_setting" "gcp_enable" {
  count       = length(var.service_status)
  resource    = var.target_resource
  type        = "tmod:@turbot/${element(keys(var.service_status), count.index)}#/policy/types/${lookup(var.policy_map, "${element(keys(var.service_status), count.index)}")}"
  value       = "${lookup(var.service_status, "${element(keys(var.service_status), count.index)}")}"
}

resource "turbot_policy_setting" "gcp_api_enable" {
  count       = length(var.service_status)
  resource    = var.target_resource
  type        = "tmod:@turbot/${element(keys(var.service_status), count.index)}#/policy/types/${lookup(var.api_policy_map, "${element(keys(var.service_status), count.index)}")}"
  value       = "Enforce: ${lookup(var.service_status, "${element(keys(var.service_status), count.index)}")}"
}
